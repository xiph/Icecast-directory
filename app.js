var express         = require('express'),
    query           = require('pg-query'),
    swig            = require('swig'),
    morgan          = require('morgan'),
    cache_manager   = require('cache-manager'),
    bodyParser      = require('body-parser'),
    qs              = require('qs'),
    conf            = require('konphyg')(__dirname + '/config'),
    validator       = require('validator'),
    xmlbuilder      = require('xmlbuilder');
    querystring     = require('querystring');


var cache           = cache_manager.caching({store: "memory", max: 100, ttl: 10});
var app             = express();
var config          = conf.all().config;

/* Controllers */
var streamsFindBy   = require('./controllers/stream-api.js')(query, cache);
var streamFindById  = require('./controllers/stream-by-id.js')(query, cache);
var index           = require('./controllers/index.js')(query, cache, streamsFindBy);
var genres          = require('./controllers/genres.js')(query, cache, streamsFindBy);
var formats         = require('./controllers/formats.js')(query, cache, streamsFindBy);
var yp_cgi          = require('./controllers/yp-cgi.js')(query, qs, validator, config);
var listen          = require('./controllers/listen.js')(query, qs, xmlbuilder, streamFindById);




query.connectionParameters = config.db;

swig.setDefaults({ cache: (process.env.NODE_ENV === 'production') ? true : false });

/* Middlewares */
app.use(morgan((process.env.NODE_ENV === 'production') ? 'short' : 'dev'));
app.use(bodyParser.urlencoded({ extended: true }));
app.use('/assets', express.static(__dirname + '/assets'));

app.engine('html', swig.renderFile);

app.set('view engine', 'html');
app.set('views', __dirname + '/views');

/* Website Routes */
app.get('/', index);
app.post('/cgi-bin/yp-cgi', yp_cgi);
app.get('/by_genre/:genre', genres);
app.get('/by_format/:format', formats);
app.get('/listen/:streamId/:filename',listen);

// allows updated ban lists to be reloaded
app.get('/reloadconfig/:password',function(req, res) {
    // so not everyone can reload the config file
    if(req.params.password == config.bansreloadpassword) {
        // clear config and reload it
        conf.clear();
        config = conf.all().config;
        res.send("Config reloaded");
    } else {
        res.status(401);
        res.send("Wrong password");
    }
});

/* JSON API */
function respond(res, err, rows, result) {
    if(err) {
        res.send([]);
    } else {
        res.send(rows);
    }
}
app.get('/streams/', function(req,res){
    res.set('Content-Type', 'application/json');
    var params = req.query;
    var json = 1;
    streamsFindBy(params.format, params.genre, params.q, params.order, params.limit, params.starting_after, params.ending_before, json, function(err, rows){
        if(err) {
            if(err.responsecode) {
                res.status(err.responsecode);
            } else {
                res.status(400);
            }
            res.send({"error":err.message});
        } else {
            var result = rows[0];
            if(result.streams == null) {
                result.streams = [];
            }
            result.data = {};

            if(params.limit) {
                var starting_after = params.starting_after;
                var ending_before = params.ending_before;
                var limit = params.limit;

                var qstring;
                if(result.streams.length == limit) {
                    // delete the previous values
                    delete params.starting_after;
                    delete params.ending_before;

                    // add in the new values
                    var last_id = rows[0].streams[result.streams.length-1].id;
                    params.starting_after = last_id;
                    qstring = querystring.stringify(params);
                    result.data.next_url = req.path+'?'+qstring;
                    delete params.starting_after;
                    params.ending_before = prev_id;
                    qstring = querystring.stringify(params);
                    result.data.prev_url = req.path+'?'+qstring;
                }
            }
            res.send(result);
        }
    });
});
app.get('/streams/:streamId', function(req,res){
    res.set('Content-Type', 'application/json');
    streamFindById(req.params.streamId, 1, function(err,rows,result){
        if(err || rows[0].array_to_json == null) {
            res.status(404);
            res.send({});
        } else {
            res.send(rows[0].array_to_json[0]);
        }
    });
});
app.get('/genres/', function(req, res) {
    res.set('Content-Type', 'application/json');
    var genresq = 'SELECT DISTINCT val FROM (SELECT unnest(genres) as val FROM streams) s;';
    query(genresq, function(err, rows, result) {
        respond(res, err, rows, result);
    });
});

app.get('/formats/', function(req, res) {
    res.set('Content-Type', 'application/json');
    var formats = 'SELECT DISTINCT val FROM (SELECT unnest(codec_sub_types) as val FROM streams) s;';
    query(formats, function(err, rows, result) {
        respond(res, err, rows, result);
    });
});


var server = app.listen(3000, function() {
    console.log('Listening on port %d', server.address().port);
});

process.on('SIGINT', function() {
    server.close();
    process.exit();
});

/*
var interval = setInterval(deleteOldServers, 240000, 4);
function deleteOldServers(time, cb) {
    query('DELETE FROM servers WHERE lasttouch < NOW() - INTERVAL \'' + time.toString() + ' minutes\';', cb);
}
*/

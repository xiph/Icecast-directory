var express         = require('express'),
    query           = require('pg-query'),
    swig            = require('swig'),
    morgan          = require('morgan'),
    cache_manager   = require('cache-manager'),
    bodyParser      = require('body-parser'),
    qs              = require('qs'),
    conf            = require('konphyg')(__dirname + '/config'),
    validator       = require('validator');

var cache           = cache_manager.caching({store: "memory", max: 100, ttl: 10});
var app             = express();
var config          = conf('config');


/* Controllers */
var streamApi       = require('./controllers/stream-api.js')(query, cache);
var index           = require('./controllers/index.js')(query, cache, streamApi);
var genres          = require('./controllers/genres.js')(query, cache, streamApi);
var formats         = require('./controllers/formats.js')(query, cache, streamApi);
var yp_cgi          = require('./controllers/yp-cgi.js')(query, qs, validator);
var listen          = require('./controllers/listen.js')(query, qs, streamApi);




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
    streamApi(req.query, function(err, rows,result){
        respond(res, err, rows, result);
    });
});
app.get('/streams/:streamId', function(req,res){
    res.set('Content-Type', 'application/json');
    params = {'id':req.params.streamId};
    streamApi(params, function(err,rows,result){
        if(err || result.rowCount != 1) {
            res.send([]);
        } else {
            res.send(rows[0]);
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

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
//    bunyan          = require('bunyan');


var cache           = cache_manager.caching({store: "memory", max: 100, ttl: 10});
var app             = express();
var config          = conf.all().config;




/* Controllers */
var stats           = require('./controllers/stats.js')(query, cache);
var streamsFindBy   = require('./controllers/stream-api.js')(query, cache);
var streamFindById  = require('./controllers/stream-by-id.js')(query, cache);
var index           = require('./controllers/index.js')(query, cache, streamsFindBy, stats);
var yp_cgi          = require('./controllers/yp-cgi.js')(query, qs, validator, config);
var listen          = require('./controllers/listen.js')(query, qs, xmlbuilder, streamFindById);
var search          = require('./controllers/search.js')(query, cache, streamsFindBy, stats);

/*
  To rerun api docs after modifying the apidoc comments use the command
  apidoc -i . -o apidoc/ -e node_modules
*/

query.connectionParameters = config.db;

swig.setDefaults({ cache: (process.env.NODE_ENV === 'production') ? 'memory' : false });

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
// backwards compatibility for bookmarks, redirect to /search
app.get('/by_genre/:genre', function(req, res) {
    res.redirect('/search?genre='+req.param("genre"));
});
app.get('/by_format/:format', function(req, res) {
    res.redirect('/search?format='+req.param("format"));
});
app.get('/search/', search);
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

/**
 * @api {get} /streams/ Get a list of Streams
 * @apiName GetStreams
 * @apiGroup Streams
 *
 * @apiParam {String} format Format to search by.
 * @apiParam {String} genre Genre to seach by.
 * @apiParam {String} q Search string.
 * @apiParam {Number=-1,0,1} order -1=Random order 0=Descending 1=Ascending.
 * @apiParam {Number} limit Number of results to return.
 * @apiParam {Number} starting_after ID of stream to return results after(Requires order, cannot have ending_before).
 * @apiParam {Number} ending_before ID of stream to return results before(Requires order, cannot have starting_after).
 * @apiParam {Number} last_listener_count listener count of the id passed in with starting_after or ending_before. Allows
 * pagination to get close if the id passed in is deleted.
 *
 * @apiSuccess {List} streams List of stream objects(See get individual stream for an example)
 * @apiSuccess {Object} data Contains next_url and prev_url for this data
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
 *     {
 *       "streams":[],
 *       "data":{"next_url":"/streams?limit=2&starting_after=20&order=0&last_listener_count=3","prev_url":"/streams?limit=2&ending_before=23&order=0&last_listener_count=5"},
 *     }
 *     View getting a single stream to see what the stream data will look like
 * @apiError {String} error Contains an error message describing the issue
 * @apiErrorExample {json} Error-Response:
 *     HTTP/1.1 400 Bad Request
 *     {
 *       "error":"error message describing issue"
 *     }
 */
app.get('/streams/', function(req,res){
    res.set('Content-Type', 'application/json');
    var params = req.query;
    var json = 1;
    streamsFindBy(params.format, params.genre, params.q, params.order, params.limit, params.starting_after, params.ending_before, params.last_listener_count, json, function(err, rows){
        if(err) {
            if(err.responsecode) {
                res.status(err.responsecode);
            } else {
                res.status(400);
            }
            res.send({"error":err.message});
        } else {
            var result = rows[0];
            if(result.streams === null) {
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
                    delete params.last_listener_count;

                    // add in the new values
                    var last_id = rows[0].streams[result.streams.length-1].id;
                    var last_count = rows[0].streams[result.streams.length-1].listeners;
                    params.starting_after = last_id;
                    params.last_listener_count = last_count;
                    qstring = querystring.stringify(params);
                    result.data.next_url = req.path+'?'+qstring;
                    delete params.starting_after;
                    var prev_id = rows[0].streams[0].id;
                    var prev_count = rows[0].streams[0].listeners;
                    params.ending_before = prev_id;
                    params.last_listener_count = prev_count;
                    qstring = querystring.stringify(params);
                    result.data.prev_url = req.path+'?'+qstring;
                }
            }
            res.send(result);
        }
    });
});

/**
 * @api {get} /streams/:id Get Individual Stream
 * @apiName GetStream
 * @apiGroup Streams
 *
 * @apiParam {Number} id Stream unique ID.
 *
 * @apiSuccess {Object} _ Describes the stream
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
 *     {
 *       "id":8,
 *       "stream_name":"TestStream7",
 *       "stream_type":"audio/ogg",
 *       "description":"Really Cool Stream",
 *       "songname":"TestSong",
 *       "url":"http://fake.com",
 *       "avg_listening_time":null,
 *       "codec_sub_types":["Vorbis"],
 *       "bitrate":128,
 *       "hits":null,
 *       "cm":null,
 *       "samplerate":44100,
 *       "channels":2,
 *       "quality":null,
 *       "genres":["Rock"],
 *       "listenurls":["http://fake.com:8000/stream"],
 *       "listeners":3,
 *       "max_listeners":100
 *     }
 * @apiErrorExample {json} Error-Response:
 *     HTTP/1.1 404 Not Found
 *     {
 *     }
 */
app.get('/streams/:streamId', function(req,res){
    res.set('Content-Type', 'application/json');
    streamFindById(req.params.streamId, 1, function(err,rows,result){
        if(err || rows[0].array_to_json === null) {
            res.status(404);
            res.send({});
        } else {
            res.send(rows[0].array_to_json[0]);
        }
    });
});


/**
 * @api {get} /genres/ Get a list of Genres
 * @apiName GetGenres
 * @apiGroup Genres
 *
 * @apiSuccess {List} - List of genres
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
 *     [
 *       {"val":"Rock"},
 *       {"val":"Pop"}
 *     ]
 */
app.get('/genres/', function(req, res) {
    res.set('Content-Type', 'application/json');
    var genresq = 'SELECT DISTINCT val FROM (SELECT unnest(genres) as val FROM streams) s;';
    query(genresq, function(err, rows, result) {
        respond(res, err, rows, result);
    });
});


/**
 * @api {get} /formats/ Get a list of Formats
 * @apiName GetFormats
 * @apiGroup Formats
 *
 * @apiSuccess {List} - List of formats
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
 *     [
 *       {"val":"Vorbis"},
 *       {"val":"MP3"}
 *     ]
 */
app.get('/formats/', function(req, res) {
    res.set('Content-Type', 'application/json');
    var formats = 'SELECT DISTINCT val FROM (SELECT unnest(codec_sub_types) as val FROM streams) s;';
    query(formats, function(err, rows, result) {
        respond(res, err, rows, result);
    });
});

function respond(res, err, rows, result) {
    if(err) {
        res.send([]);
    } else {
        res.send(rows);
    }
}


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

module.exports.getApp = app;

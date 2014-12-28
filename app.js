var express         = require('express'),
    query           = require('pg-query'),
    swig            = require('swig'),
    morgan          = require('morgan'),
    cache_manager   = require('cache-manager'),
    bodyParser      = require('body-parser'),
    qs              = require('qs'),
    conf            = require('konphyg')(__dirname + '/config');

var cache           = cache_manager.caching({store: "memory", max: 100, ttl: 10});
var app             = express();
var config          = conf('config');

/* Controllers */
var index           = require('./controllers/index.js')(query, cache);
var genres          = require('./controllers/genres.js')(query, cache);
var formats         = require('./controllers/formats.js')(query, cache);
var yp_cgi          = require('./controllers/yp-cgi.js')(query, qs);

query.connectionParameters = config.db;

swig.setDefaults({ cache: (process.env.NODE_ENV === 'production') ? true : false });

/* Middlewares */
app.use(morgan((process.env.NODE_ENV === 'production') ? 'short' : 'dev'));
app.use(bodyParser.urlencoded({ extended: true }));
app.use('/assets', express.static(__dirname + '/assets'));

app.engine('html', swig.renderFile);

app.set('view engine', 'html');
app.set('views', __dirname + '/views');

/* Routes */
app.get('/', index);
app.get('/by_genre/:genre', genres);
app.get('/by_format/:format', formats);
app.post('/cgi-bin/yp-cgi', yp_cgi);

var server = app.listen(3000, function() {
    console.log('Listening on port %d', server.address().port);
});

process.on('SIGINT', function() {
    server.close();
    process.exit();
});

var interval = setInterval(deleteOldServers, 240000, 4);
function deleteOldServers(time, cb) {
    query('DELETE FROM servers WHERE lasttouch < NOW() - INTERVAL \'' + time.toString() + ' minutes\';', cb);
}


























app.get('/view/', function(req, res) {
    //console.log("[GET " + req.originalUrl + "]:")
    res.set('Content-Type', 'application/json')
    if(!req.param('genre')) {
        query('SELECT array_to_json(array_agg(row_to_json(servers))) FROM servers;', function(err, rows, result) {
            //console.log(err)
            res.send(rows[0].array_to_json)
        });
    } else {
        query('SELECT array_to_json(array_agg(row_to_json(servers))) FROM servers WHERE $1 = ANY (genres);',
            [req.param('genre')],
            function(err, rows, result) {
            //console.log(err)
            res.send(rows[0].array_to_json)
        });
    }
});

app.get('/insert/', function(req, res) {
    //console.log("[GET " + req.originalUrl + "]:")
    query('INSERT INTO servers VALUES (\
        uuid_generate_v4(),\
        $1,\
        $2,\
        $3,\
        $4,\
        $5,\
        $6,\
        $7,\
        $8,\
        $9,\
        now()\
        );', [req.param('sn'), req.param('type'), [req.param('genres')], req.param('b'), req.param('listenurl'),
    req.param('cpswd'), req.param('desc'), req.param('url'), [req.param('stype')]], function(err, rows, result) {
        //console.log(err)
        res.send(err)
    });
});

app.get('/genres/', function(req, res) {
  var genresq = 'SELECT DISTINCT val FROM (SELECT unnest(genres) as val FROM servers) s;';
  query(genresq, function(err, rows, result) {
    res.send(rows);
  });
});
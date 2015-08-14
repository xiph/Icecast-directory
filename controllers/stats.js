var query, cache, log;
var async = require('async');

function init(q, c, l) {

    query = q;
    cache = c;
    log;
    return getCachedStats;
}


function getCachedStats(cb) {
    cache.wrap("stats", function (_cb) {
        getStats(_cb);
    }, 5, cb);
}


function getStats(resultCallback)
{
    var formatsq = 'SELECT codec, COUNT(*) as count FROM (SELECT unnest(s.codec_sub_types) AS codec' +
                   ' FROM streams s) t GROUP BY codec ORDER BY count desc'

    var genresq = 'SELECT genre, COUNT(*) as count FROM (SELECT unnest(s.genres) AS genre' +
                   ' FROM streams s) t GROUP BY genre ORDER BY count desc'

    var totalStreams ='SELECT COUNT(*) AS total FROM streams AS s '+
                        'INNER JOIN server_mounts AS sm ON s.id = sm.stream_id ';

    var stats = {}
    stats.statistics = {}
    async.waterfall([
    function getallGenres(cb) {
        query(genresq, cb);
    },
    function(rows, result, cb) {
        stats["genres"] = rows
        console.log(rows)
        query(formatsq, cb);
    },
    function(rows, result, cb) {
        stats["formats"] = rows
        query(totalStreams, cb)
    },
    function(rows, result, cb) {
        stats.statistics["Total Streams"] = rows[0].total
        // computer popularity for genres
        for(var i =0;i<stats["genres"].length;i++) {
            // cap popularity at 6
            stats["genres"][i].popularity = Math.min(Math.round((stats["genres"][i].count/rows[0].total)*15-1), 6)
        }
        resultCallback(null, stats);
    },
    ],function (err, result) {
        console.log("err")
        if(err) {
            resultCallback(err, null)
        }
    });
}


module.exports = init;

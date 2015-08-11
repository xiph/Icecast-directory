var query, cache;
var async = require('async');

function init(q, c) {

    query = q;
    cache = c;
    return getCachedStats;
}


function getCachedStats(cb) {
    cache.wrap("stats", function (_cb) {
        getStats(_cb);
    }, 5, cb);
}


function getStats(resultCallback)
{
    console.log("go")
    var genresq = 'SELECT DISTINCT val FROM (SELECT unnest(genres) as val FROM streams) s;';
    var formats = 'SELECT DISTINCT val FROM (SELECT unnest(codec_sub_types) as val FROM streams) s;';

    var baseStatsQuery ='SELECT COUNT(*) AS total FROM streams AS s '+
                        'INNER JOIN server_mounts AS sm ON s.id = sm.stream_id ';
    var wheremodifier = 'WHERE $1 = ANY(s.codec_sub_types)'

    var stats = {}
    stats.statistics = {}
    async.waterfall([
    function getallGenres(cb) {
        query(genresq, cb);
    },
    function(rows, result, cb) {
        stats["genres"] = rows
        query(formats, cb);
    },
    function(rows, result, cb) {
        stats["formats"] = rows
        query(baseStatsQuery, cb)
    },
    function(rows, result, cb) {
        stats.statistics["Total Streams"] = rows[0].total
        query(baseStatsQuery+wheremodifier,['Vorbis'], cb)
    },
    function(rows, result, cb) {
        stats.statistics["Ogg Vorbis"] = rows[0].total
        query(baseStatsQuery+wheremodifier,['Opus'], cb)
    },
    function(rows, result, cb) {
        stats.statistics["Opus"] = rows[0].total
        query(baseStatsQuery+wheremodifier,['Theora'], cb)
    },
    function(rows, result, cb) {
        stats.statistics["Theora"] = rows[0].total
        query(baseStatsQuery+wheremodifier,['MP3'], cb)
    },
    function(rows, result, cb) {
        stats.statistics["MP3"] = rows[0].total
        query(baseStatsQuery+wheremodifier,['WebM'], cb)
    },
    function(rows, result, cb) {
        stats.statistics["Webm"] = rows[0].total
        query(baseStatsQuery+wheremodifier,['AAC'], cb)
    },
    function(rows, result, cb) {
        stats.statistics["AAC"] = rows[0].total
        query(baseStatsQuery+wheremodifier,['AAC+'], cb)
    },
    function(rows, result, cb) {
        stats.statistics["AAC+"] = rows[0].total
        query(baseStatsQuery+wheremodifier,['NSV'], cb)
    },
    function(rows, result, cb) {
        stats.statistics["NSV"] = rows[0].total
        resultCallback(null, stats)
    }
    ],function (err, result) {
        if(err) {
            resultCallback(err, null)
        }
    });
}


module.exports = init;

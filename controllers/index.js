var query, cache;

function init(q, c) {
    query = q;
    cache = c;
    return index;
}

function index(req, res) {
    getCachedRandomStreams(20, function(err, result) {
        if (err) {
            res.send(503);
        } else {
            var error;
            if (result.rowCount === 0) {
                error = "No streams found.";
            } else {
                error = false;
            }
            res.render("index", {
                title: '',
                servers: result.rows,
                error: error
            });
        }
    });
}

function getCachedRandomStreams(count, cb) {
    cache.wrap(count, function (_cb) {
        getRandomStreams(count, _cb);
    }, 5, cb);
}

function getRandomStreams(count, cb) {
    query('SELECT id, server_name, server_type, genres, bitrate, listenurl, description, url, \
           codec_sub_types, songname, listeners FROM servers ORDER BY random() LIMIT $1;', [count],
    function(err, rows, result) {
        cb(err, result);
    });
}

module.exports = init;
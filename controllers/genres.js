var query, cache;

function init(q, c) {
    query = q;
    cache = c;
    return byGenre;
}

function byGenre(req, res) {
    getCachedGenreStreams(req.param("genre"), function(err, result) {
        if (err) {
            res.send(503);
        } else {
            var error;
            if (result.rowCount === 0) {
                error = "No streams for this genre.";
            } else {
                error = false;
            }
            res.render("by_genre", {
                title: req.param("genre"),
                servers: result.rows,
                error: error
            });
        }
    });
}

function getCachedGenreStreams(genre, cb) {
    cache.wrap(genre, function (_cb) {
        getGenreStreams(genre, _cb);
    }, 5, cb);
}

function getGenreStreams(genre, cb) {
    query("SELECT id, server_name, server_type, genres, bitrate, listenurl, description, url, \
           codec_sub_types, songname, listeners FROM servers WHERE $1 = ANY (genres);", [genre],
    function(err, rows, result) {
        cb(err, result);
    });
}

module.exports = init;
var query, cache, streamApi;

function init(q, c, s) {
    query = q;
    cache = c;
    streamApi = s;
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
            res.render("by_xx", {
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
    var params = {'genre':genre};
    streamApi(params, function(err, rows, result) {
        cb(err, result);
    });
}

module.exports = init;

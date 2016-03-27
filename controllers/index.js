var query, cache, streamsFindBy, stats;

function init(q, c, s, st) {
    query = q;
    cache = c;
    streamsFindBy = s;
    stats = st;
    return index;
}

function index(req, res) {
    var format = undefined;
    var genre = undefined;
    var q = undefined;
    var order = -1; //random
    var limit = 10;
    var starting_after = undefined;
    var ending_before = undefined;
    var last_listener_count = undefined;
    var json = 0;
    streamsFindBy(format, genre, q, order, limit, starting_after, ending_before, last_listener_count, json, function(err, rows) {
        if (err) {
            res.sendStatus(503);
        } else {
            var error;
            if (rows.length === 0) {
                error = "No streams found.";
            } else {
                error = false;
            }

            stats(function(errorStats, stats) {
                res.render("index", {
                    title: '',
                    servers: rows,
                    error: error,
                    stats: stats
                });
            });

        }
    });
}

module.exports = init;

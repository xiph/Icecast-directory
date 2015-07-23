var query, cache, streamsFindBy;

function init(q, c, s) {
    query = q;
    cache = c;
    streamsFindBy = s;
    return byGenre;
}

function byGenre(req, res) {
    var genre = req.param("genre");
    var next = req.param("next");
    var prev = req.param("prev");
    streamsFindBy(undefined, genre, undefined, 2, 10, next, prev, 0, function(err, rows) {
        console.log(req);
        if (err) {
            res.send(503);
        } else {
            var error;
            if (rows.length === 0) {
                error = "No streams for this genre.";
            } else {
                error = false;
            }
            var next_url, prev_url;
            if (rows.length == 10) {
                var last_id = rows[9].id;
                var prev_id = rows[0].id;
                next_url = req.path+'?next='+last_id;
                prev_url = req.path+'?prev='+prev_id;
            }
            res.render("by_xx", {
                title: genre,
                servers: rows,
                error: error,
                next: next_url,
                prev: prev_url
            });
        }
    });
}

module.exports = init;

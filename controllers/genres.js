var query, cache, streamsFindBy;

function init(q, c, s) {
    query = q;
    cache = c;
    streamsFindBy = s;
    return byGenre;
}

function byGenre(req, res) {
    var genre = req.param("genre");
    streamsFindBy(undefined, genre, undefined, 1, 10, 0, function(err, rows) {
        if (err) {
            res.send(503);
        } else {
            var error;
            if (rows.length === 0) {
                error = "No streams for this genre.";
            } else {
                error = false;
            }
            res.render("by_xx", {
                title: genre,
                servers: rows,
                error: error
            });
        }
    });
}

module.exports = init;

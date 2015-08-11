var query, cache, streamsFindBy;

function init(q, c, s) {
    query = q;
    cache = c;
    streamsFindBy = s;
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
    var json = 0;
    streamsFindBy(format, genre, q, order, limit, starting_after, ending_before, json, function(err, rows) {
        if (err) {
            res.send(503);
        } else {
            var error;
            if (rows.length === 0) {
                error = "No streams found.";
            } else {
                error = false;
            }
            res.render("index", {
                title: '',
                servers: rows,
                error: error
            });
        }
    });
}

module.exports = init;

var query, cache, streamsFindBy;

function init(q, c, s) {
    query = q;
    cache = c;
    streamsFindBy = s;
    return index;
}

function index(req, res) {
    streamsFindBy(undefined, undefined, undefined, 0, 20, undefined, undefined, 0, function(err, rows) {
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

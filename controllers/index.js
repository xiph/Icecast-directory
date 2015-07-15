var query, cache, streamApi;

function init(q, c, s) {
    query = q;
    cache = c;
    streamApi = s;
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
            console.log(result.rows);
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
    var params = {'limit':count,'order':0};
    streamApi(params, function(err, rows, result) {
        cb(err, result);
    });
}

module.exports = init;

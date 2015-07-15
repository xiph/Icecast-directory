var query, cache, streamApi;

function init(q, c, s) {
    query = q;
    cache = c;
    streamApi = s;
    return byFormat;
}

function byFormat(req, res) {
    getCachedFormatStreams(req.param("format"), function(err, result) {
        if (err) {
            res.send(503);
        } else {
            var error;
            if (result.rowCount === 0) {
                error = "No streams for this format.";
            } else {
                error = false;
            }
            res.render("by_xx", {
                title: req.param("format"),
                servers: result.rows,
                error: error
            });
        }
    });
}

function getCachedFormatStreams(format, cb) {
    cache.wrap(format, function (_cb) {
        getFormatStreams(format, _cb);
    }, 5, cb);
}

function getFormatStreams(format, cb) {
    var params = {'format':format};
    streamApi(params, function(err, rows, result) {
        cb(err, result);
    });
}

module.exports = init;

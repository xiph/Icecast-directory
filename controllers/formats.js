var query, cache;

function init(q, c) {
    query = q;
    cache = c;
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
    query("SELECT id, server_name, server_type, genres, bitrate, listenurl, description, url, \
           codec_sub_types, songname, listeners FROM servers WHERE $1 = ANY (codec_sub_types);", [format],
    function(err, rows, result) {
        cb(err, result);
    });
}

module.exports = init;
var query, cache, streamsFindBy;

function init(q, c, s) {
    query = q;
    cache = c;
    streamsFindBy = s;
    return byFormat;
}

function byFormat(req, res) {
    var params = req.params;
    var genre = undefined;
    var q = undefined;
    var order = 0; //descending
    var limit = 2;
    var json = 0;
    var format = req.param("format");
    var starting_after = req.param("starting_after");
    var ending_before = req.param("ending_before");
    streamsFindBy(format, genre, q, order, limit, starting_after, ending_before, json, function(err, rows) {
        if (err) {
            res.send(503);
        } else {
            var error;
            if (rows.length === 0) {
                error = "No streams for this format.";
            } else {
                error = false;
            }
            var next_url, prev_url, home_url;
            var result = rows;

            // if the full results don't appear show a start button
            if((starting_after || ending_before) && result.length < limit) {
                // clear pagination params
                delete params.ending_before;
                delete params.starting_after;
                qstring = querystring.stringify(params);
                home_url = req.path+'?'+qstring;
            }

            // on the fist page and any page with max results show the next button
            if(!(starting_after || ending_before) || (result.length == limit)) {
                var last_id = rows[result.length-1].id;
                delete params.ending_before;
                params.starting_after = last_id;
                qstring = querystring.stringify(params);
                next_url = req.path+'?'+qstring;
            }

            // any page with max results and any page with results with starting_after
            // show the previous button
            if((result.length == limit) || (result.length > 0 && starting_after)) {
                var prev_id = rows[0].id;
                delete params.starting_after;
                params.ending_before = prev_id;
                qstring = querystring.stringify(params);
                prev_url = req.path+'?'+qstring;
            }



            res.render("by_xx", {
                title: format,
                servers: rows,
                error: error,
                next: next_url,
                prev: prev_url,
                home: home_url
            });
        }
    });
}

module.exports = init;

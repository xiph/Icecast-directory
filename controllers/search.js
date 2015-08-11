var query, cache, streamsFindBy, stats;

function init(q, c, s, st) {
    query = q;
    cache = c;
    streamsFindBy = s;
    stats = st;
    return bySearch;
}

function bySearch(req, res) {
    var params = req.query;
    var format = req.param("format");
    var genre = req.param("genre");
    var q = req.param("q");
    var order = 0; //descending
    var limit = 2;
    var json = 0;
    var starting_after = req.param("starting_after");
    var ending_before = req.param("ending_before");
    var last_listener_count = req.param("last_listener_count")
    streamsFindBy(format, genre, q, order, limit, starting_after, ending_before, last_listener_count, json, function(err, rows) {
        if (err) {
            res.send(503);
        } else {
            var error;
            if (rows.length === 0) {
                error = "No streams for this search.";
            } else {
                error = false;

                var next_url, prev_url, home_url;
                var result = rows;

                // if the full results don't appear show a start button
                if((starting_after || ending_before) && result.length < limit) {
                    // clear pagination params
                    delete params.ending_before;
                    delete params.starting_after;
                    delete params.last_count;
                    qstring = querystring.stringify(params);
                    home_url = req.path+'?'+qstring;
                }

                // on the fist page and any page with max results show the next button
                if(!(starting_after || ending_before) || (result.length == limit)) {
                    var last_id = rows[result.length-1].id;
                    var last_count = rows[result.length-1].listeners;
                    delete params.ending_before;
                    params.starting_after = last_id;
                    params.last_listener_count = last_count;
                    qstring = querystring.stringify(params);
                    next_url = req.path+'?'+qstring;
                }

                // any page with max results and any page with results with starting_after
                // show the previous button
                if((result.length == limit) || (result.length > 0 && starting_after)) {
                    var prev_id = rows[0].id;
                    var prev_count = rows[0].listeners;
                    delete params.starting_after;
                    params.ending_before = prev_id;
                    params.last_listener_count = prev_count;

                    qstring = querystring.stringify(params);
                    prev_url = req.path+'?'+qstring;
                }
            }

            stats(function(errorStats, stats) {
                res.render("by_xx", {
                    title: "Search",
                    genre:genre,
                    format:format,
                    q:q,
                    servers: rows,
                    error: error,
                    next: next_url,
                    prev: prev_url,
                    home: home_url,
                    stats:stats
                });
            });


        }
    });
}

module.exports = init;

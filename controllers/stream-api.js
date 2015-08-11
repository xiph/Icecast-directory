var query, cache;

function init(q, c) {

    query = q;
    cache = c;
    return getCachedStreams;
}



function getCachedStreams(format, genre, q, order, limit, starting_after, ending_before, json, cb) {
    var cacheString = JSON.stringify({"format":format, "genre":genre, "q":q, "order":order, "limit":limit, "starting_after":starting_after, "ending_before":ending_before, "json":json});
    console.log(cacheString);
    cache.wrap(cacheString, function (_cb) {
        var params = JSON.parse(cacheString);
        findBy(params.format, params.genre, params.q, params.order, params.limit, params.starting_after, params.ending_before, params.json, _cb);
    }, 5, cb);
}

/*
    Takes in paramters {}
    q = Search string
    limit, genre, format, order(-1 Random, 0 Listeners Desc, 1 Listeners Asc)
    starting_after, ending_before id for pagination
    callback is called during the resulting query, should be
    function(err, rows){}
    err will have a message and might have a responsecode

    Turns parameters into a sql query on streams

    Example query built:
    //convert to json
    SELECT array_to_json(array_agg(row_to_json(t))) AS streams FROM (
    SELECT s.id, s.stream_name, s.stream_type, s.description,     s.songname, s.url, s.avg_listening_time, s.codec_sub_types, s.bitrate, s.hits,     s.cm, s.samplerate, s.channels, s.quality, s.genres, array_agg(sm.listenurl) AS listenurls, SUM(sm.listeners) AS listeners, SUM(sm.max_listeners) AS max_listeners
    FROM streams s
    INNER JOIN server_mounts AS sm ON s.id = sm.stream_id
    //where/and clauses for genres, codec_sub_types and q
    WHERE $1 = ANY(s.genres)
    AND $2 = ANY(s.codec_sub_types)
    AND ($3 LIKE ANY(s.genres) OR s.stream_name LIKE $4 OR s.description LIKE $4 )

    GROUP BY s.id
    // having clause for starting at a starting_after or ending_before id
    HAVING (sum(sm.listeners), s.id) > (
    // sub query to get current listeners of the starting_after/ending_before id
    (SELECT sum(sm.listeners) AS listeners
    FROM streams s
    INNER JOIN server_mounts AS sm ON s.id = sm.stream_id
    WHERE s.id =  $5
    GROUP BY s.id
    LIMIT 1)

    ,$5)
    ORDER BY listeners ASC, s.id ASC
    LIMIT $6
     ) t
*/

function findBy(format, genre, q, order, limit, starting_after, ending_before, json, resultCallback)
{
    // error handling for arguments

    // can't have both starting_after and ending_before
    if(starting_after && ending_before) {
        // call callback with error
        resultCallback({"message":"can't have both starting_after and ending_before parameters","responsecode":400},[]);
        return;
    }

    // need an order when doing pagination
    if((starting_after || ending_before) && order == undefined) {
        resultCallback({"message":"need an order parameter if using starting_after and ending_before parameters","responsecode":400},[]);
        return;
    }

    // check to make sure params are not arrays can happen through
    // ?param=value&param=value
    var params = [format, genre, q, order, limit, starting_after, ending_before, json];
    for(var i =0;i<params.length;i++)
    {
        if(Array.isArray(params[i])) {
            resultCallback({"message":"cannot pass in arrays for parameters","responsecode":400},[]);
            return;
        }
    }

    // parse json if string
    if (json instanceof String || typeof json == "string") {
        json = parseInt(json);
    }
    // json can only be 0 or 1
    if(json != 0 && json != 1) {
        resultCallback({"message":"json must be 0 or 1","responsecode":400},[]);
        return;
    }

    // check order is only -1, 0, or 1
    if(order != undefined) {
        if (order instanceof String || typeof order == "string") {
            order = parseInt(order);
        }
        if( (order != -1 && order != 0 && order != 1)) {
            resultCallback({"message":"order parameter must be -1, 0, or 1","responsecode":400},[]);
            return;
        }
    }


    var queryStringJsonBeg = 'SELECT array_to_json(array_agg(row_to_json(t))) AS streams FROM ( \n';
    var queryStringJsonEnd = ' ) t';

    var queryStringBeg = 'SELECT s.id, s.stream_name, s.stream_type, s.description, ' +
    's.songname, s.url, s.avg_listening_time, s.codec_sub_types, s.bitrate, s.hits, ' +
    's.cm, s.samplerate, s.channels, s.quality, s.genres, array_agg(sm.listenurl) AS listenurls, ' +
    'SUM(sm.listeners) AS listeners, SUM(sm.max_listeners) AS max_listeners ' +
    'FROM streams s ' +
    'INNER JOIN server_mounts AS sm ON s.id = sm.stream_id ';
    var queryStringGroup = '\n GROUP BY s.id \n';

    // final sql query string
    var queryString;

    // # for argument to be inserted into the sql string
    var countItems = 1;

    // list for arguments to be inserted into the sql string
    var items = [];

    // if json add the json conversion to the query
    if(json) {
        queryString = queryStringJsonBeg+queryStringBeg;
    } else {
        queryString = queryStringBeg;
    }

    // Add any WHERE/AND clauses necessary from the genre, format, q
    if(genre) {
        queryString += 'WHERE $'+countItems+' = ANY(s.genres) ';
        countItems++;
        items.push(genre);
    }

    if(format) {
        if(countItems == 1) {
            queryString += 'WHERE $'+countItems+' = ANY(s.codec_sub_types) ';
        } else {
            queryString += 'AND $'+countItems+' = ANY(s.codec_sub_types) ';
        }
        countItems++;
        items.push(format);
    }

    if(q) {
        var doSearch = false;
        var searchWord = '';
        var search = q.split(' ');

        var searchString = 'WHERE (';
        if(countItems > 1) {
            searchString = 'AND (';
        }

        for(var i=0;i<search.length;i++)
        {
            // limit search words to 3
            if(i>3) {
                break;
            }

            // minimum word length of 3
            if(search[i].length<3) {
                continue;
            }

            doSearch = true;

            //maximum word length of 10
            if(search[i].length>10) {
                search[i] = search[i].substring(0,10);
            }

            // add match anything to the end of the string
            searchWord += search[i]+'%';

            searchString += '$'+countItems+' LIKE ANY(s.genres) OR ';
            countItems++;
            items.push(search[i]);
        }
        if(doSearch) {
            searchString += 's.stream_name LIKE $'+countItems+' OR s.description LIKE $'+countItems+' ';
            items.push(searchWord);
            countItems++;

            searchString += ') ';
            queryString += searchString;
        } else {
            // search query won't return any results
            resultCallback({"message":"search string not long enough"},[]);
            return;
        }
    }

    // add in the Group BY
    queryString = queryString + queryStringGroup;

    //subQuery to get # listeners for the starting_after/ending_before id
    var subQuery = '(SELECT sum(sm.listeners) AS listeners FROM streams s ' +
                        'INNER JOIN server_mounts AS sm ON s.id = sm.stream_id ' +
                        'WHERE s.id =  $'+ countItems +
                        'GROUP BY s.id ' +
                        'LIMIT 1)';

    // pagination need to use HAVING because sum(sm.listeners) will return the
    // correct value
    if(ending_before) {
        if( order==1 ){
            order = 2;
            queryString += 'HAVING (sum(sm.listeners), s.id) < ' + '( ' + subQuery + ' ,$' + countItems + ') ';
        } else {
            order = 1;
            queryString += 'HAVING (sum(sm.listeners), s.id) > ' + '(' + subQuery + ' ,$' + countItems + ') ';
        }
        items.push(ending_before);
        countItems++;
    }
    else if(starting_after) {
        if( order==0 ){
            queryString += 'HAVING (sum(sm.listeners), s.id) < ' + '(' + subQuery + ' ,$' + countItems + ') ';
        } else {
            queryString += 'HAVING (sum(sm.listeners), s.id) > ' + '(' + subQuery + ' ,$' + countItems + ') ';
        }
        items.push(starting_after);
        countItems++;
    }

    // add order and limit clauses to the query
    if(order != null) {
        if(order == -1) {
            queryString += 'ORDER BY random() \n';
        } else if(order == 0) {
            queryString += 'ORDER BY listeners desc, s.id desc \n';
        } else if(order == 1) {
            queryString += 'ORDER BY listeners asc, s.id asc \n';
        }
    }

    if(limit) {
        queryString += 'LIMIT $'+countItems+' \n';
        countItems++;
        items.push(limit);
    }

    // add ending for json if necessary
    if(json) {
        queryString += queryStringJsonEnd;
    }

    query(queryString, items,function(err, rows){
        var result;
        if(rows == null) {
            resultCallback(err, [{"streams":rows}]);
            return;
        }

        //pagination reverse needed
        if(order && ending_before) {
            if(json) {
                result = rows[0].streams;
            } else {
                result = rows;
            }

            if(result == null) {
                result = [];
            }

            if(result.length > 0) {
                result = result.slice().reverse();
            }

            if(json) {
                result = [{"streams":result}];
            }

            resultCallback(err, result);
            return;
        }

        resultCallback(err, rows);
    });
}


module.exports = init;

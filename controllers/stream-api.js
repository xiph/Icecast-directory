var query, cache;

function init(q, c) {

    query = q;
    cache = c;
    return getCachedStreams;
}


function getCachedStreams(format, genre, q, order, limit, next, prev, json, cb) {
    var cacheString = JSON.stringify({"format":format, "genre":genre, "q":q, "order":order, "limit":limit, "next":next, "prev":prev, "json":json});
    console.log(cacheString);
    cache.wrap(cacheString, function (_cb) {
        var params = JSON.parse(cacheString);
        findBy(params.format, params.genre, params.q, params.order, params.limit, params.next, params.prev, params.json, _cb);
    }, 5, cb);
}

/*
    Takes in paramters {}
    q = Search string
    id, limit, offset, genre, format, order(0 Random, 1 Listeners Desc, 2 Listeners Asc)
    callback is called during the resulting query, should be
    function(err, rows){}

    Turns parameters into a sql query on streams
*/
function findBy(format, genre, q, order, limit, next, prev, json, resultCallback)
{
    console.log(format);
    console.log(genre);
    var queryStringJsonBeg = 'SELECT array_to_json(array_agg(row_to_json(t))) AS streams FROM (';
    var queryStringJsonEnd = ' ) t';
    var queryStringBeg = 'SELECT s.id, s.stream_name, s.stream_type, s.description \
    ,s.songname, s.url, s.avg_listening_time, s.codec_sub_types, s.bitrate, s.hits, \
    s.cm, s.samplerate, s.channels, s.quality, s.genres, array_agg(sm.listenurl) AS listenurls, \
    COUNT(sm.listeners) AS listeners, COUNT(sm.max_listeners) AS max_listeners \
    FROM streams s \
    INNER JOIN server_mounts AS sm ON s.id = sm.stream_id ';
    var queryStringGroup = 'GROUP BY s.id ';
    var queryString;
    var countItems = 1;
    var items = [];
    // if json add the json conversion to the query
    if(json) {
        queryString = queryStringJsonBeg+queryStringBeg;
    } else {
        queryString = queryStringBeg;
    }
    var search;
    if(genre) {
        queryString += genreFormatModifier(countItems, 's.genres');
        countItems++;
        items.push(genre);
    }
    if(format) {
        queryString += genreFormatModifier(countItems, 's.codec_sub_types');
        countItems++;
        items.push(format);
    }
    if(q) {
        search = q;
        var add = false;
        var searchWord = '';
        var searchArray ='(';
        if(Array.isArray(search)) {
            search = search[0];
        }
        search = search.split(' ');
        var searchString = 'WHERE (';
        if(countItems > 1) {
            searchString = 'AND (';
        }
        for(var i=0;i<search.length;i++)
        {
            if(i>3) {
                break;
            }
            // minimum word length of 3
            if(search[i].length<3) {
                continue;
            }
            add = true;
            //maximum word length of 10
            if(search[i].length>10) {
                search[i] = search[i].substring(0,10);
            }
            searchWord += search[i]+'%';
            searchString += '$'+countItems+' LIKE ANY(s.genres) OR ';
            countItems++;
            items.push(search[i]);
        }
        if(add) {
            searchString += 's.stream_name LIKE $'+countItems+' OR s.description LIKE $'+countItems+' ';
            items.push(searchWord);
            countItems++;

            searchString += ') ';
            queryString += searchString;
        } else {
            // search query won't return any results
            resultCallback(0,[],{});
            return;
        }
    }
    if(next && (order ==1 || order ==2)) {
        searchString = 'WHERE ';
        if(countItems > 1) {
            searchString = 'AND ';
        }
        var sign;
        if( order==1 ){
            sign = '<';
        } else {
            sign = '>';
        }
        queryString += searchString + 's.id ' + sign + ' ' + '$' + countItems + ' ';
        items.push(next);
        countItems++;
    }
    else if(prev && (order ==1 || order ==2)) {
        searchString = 'WHERE ';
        if(countItems > 1) {
            searchString = 'AND ';
        }
        var sign;
        if( order==1 ){
            sign = '>';
        } else {
            sign = '<';
        }
        queryString += searchString + 's.id ' + sign + ' ' + '$' + countItems + ' ';
        items.push(prev);
        countItems++;
    }
    // add in the Group BY
    queryString = queryString + queryStringGroup;
    if(order) {
        if(order == 0) {
            queryString += 'ORDER BY random() ';
        } else if(order == 1) {
            queryString += 'ORDER BY s.id desc ';
        } else if(order == 2) {
            queryString += 'ORDER BY s.id asc ';
        }
    }
    if(limit) {
        queryString += 'LIMIT $'+countItems+' ';
        countItems++;
        items.push(limit);
    }
    if(json) {
        queryString += queryStringJsonEnd;
    }
    console.log(queryString);
    console.log(items)
    console.log(resultCallback)
    query(queryString, items, resultCallback);
}

function genreFormatModifier(count, type)
{
    if(count > 1) {
        return ('AND $'+count+' = ANY('+type+') ');
    }
    else {
        return ('WHERE $'+count+' = ANY('+type+') ');
    }
}

module.exports = init;

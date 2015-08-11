var query, cache;

function init(q, c) {

    query = q;
    cache = c;
    return getCachedStreamById;
}


function getCachedStreamById(id, json, cb) {
    var cacheString = JSON.stringify({"id":id,"json":json});
    cache.wrap(cacheString, function (_cb) {
        var params = JSON.parse(cacheString);
        findById(params.id, params.json, _cb);
    }, 5, cb);
}

function findById(id, json, resultCallback)
{
    var queryStringJsonBeg = 'SELECT array_to_json(array_agg(row_to_json(t))) FROM (';
    var queryStringJsonEnd = ' ) t';
    var queryStringBeg = 'SELECT s.id, s.stream_name, s.stream_type, s.description ' +
    ',s.songname, s.url, s.avg_listening_time, s.codec_sub_types, s.bitrate, s.hits, ' +
    's.cm, s.samplerate, s.channels, s.quality, s.genres, array_agg(sm.listenurl) AS listenurls, ' +
    'SUM(sm.listeners) AS listeners, SUM(sm.max_listeners) AS max_listeners ' +
    'FROM streams s ' +
    'INNER JOIN server_mounts AS sm ON s.id = sm.stream_id ' +
    'WHERE $1 = s.id ' +
    'GROUP BY s.id ';
    var queryString;

    if(json) {
        queryString = queryStringJsonBeg+queryStringBeg;
    } else {
        queryString = queryStringBeg;
    }

    var items = [id];

    if(json) {
        queryString += queryStringJsonEnd;
    }
    console.log(queryString);

    query(queryString, items, resultCallback);
}


module.exports = init;

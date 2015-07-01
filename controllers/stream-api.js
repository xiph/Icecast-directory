var query, cache;

function init(q, c) {
    query = q;
    cache = c;
    return streamApi;
}


/*
    Takes in paramters {}
    q = Search string
    id, limit, offset, genre, format, order(0 Random, 1 Listeners Desc, 2 Listeners Asc)
    callback is called during the resulting query, should be
    function(err, rows, result){}

    Turns parameters into a sql query on streams
*/
function streamApi(params,callback)
{
    var allStreamsBeg = 'SELECT s.id, s.stream_name, s.stream_type, s.description,s.songname, s.url, s.avg_listening_time, s.codec_sub_types, s.bitrate, s.hits, s.cm, s.samplerate, s.channels, s.quality, s.genres, array_agg(sm.listenurl) AS listenurls, COUNT(sm.listeners) AS listeners, COUNT(sm.max_listeners) AS max_listeners FROM streams s INNER JOIN server_mounts AS sm ON s.id = sm.stream_id '
    var allStreamsGroup = 'GROUP BY s.id '
    var countItems = 1
    var items = []
    var queryString = allStreamsBeg
    var genre, format, streamId, search, order, limit, offset;
    if(params.genre)
    {
        genre = params.genre
        if(Array.isArray(genre))
        {
            for(var i =0; i <genre.length;i++)
            {
                queryString += genreFormatModifier(countItems, 's.genres')
                countItems++
                items.push(genre[i])
            }
        }
        else
        {
          queryString += genreFormatModifier(countItems, 's.genres')
          countItems++
          items.push(genre)
        }
    }
    if(params.format)
    {
        format = params.format
        if(Array.isArray(format))
        {
            for(var i =0; i <genre.length;i++)
            {
                queryString += genreFormatModifier(countItems, 's.codec_sub_types')
                countItems++
                items.push(format[i])
            }
        }
        else
        {
          queryString += genreFormatModifier(countItems, 's.codec_sub_types')
          countItems++
          items.push(format)
        }
    }
    if(params.id)
    {
        streamId = params.id
        if(countItems > 1)
        {
            queryString += 'AND $'+countItems+' = s.id '
        }
        else
        {
            queryString += 'WHERE $'+countItems+' = s.id '
        }
        countItems++
        items.push(streamId)
    }
    if(params.q)
    {
        search = params.q
        var add = false;
        var searchWord = '';
        var searchArray ='(';
        if(Array.isArray(search))
        {
            search = search[0]
        }
        search = search.split(' ')
        var searchString = 'WHERE ('
        if(countItems > 1)
        {
            searchString = 'AND ('
        }
        for(var i=0;i<search.length;i++)
        {
            if(i>3)
            {
                break;
            }
            // minimum word length of 3
            if(search[i].length<3)
            {
                continue;
            }
            add = true
            //maximum word length of 10
            if(search[i].length>10)
            {
                search[i] = search[i].substring(0,10)
            }
            searchWord += search[i]+'%'
            searchString += '$'+countItems+' LIKE ANY(s.genres) OR '
            countItems++
            items.push(search[i])
        }
        if(add)
        {
            searchString += 's.stream_name LIKE $'+countItems
            +' OR s.description LIKE $'+countItems+' '
            items.push(searchWord)
            countItems++

            searchString += ') '
            queryString += searchString
        }
        else
        {
            // search query won't return any results
            callback(0,[],{})
            return
        }
    }
    // add in the Group BY
    queryString = queryString + allStreamsGroup
    if(params.order)
    {
        order = params.order
        if(order == 0)
        {
            queryString += 'ORDER BY random() '
        }
        else if(order == 1)
        {
            queryString += 'ORDER BY listeners DESC'
        }
        else if(order == 2)
        {
            queryString += 'ORDER BY listeners ASC'
        }

    }
    if(params.limit) {
        limit = params.limit
        if(Array.isArray(limit))
        {
            limit = limit[0]
        }
        else
        {
          queryString += 'LIMIT $'+countItems+' '
          countItems++
          items.push(limit)
        }
    }
    if(params.offset) {
        offset = params.offset
        if(Array.isArray(offset))
        {
            offset = offset[0]
        }
        else
        {
          queryString += 'OFFSET $'+countItems+' '
          countItems++
          items.push(offset)
        }
    }
    //console.log(queryString)
    query(queryString,items,callback)
}
function genreFormatModifier(count, type)
{
    if(count > 1)
    {
        return ('AND $'+count+' = ANY('+type+') ')
    }
    else
    {
        return ('WHERE $'+count+' = ANY('+type+') ')
    }
}

module.exports = init;

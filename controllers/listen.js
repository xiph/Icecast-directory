var query, cache, xmlbuilder, streamApi;

function init(q, c, x, s) {
    query = q;
    cache = c;
    streamApi = s;
    xmlbuilder = x;
    return getListen;
}

function getListen(req, res) {
    params = {'id':req.params.streamId};
    console.log(req.get('User-Agent'));
    var userAgent = req.get('User-Agent');
    filename = req.params.filename;
    streamApi(params,function(err, rows, result) {
        if(err || result.rowCount != 1) {
            res.status(404);
            res.send('Stream not in the Database');
            return;
        }
        var extension = filename.substr(filename.lastIndexOf('.')+1);
        console.log(extension);
        if(extension != 'm3u' && extension != 'xspf') {
            res.status(400);
            res.send('Not the right extension');
            return;
        }
        var listenurls = rows[0].listenurls;
        var outputString;
        if(extension == 'm3u') {
            outputString = '';
            for (var i = 0; i < listenurls.length; i++)
            {
                outputString += listenurls[i]+'\r\n';
            }
            res.set('Content-Type', 'audio/x-mpegurl');
            if(userAgent.indexOf('/MSIE 5.5/') != -1)
            {
                res.set('Content-Disposition', 'inline; filename="listen.m3u"');
            }
            else
            {
                res.set('Content-Disposition', 'filename="listen.m3u"');
            }
            res.send(outputString);
        } else if(extension == 'xspf') {
            var xml = xmlbuilder.create('playlist', {'version': '1.0', 'encoding': 'UTF-8'});
            xml.attribute({'version':'1','xmlns':'http://xspf.org/ns/0/'});
            xml.ele("title", rows[0].stream_name);
            xml.ele("info", rows[0].url);
            var trackList = xml.ele("trackList");
            for (var d = 0; d < listenurls.length; d++)
            {
                trackList.ele("track").ele("location", listenurls[d]);
            }
            var xmlString = xml.end({ 'pretty': true, 'indent': '  ' });
            //console.log(xmlString);
            res.set('Content-Type','application/xspf+xml');
            res.set('Content-Disposition','filename="listen.xspf"');
            if(userAgent.indexOf('/MSIE 5.5/') != -1) {
                res.set('Content-Disposition','inline; filename="listen.xspf"');
            }
            else {
                res.set('Content-Disposition','filename="listen.xspf"');
            }
            res.send(xmlString);
        }
    });
}

module.exports = init;

var http = require('http')
var querystring = require("querystring");
var request = require('request');
var conf = require('konphyg')(__dirname + '/../config');

var query = require("pg-query");
var config = conf.all().config;
var async = require('async');
query.connectionParameters = config.db;


/* Thanks stackoverflow */
function makeid()
{
    var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    for( var i=0; i < 10; i++ )
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    return text;
}

var baseUrl = "http://localhost:3000/cgi-bin/yp-cgi?";
function insertStream(name, type, genre, bitrate, listen_url, desc, url, stype, cluster_pass, callback) {
    params = {"action":"add","sn":name,"type":type,"genre":genre,"b":bitrate,"listenurl":listen_url};
    if(desc) {
        params.desc = desc;
    }
    if(url) {
        params.url = url;
    }
    if(stype) {
        params.stype = stype;
    }
    if(cluster_pass) {
        params.cpswd = cluster_pass;
    }
    request.post({"url":baseUrl, form:params}, function(error, res, body) {
        if (error || !res) {
            console.log("failure");
            callback(1);
            return;
        }
        if(!res.headers) {
            console.log("failure");
            callback(1);
            return;
        }
        if(res.headers.ypresponse && res.headers.ypresponse == 1) {
            callback(0, res.headers.sid);
        }
        else {
            console.log("unsuccesfully added");
            callback(1);
            return;
        }
        callback(0, res.headers.sid);
    });
}
function touchStream(sid, song_title, listeners, max_listeners) {
    params = {"action":"touch","sid":sid};
    if(song_title) {
        params.st = song_title;
    }
    if(listeners) {
        params.listeners = listeners;
    }
    if(max_listeners) {
        params.max_listeners = max_listeners;
    }
    request.post({"url":baseUrl, form:params}, function(error, res, body) {
        if (error || !res) {
            console.log("touch failed");
            return;
        }
        if(res.headers.ypresponse && res.headers.ypresponse == 1) {
            console.log("touched");
        }
        var listeners = Math.floor(Math.random()*10);
        var max_modifier = Math.floor(Math.random()*5)+1;
        function runtouch()
        {
            touchStream(sid, makeid(), listeners, listeners*max_modifier);
        };
        setTimeout(runtouch, (Math.random()*15000 + 5000));
    });
}
function deleteStream(sid) {
    params = {"action":"remove","sid":sid};
    request.post({"url":baseUrl, form:params}, function(error, res, body) {
        if (error) {
            return;
        }
        if(res.headers.ypresponse && res.headers.ypresponse == 1) {
            console.log("succesfully removed");
        }
    });
}



stream_types = ['audio/mpeg', 'application/ogg+vorbis','audio/aac',
'audio/aacp', 'application/ogg+theora','video/nsv'];
genres = ['Rock','Pop','Blues','Alternative','Radio','Various', 'Trance', 'Jazz','Music', 'Electro', 'Hits', 'Christian'];

function addandTouch500() {
    for(var i = 0; i< 250; i++) {
        var name = makeid();
        var randomlisten = "http://"+makeid()+".com/"+makeid()+".ogg";
        var stream_type = stream_types[Math.round(Math.random()*(stream_types.length-1))];
        var genres_string = '';
        console.log(Math.round(Math.random()*2))
        for(var j = 0;j<Math.round(Math.random()*5)+1;j++) {
            if(j != 0) {
                genres_string += ' ';
            }
            var rangen = Math.round(Math.random()*(genres.length-1));
            genres_string += genres[rangen];
        }
        insertStream(name, stream_type, genres_string, 128,randomlisten, undefined, undefined, undefined, undefined, function(err, sid) {
            if(!err) {
                var listeners = Math.floor(Math.random()*10);
                var max_modifier = Math.floor(Math.random()*5)+1;
                touchStream(sid, makeid(), listeners, listeners*max_modifier);
            }

        });
    }
}

//addandTouch500()

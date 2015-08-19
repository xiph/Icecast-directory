var query, qs, validator, config;
var async = require('async');
var foreign_key_violation = '23503';
var duplicate_key_violation = '23505';

function init(q, q_, v, c) {
    query = q;
    qs = q_;
    validator = v;
    config = c;
    return dispatcher;
}

function dispatcher(req, res) {
    if(req.body.action == "add") {
        ypAdd(req, res);
    } else if(req.body.action == "touch") {
        ypTouch(req, res);
    } else if (req.body.action == "remove") {
        ypRemove(req, res);
    }
    else {
        ypRes(res, false, "Need action argument", -1, null);
    }
    return;
}

function checkPresent(toCheck, check)
{
    for(var i=0;i<check.length;i++)
    {
        if(!(check[i] in toCheck)) {
            return false;
        }
    }
    return true;
}

function multiIndexOf(toCheck, check)
{
    for(var i=0;i<check.length;i++)
    {
        if(toCheck.indexOf(check[i]) != -1) {
            return false;
        }
    }
    return true;
}

function ypAdd(req, res) {
    //var start = new Date().getTime();
    var ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
    var params = req.body;

    var mandatoryArgs = ['sn', 'type', 'genre', 'listenurl'];

    var defaultServerNames = ['Unspecified name','This is my server name',
                             'Stream Name','My Station name', '-', 'Auto-DJ',
                             'AutoDJ','Instreamer','Stream-128','Stream-64',
                             'Stream-96','Stream-256','stream-128','stream-64',
                             'stream-96','stream-256'];

    if( checkPresent(params, mandatoryArgs) == false) {
        ypRes(res, false, "Not enough arguments.", -1, null);
        return;
    }

    if( validator.isURL(params.listenurl) == false) {
        ypRes(res, false, "Could not parse listen_url.", -1, null);
        return;
    }

    // check ban groups
    for(var ban in config.bans)
    {
        var reason = config.bans[ban].reason;
        var listenUrls = config.bans[ban].listenUrls;
        var listenIps = config.bans[ban].listenIps;
        if (listenUrls != undefined) {
            if( multiIndexOf(params.listenurl, listenUrls) == false) {
                ypRes(res, false, reason, -1, null);
                return;
            }
        }
        if (listenIps != undefined) {
            if( multiIndexOf(params.listenurl, listenIps) == false) {
                ypRes(res, false, reason, -1, null);
                return;
            }
        }
    }

    if( multiIndexOf(params.sn, defaultServerNames) == false) {
        ypRes(res, false, "Default stream name detected, please configure your \
        source client, thanks! ", -1, null);
        return;
    }

    //parse the body
    var final = parseBody(req.body);

    var insertStream = 'INSERT INTO streams (stream_name, stream_type, genres, bitrate, cluster_pass, description, url, codec_sub_types, channels, samplerate, quality) \
                        VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) \
                        RETURNING id;';
    var insertServerMount = 'INSERT INTO server_mounts (sid, stream_id, lasttouch, listenurl) \
                    VALUES (uuid_generate_v4(), $1, now(), $2) \
                    RETURNING sid;';
    //inserts new stream
    //inserts new server_mount
    async.waterfall([
    function start(cb) {
        // try to insert the Stream
        query(insertStream, [final.server_name, final.server_type, final.genres,
        final.bitrate, final.cluster_pass, final.description, final.url,
        final.codec_sub_types, final.channels, final.samplerate, final.quality], cb);
    },
    function(row,result, cb) {
        // try to insert the Server Mount
        query(insertServerMount, [row[0].id,final.listenurl], cb);
    },
    function(row,result, cb) {
        ypRes(res, true, "Successfully Added", row[0].sid, 200);

        //var end = new Date().getTime();
        //console.log("Add TimeEnd: "+ (end-start)+ " ms");
        //console.log("Add Successful")
    },
    ],
    function(err, result) {
        if(err) {
            if(err.code == duplicate_key_violation) {
                ypRes(res, false, 'Entry already in the YP. If this happens constantly your server is misconfigured! Verify that "listenurl" is reachable!', -1, null);
            } else {
                ypRes(res, false, "Server error", -1, null);
            }
        }
    });
}


function ypTouch(req, res) {
    var final = parseBody(req.body);
    var params;
    var updateServerMount = 'UPDATE server_mounts SET lasttouch = now(), songname = $2, listeners = $3'+
                        ', max_listeners = $4 WHERE sid = $1 Returning stream_id;';
    var updateStream = 'UPDATE streams SET songname = $2, codec_sub_types = $3'+
                        'WHERE id = $1;';
    async.waterfall([
    function start(cb) {
        if(final.id == undefined) {
            ypRes(res, false, "Not enough arguments.", -1, null);
            return;
        }
        if(final.listeners === undefined) {
            final.listeners = 0;
        }
        if(final.max_listeners === undefined) {
            final.max_listeners = 0;
        }
        query(updateServerMount, [final.id, final.songname, final.listeners, final.max_listeners], cb);
    },
    function(row,result, cb) {
        if(result.rowCount != 1) {
            // end with error
            cb("update failed");
            return;
        }
        params = [row[0].stream_id, final.songname,final.codec_sub_types];
        if(!final.codec_sub_types) {
            updateStream = 'UPDATE streams SET songname = $2 \
            WHERE id = $1;';
            params = [row[0].stream_id, final.songname];
        }
        query(updateStream, params, cb);
    },
    function(row,result,cb) {
        ypRes(res, true, "Successfully touched", null, null);
    }
    ],
    function(err, result) {
        if(err) {
            if(err == "update failed") {
                ypRes(res, false, "SID does not exist. Check your firewall and icecast 'hostname' setting, your server may be unreachable.", -1, null);
            }
            else {
                console.log(err);
                ypRes(res, false, "Server error", -1, null);
            }

        }
    });
}

function ypRemove(req, res) {
    var final = parseBody(req.body);
    var remove = "DELETE FROM server_mounts WHERE sid = $1 RETURNING stream_id;";
    var removeStream = "DELETE FROM streams WHERE id = $1;";
    async.waterfall([
    function start(cb) {
        query(remove, [final.id], cb);
    },
    function(row,result, cb) {
        if(result.rowCount != 1) {
            cb(1);
            return;
        }
        var idRow = row[0].stream_id;
        query(removeStream, [idRow], cb);
    },
    function(row,result, cb) {
        // if no error on delete(foreign key constraint then succesfully removed)
        ypRes(res, true, "Successfully removed", null, null);
    },
    ],
    function(err, result) {
        if(err) {
            if(err.code == foreign_key_violation) {
                // couldn't delete stream because other servers still referncing
                ypRes(res, true, "Successfully removed", null, null);
            } else {
                ypRes(res, false, "Could not find database entry", null, null);
            }
        }
    });
}

function ypRes(res, success, message, sid, tfreq) {
    res.set("YPResponse", (success === true) ? "1" : "0");
    if (message !== null) {
        res.set("YPMessage", message);
    }
    if (sid !== null) {
        res.set("SID", sid);
    }
    if (tfreq !== null) {
        res.set("TouchFreq", tfreq.toString());
    }
    res.send();
}

function parseBody(body) {
    var audio_info, final = {};
    /* Parse audio_info */
    /* Parse broken body */
    Object.keys(body).forEach(function(key) {
        if (~key.indexOf('\r\n')) {
            key = key.substring(0, key.indexOf('\r\n'));
            audio_info = qs.parse(key, {delimiter: ';'});
        }
    });
    if (body.stype) {
        body.stype = body.stype.substring(0, body.stype.indexOf('\r\n'));
    }
    /* End of hacky part */
    /* Validate bitrate */
    if (body.b && !isNaN(body.b)) {
        final.bitrate = body.b;
    } else if (audio_info) {
        if (audio_info['ice-bitrate']) audio_info.bitrate = audio_info['ice-bitrate'];
        if (audio_info.bitrate) {
            if (!isNaN(audio_info.bitrate)) {
                final.bitrate = audio_info.bitrate;
            }
        }
    }
    /* Validate Samplerate */
    if (audio_info) {
        if (audio_info['ice-samplerate']) audio_info.samplerate = audio_info['ice-samplerate'];
        if (audio_info.samplerate) {
            if (!isNaN(audio_info.samplerate)) {
                final.samplerate = audio_info.samplerate;
            }
        }
    }
    /* Validate Channels */
    if (audio_info) {
        if (audio_info['ice-channels']) audio_info.channels = audio_info['ice-channels'];
        if (audio_info.channels) {
            if (!isNaN(audio_info.channels)) {
                final.channels = audio_info.channels;
            }
        }
    }
    /* Validate Quality */
    if (audio_info) {
        if (audio_info['ice-quality']) audio_info.quality = audio_info['ice-quality'];
        if (audio_info.quality) {
            if (!isNaN(audio_info.quality)) {
                final.quality = audio_info.quality;
            }
        }
    }
    /* End of audio_info */
    /* Parse Icecast params */
    if (body.sid) {
        final.id = body.sid;
    }
    if (body.sn) {
        final.server_name = body.sn;
    }
    if (body.type) {
        final.server_type = body.type;
        if (!body.stype) {
            var buff = generateSubType(body.type);
            if (buff !== null) {
                final.codec_sub_types = buff.split(' ');
            }
        }
    }
    if (body.genre) {
        final.genres = body.genre.split(/[ ,/]/);
    }
    if (body.listenurl) {
        final.listenurl = body.listenurl;
    }
    if (body.cpswd) {
        final.cluster_pass = body.cpswd;
    }
    if (body.desc) {
        final.description = body.desc;
    }
    if (body.url) {
        final.url = body.url;
    }
    if (body.stype) {
        final.codec_sub_types = body.stype.split(' ');
    }
    if (body.st) {
        final.songname = body.st;
    }
    if (body.listeners && !isNaN(body.listeners)) {
        final.listeners = body.listeners;
    }
    if (body.max_listeners && !isNaN(body.max_listeners)) {
        final.max_listeners = body.max_listeners;
    }
    /* End of Icecast params */
    //console.log(final);
    return final;
}

function generateSubType(type) {
    var stype;
    if (type === 'audio/opus' || type === 'application/ogg+opus') {
        stype = 'Opus';
    }
    else if (type === 'audio/ogg' || type === 'application/ogg' || type === 'application/ogg+vorbis' || type === 'application/x-ogg') {
        stype = 'Vorbis';
    }
    else if (type === 'application/mp3' || type === 'audio/x-mpeg' || type === 'audio/mpeg' || type === 'audio/MPA' || type === 'audio/mpa-robust') {
        stype = 'MP3';
    }
    else if (type === 'audio/aac' || type === 'audio/mp4') {
        stype = 'AAC';
    }
    else if (type === 'audio/aacp') {
        stype = 'AAC+';
    }
    else if (type === 'video/webm' || type === 'audio/webm') {
        stype = 'WebM';
    }
    else if (type === 'video/ogg' || type === 'application/ogg+theora') {
        stype = 'Theora';
    }
    else if (type === 'video/nsv') {
        stype = 'NSV';
    }
    else {
        stype = null;
    }
    return stype;
}

module.exports = init;

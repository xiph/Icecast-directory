var query, qs;

function init(q, q_) {
    query = q;
    qs = q_;
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
}

function ypAdd(req, res) {
    if (req.body.listenurl.indexOf("http://localhost") != -1 ||
        req.body.listenurl.indexOf("https://localhost") != -1) {
        ypRes(res, false, "Your hostname is localhost, this is an indicator of a misconfigured server", -1, null);
        return;
    }
    if (req.body.sn === 'Unspecified name') {
        ypRes(res, false, "You have to specify a name for your stream.", -1, null);
        return;
    }

    var final = parseBody(req.body);
    var insert = 'INSERT INTO servers (id, lasttouch, server_name, server_type, genres, bitrate, listenurl, \
                    cluster_pass, description, url, codec_sub_types, channels, samplerate, quality) \
                    VALUES (uuid_generate_v4(), now(), $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12) \
                    RETURNING id;'
    query(insert, [final.server_name, final.server_type, final.genres, final.bitrate,
                    final.listenurl, final.cluster_pass, final.description, final.url,
                    final.codec_sub_types, final.channels, final.samplerate, final.quality],
    function(err, rows, result) {
        console.log(err);
        if (err) {
            ypRes(res, false, "Error adding the stream", -1, null);
        } else {
            ypRes(res, true, "Successfully Added", rows[0].id, 200);
        };
    });
}

function ypTouch(req, res) {
    var final = parseBody(req.body);
    if (final.codec_sub_types) {
        var touch = "UPDATE servers SET lasttouch = now(), songname = $2, listeners = $3, max_listeners = $4, codec_sub_types = $5 WHERE id = $1;";
        query(touch, [final.id, final.songname, final.listeners, final.max_listeners, final.codec_sub_types], function(err, row, result) {
            if (err || result.rowCount === 0) {
                ypRes(res, false, "Could not find database entry", null, null);
            } else {
                ypRes(res, true, "Successfully touched", null, null);
            }
        });
    } else {
        var touch = "UPDATE servers SET lasttouch = now(), songname = $2, listeners = $3, max_listeners = $4 WHERE id = $1;";
        query(touch, [final.id, final.songname, final.listeners, final.max_listeners], function(err, row, result) {
            if (err || result.rowCount === 0) {
                ypRes(res, false, "Could not find database entry", null, null);
            } else {
                ypRes(res, true, "Successfully touched", null, null);
            }
        });
    }
}

function ypRemove(req, res) {
    var final = parseBody(req.body);
    var remove = "DELETE FROM servers WHERE id = $1;";
    query(remove, [final.id], function(err, row, result) {
        if (err) {
            ypRes(res, false, "Could not find database entry", null, null);
        } else {
            ypRes(res, true, "Successfully removed", null, null);
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
    console.log(final);
    return final;
}

function generateSubType(type) {
    var stype;
    if (type === 'audio/opus') {
        stype = 'Opus';
    }
    else if (type === 'audio/ogg' || type === 'application/ogg') {
        stype = 'Vorbis';
    }
    else if (type === 'audio/mpeg' || type === 'audio/MPA' || type === 'audio/mpa-robust') {
        stype = 'MP3';
    }
    else if (type === 'audio/aac' || type === 'audio/mp4') {
        stype = 'AAC';
    }
    else if (type === 'audio/aacp') {
        stype = 'AAC+';
    }
    else if (type === 'video/webm') {
        stype = 'WebM';
    }
    else if (type === 'video/ogg') {
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

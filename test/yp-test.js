var should = require("should");;
var request = require("supertest");
var express = require('express');
var querstring = require("querystring");
var conf = require('konphyg')(__dirname + '/../config');

var app = require("../app.js").getApp;
var query = require("pg-query");
var config = conf.all().config;
var async = require('async');
query.connectionParameters = config.db;



function testPost(params, callback) {
    request(app)
      .post('/cgi-bin/yp-cgi')
      .set('Content-Type', 'application/x-www-form-urlencoded')
      .send(params)
      .expect(200)
      .end(callback);
}

describe('POST /cgi-bin/yp-cgi', function(){

    beforeEach(function(done) {
        // beforeEach cleanTables
        var cleanDatabase= 'DELETE FROM server_mounts; DELETE FROM streams;';
        query(cleanDatabase, function(err, rows) {
            if(err) return done(err);
            done();
        });
    });

    /* Test Add */
    it('add stream fails on not enough arguments', function(done){
        var params = {action:"add"};
        testPost(params, function(err, res) {
            if (err) return done(err);
            res.headers.ypresponse.should.equal('0');
            res.headers.ypmessage.should.equal('Not enough arguments.');
            done();
        });
    });

    it('add stream fails on listenurl not being a listenurl', function(done){
        var params = {"action":"add","sn":"Test Name","type":"audio/ogg","genre":"Rock Pop","b":128,"listenurl":"http://testurl:80/test.ogg"};
        testPost(params, function(err, res) {
            if (err) return done(err);
            res.headers.ypresponse.should.equal('0');
            res.headers.ypmessage.should.equal('Could not parse listen_url.');
            done();
        });
    });

    it('inserting the same stream will return an error', function(done){
        var params = {"action":"add","sn":"Test Name","type":"audio/ogg","genre":"Rock Pop","b":128,"listenurl":"http://testurl.com:80/test.ogg"}
        testPost(params, function(err, res) {
            if (err) return done(err);
            res.headers.ypresponse.should.equal('1')
            // save sid for deletion
            var delsid = res.headers.sid;
            // try inserting again
            testPost(params, function(err, res) {
                if (err) return done(err);
                res.headers.ypresponse.should.equal('0');
                done();
            });
        });
    });


    it('add delete stream succeeds', function(done){
        var params = {"action":"add","sn":"Test Name","type":"audo/ogg","genre":"Rock Pop","b":128,"listenurl":"http://testurl.com:80/test.ogg"}
        testPost(params, function(err, res) {
            if (err) return done(err);
            res.headers.ypresponse.should.equal('1');
            done();
        });
    });

    /* Test Touch */
    it('test touch fails if not enough arguments', function(done){
        var params = {"action":"touch"}
        testPost(params, function(err, res) {
            if (err) return done(err);
            res.headers.ypresponse.should.equal('0');
            res.headers.ypmessage.should.equal('Not enough arguments.');
            done();
        });
    });

    it('test touch fails if sid not in the db', function(done){
        var params = {"action":"touch","sid":"0be387a8-0fab-4d35-a1b5-8a2222802a94"}
        testPost(params, function(err, res) {
            if (err) return done(err);
            res.headers.ypresponse.should.equal('0');
            res.headers.ypmessage.should.equal("SID does not exist. Check your firewall and icecast 'hostname' setting, your server may be unreachable.");
            done();
        });
    });

    after(function(done) {
        var cleanDatabase= 'DELETE FROM server_mounts; DELETE FROM streams;';
        query(cleanDatabase, function(err, rows) {
            if(err) return done(err);
            done();
        });
    });


});

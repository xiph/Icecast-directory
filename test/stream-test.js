var should = require("should");;
var request = require("supertest");
var express = require('express');
var querstring = require("querystring");
var conf = require('konphyg')(__dirname + '/../config');

var app = require("../app.js").getApp;
var query = require("pg-query");
var config = conf.all().config;
var async = require('async');
var fs = require('fs');

var sqlCreateTestDB = fs.readFileSync(__dirname+'/init_test_database.sql').toString()
query.connectionParameters = config.db;




describe('GET /streams', function(){
    before(function(done) {
        // beforeEach cleanTables
        var cleanDatabase= 'DELETE FROM server_mounts; DELETE FROM streams;';
        query(cleanDatabase, function(err, rows) {
            if(err) return done(err);
            query(sqlCreateTestDB, function(err, rows) {
                if(err) return done(err);
                done();
            })
        });
    });


    it('limit works correctly', function(done){
        var params = {"limit":10, "order":-1}
        var qstring = querystring.stringify(params);
        request(app)
        .get('/streams?'+qstring)
        .set('Accept', 'application/json')
        .expect('Content-Type', /json/)
        .expect(200)
        .end(function(err, res){
            if (err) return done(err);
            var result = JSON.parse(res.text);
            result.streams.length.should.equal(10);
            done()
        });
    });

    it('starting after and ending before urls present', function(done){
        var params = {"limit":10, "order":0, "genre":"Rock"}
        var qstring = querystring.stringify(params);
        request(app)
        .get('/streams?'+qstring)
        .set('Accept', 'application/json')
        .expect('Content-Type', /json/)
        .expect(200)
        .end(function(err, res){
            if (err) return done(err);
            var result = JSON.parse(res.text);
            result.data.should.have.property('next_url');
            result.data.should.have.property('prev_url');
            done()
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

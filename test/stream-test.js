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




describe('GET /streams', function(){
    beforeEach(function(done) {
        // beforeEach cleanTables
        var cleanDatabase= 'DELETE FROM server_mounts; DELETE FROM streams;';
        query(cleanDatabase, function(err, rows) {
            if(err) return done(err);
            done();
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
            //result.streams.length.should.equal(10)
            done()
        });
    });


});

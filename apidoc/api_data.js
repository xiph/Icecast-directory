define({ "api": [  {    "type": "get",    "url": "/formats/",    "title": "Get a list of Formats",    "name": "GetFormats",    "group": "Formats",    "success": {      "fields": {        "Success 200": [          {            "group": "Success 200",            "type": "<p>List</p> ",            "optional": false,            "field": "-",            "description": "<p>List of formats</p> "          }        ]      },      "examples": [        {          "title": "Success-Response:",          "content": "HTTP/1.1 200 OK\n[\n  {\"val\":\"Vorbis\"},\n  {\"val\":\"MP3\"}\n]",          "type": "json"        }      ]    },    "version": "0.0.0",    "filename": "./app.js",    "groupTitle": "Formats"  },  {    "type": "get",    "url": "/genres/",    "title": "Get a list of Genres",    "name": "GetGenres",    "group": "Genres",    "success": {      "fields": {        "Success 200": [          {            "group": "Success 200",            "type": "<p>List</p> ",            "optional": false,            "field": "-",            "description": "<p>List of genres</p> "          }        ]      },      "examples": [        {          "title": "Success-Response:",          "content": "HTTP/1.1 200 OK\n[\n  {\"val\":\"Rock\"},\n  {\"val\":\"Pop\"}\n]",          "type": "json"        }      ]    },    "version": "0.0.0",    "filename": "./app.js",    "groupTitle": "Genres"  },  {    "type": "get",    "url": "/streams/:id",    "title": "Get Individual Stream",    "name": "GetStream",    "group": "Streams",    "parameter": {      "fields": {        "Parameter": [          {            "group": "Parameter",            "type": "<p>Number</p> ",            "optional": false,            "field": "id",            "description": "<p>Stream unique ID.</p> "          }        ]      }    },    "success": {      "fields": {        "Success 200": [          {            "group": "Success 200",            "type": "<p>Object</p> ",            "optional": false,            "field": "_",            "description": "<p>Describes the stream</p> "          }        ]      },      "examples": [        {          "title": "Success-Response:",          "content": "HTTP/1.1 200 OK\n{\n  \"id\":8,\n  \"stream_name\":\"TestStream7\",\n  \"stream_type\":\"audio/ogg\",\n  \"description\":\"Really Cool Stream\",\n  \"songname\":\"TestSong\",\n  \"url\":\"http://fake.com\",\n  \"avg_listening_time\":null,\n  \"codec_sub_types\":[\"Vorbis\"],\n  \"bitrate\":128,\n  \"hits\":null,\n  \"cm\":null,\n  \"samplerate\":44100,\n  \"channels\":2,\n  \"quality\":null,\n  \"genres\":[\"Rock\"],\n  \"listenurls\":[\"http://fake.com:8000/stream\"],\n  \"listeners\":3,\n  \"max_listeners\":100\n}",          "type": "json"        }      ]    },    "error": {      "examples": [        {          "title": "Error-Response:",          "content": "HTTP/1.1 404 Not Found\n{\n}",          "type": "json"        }      ]    },    "version": "0.0.0",    "filename": "./app.js",    "groupTitle": "Streams"  },  {    "type": "get",    "url": "/streams/",    "title": "Get a list of Streams",    "name": "GetStreams",    "group": "Streams",    "parameter": {      "fields": {        "Parameter": [          {            "group": "Parameter",            "type": "<p>String</p> ",            "optional": false,            "field": "format",            "description": "<p>Format to search by.</p> "          },          {            "group": "Parameter",            "type": "<p>String</p> ",            "optional": false,            "field": "genre",            "description": "<p>Genre to seach by.</p> "          },          {            "group": "Parameter",            "type": "<p>String</p> ",            "optional": false,            "field": "q",            "description": "<p>Search string.</p> "          },          {            "group": "Parameter",            "type": "<p>Number</p> ",            "allowedValues": [              "-1",              "0",              "1"            ],            "optional": false,            "field": "order",            "description": "<p>-1=Random order 0=Descending 1=Ascending.</p> "          },          {            "group": "Parameter",            "type": "<p>Number</p> ",            "optional": false,            "field": "limit",            "description": "<p>Number of results to return.</p> "          },          {            "group": "Parameter",            "type": "<p>Number</p> ",            "optional": false,            "field": "starting_after",            "description": "<p>ID of stream to return results after(Requires order, cannot have ending_before).</p> "          },          {            "group": "Parameter",            "type": "<p>Number</p> ",            "optional": false,            "field": "ending_before",            "description": "<p>ID of stream to return results before(Requires order, cannot have starting_after).</p> "          },          {            "group": "Parameter",            "type": "<p>Number</p> ",            "optional": false,            "field": "last_listener_count",            "description": "<p>listener count of the id passed in with starting_after or ending_before. Allows pagination to get close if the id passed in is deleted.</p> "          }        ]      }    },    "success": {      "fields": {        "Success 200": [          {            "group": "Success 200",            "type": "<p>List</p> ",            "optional": false,            "field": "streams",            "description": "<p>List of stream objects(See get individual stream for an example)</p> "          },          {            "group": "Success 200",            "type": "<p>Object</p> ",            "optional": false,            "field": "data",            "description": "<p>Contains starting_after and ending_before urls for this data</p> "          }        ]      },      "examples": [        {          "title": "Success-Response:",          "content": "HTTP/1.1 200 OK\n{\n  \"streams\":[],\n  \"data\":{\"starting_after\":\"/streams?limit=2&starting_after=20\"},\n}\nView getting a single stream to see what the stream data will look like",          "type": "json"        }      ]    },    "error": {      "fields": {        "Error 4xx": [          {            "group": "Error 4xx",            "type": "<p>String</p> ",            "optional": false,            "field": "error",            "description": "<p>Contains an error message describing the issue</p> "          }        ]      },      "examples": [        {          "title": "Error-Response:",          "content": "HTTP/1.1 400 Bad Request\n{\n  \"error\":\"error message describing issue\"\n}",          "type": "json"        }      ]    },    "version": "0.0.0",    "filename": "./app.js",    "groupTitle": "Streams"  },  {    "success": {      "fields": {        "Success 200": [          {            "group": "Success 200",            "optional": false,            "field": "varname1",            "description": "<p>No type.</p> "          },          {            "group": "Success 200",            "type": "<p>String</p> ",            "optional": false,            "field": "varname2",            "description": "<p>With type.</p> "          }        ]      }    },    "type": "",    "url": "",    "version": "0.0.0",    "filename": "./apidoc/main.js",    "group": "_Users_marcof_Documents_icecast_directory_apidoc_main_js",    "groupTitle": "_Users_marcof_Documents_icecast_directory_apidoc_main_js",    "name": ""  }] });
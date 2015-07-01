DROP EXTENSION IF EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
DROP TABLE IF EXISTS server_mounts;
DROP TABLE IF EXISTS streams;
CREATE TABLE IF NOT EXISTS server_mounts (
	sid uuid NOT NULL,
	stream_id INTEGER REFERENCES streams(id),
	listenurl VARCHAR DEFAULT NULL,
	listeners INTEGER DEFAULT NULL,
	max_listeners INTEGER DEFAULT NULL,
	songname VARCHAR DEFAULT NULL,
	lasttouch TIMESTAMP NOT NULL,
	PRIMARY KEY  (sid),
	UNIQUE(listenurl)
);

CREATE TABLE IF NOT EXISTS streams (
  	id serial NOT NULL,
	stream_name VARCHAR NOT NULL,
	stream_type VARCHAR NOT NULL,
	description VARCHAR DEFAULT NULL,
	url VARCHAR DEFAULT NULL,
	songname VARCHAR DEFAULT NULL,
	avg_listening_time INTEGER DEFAULT NULL,
	codec_sub_types VARCHAR[] DEFAULT NULL,
	bitrate SMALLINT DEFAULT NULL,
	hits INTEGER DEFAULT NULL,
	cm INTEGER DEFAULT NULL,
	channels SMALLINT DEFAULT NULL,
	samplerate INTEGER DEFAULT NULL,
	quality DECIMAL(2) DEFAULT NULL,
	cluster_pass VARCHAR DEFAULT NULL,
	genres VARCHAR[] DEFAULT NULL,
	PRIMARY KEY  (id),
	UNIQUE(stream_name, bitrate, codec_sub_types)
);

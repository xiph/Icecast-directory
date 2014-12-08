DROP EXTENSION if exists "uuid-ossp";
CREATE EXTENSION if not exists "uuid-ossp";

DROP TABLE if exists servers;
CREATE TABLE if not exists servers (
	id uuid NOT NULL,
	lasttouch timestamp NOT NULL,
	server_name varchar default NULL,
	server_type varchar default NULL,
	genres varchar[] default NULL,
	bitrate smallint default NULL,
	listenurl varchar default NULL,
	cluster_pass varchar default NULL,
	description varchar default NULL,
	url varchar default NULL,
	codec_sub_types varchar[] default NULL,
	songname varchar default NULL,
	listeners int default NULL,
	max_listeners int default NULL,
	avg_listening_time int default NULL,
	hits int default NULL,
	cm int default NULL,
	channels smallint default NULL,
	samplerate int default NULL,
	quality decimal(2) default NULL,
	PRIMARY KEY  (id)
);
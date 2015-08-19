--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: server_mounts; Type: TABLE; Schema: public; Owner: marcof; Tablespace:
--
DROP TABLE IF EXISTS server_mounts;
DROP TABLE IF EXISTS streams;
CREATE TABLE server_mounts (
    sid uuid NOT NULL,
    stream_id integer,
    listenurl character varying,
    listeners integer DEFAULT 0,
    max_listeners integer DEFAULT 0,
    songname character varying,
    lasttouch timestamp without time zone NOT NULL
);


ALTER TABLE server_mounts OWNER TO marcof;

--
-- Name: streams; Type: TABLE; Schema: public; Owner: marcof; Tablespace:
--

CREATE TABLE streams (
    id integer NOT NULL,
    stream_name character varying NOT NULL,
    stream_type character varying NOT NULL,
    description character varying,
    url character varying,
    songname character varying,
    avg_listening_time integer,
    codec_sub_types character varying[],
    bitrate smallint,
    hits integer,
    cm integer,
    channels smallint,
    samplerate integer,
    quality numeric(2,0) DEFAULT NULL::numeric,
    cluster_pass character varying,
    genres character varying[]
);


ALTER TABLE streams OWNER TO marcof;

--
-- Name: streams_id_seq; Type: SEQUENCE; Schema: public; Owner: marcof
--

CREATE SEQUENCE streams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE streams_id_seq OWNER TO marcof;

--
-- Name: streams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marcof
--

ALTER SEQUENCE streams_id_seq OWNED BY streams.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: marcof
--

ALTER TABLE ONLY streams ALTER COLUMN id SET DEFAULT nextval('streams_id_seq'::regclass);


--
-- Data for Name: server_mounts; Type: TABLE DATA; Schema: public; Owner: marcof
--

INSERT INTO server_mounts VALUES ('e79eb84c-95a0-4f0c-ad6e-f1e5f8f86c26', 836, 'http://4m54aT6DN5.com/cjStdI3Yjw.ogg', 0, 0, 'Noz8MLWshj', '2015-08-18 23:42:35.04485');
INSERT INTO server_mounts VALUES ('68ad9fa3-388c-47d8-9fa2-9d4882ddc732', 809, 'http://7uw8ANbwYg.com/GzsQe7IX7Q.ogg', 9, 18, '4VoKoYQaQt', '2015-08-18 23:42:35.044089');
INSERT INTO server_mounts VALUES ('229f1c34-5d17-4b4c-ae09-20a4f74bc40e', 1035, 'http://rgYTV5ZN9b.com/owWFSMJLu8.ogg', 8, 24, 'vJCszEKwjm', '2015-08-18 23:42:33.806613');
INSERT INTO server_mounts VALUES ('55c2f803-5050-4fc4-9673-1af8b2cae618', 987, 'http://Xa3C1Wviwi.com/SsfSJSBz3f.ogg', 1, 1, 'w0YBLXDTqL', '2015-08-18 23:42:37.900619');
INSERT INTO server_mounts VALUES ('ec54bef2-f288-4719-95c0-74c46b447c79', 855, 'http://BHcPJdiaAN.com/N02tcDLoYp.ogg', 4, 20, 'IMUQ2TOIL3', '2015-08-18 23:42:40.006268');
INSERT INTO server_mounts VALUES ('9cb59da9-aaac-40ef-8457-abe1e83fd3a4', 822, 'http://eSYNSMrzVj.com/Ew0UJAo6lC.ogg', 7, 7, 'Y1XutGvIdW', '2015-08-18 23:42:27.664398');
INSERT INTO server_mounts VALUES ('6c1a145c-44c7-4b47-a82c-17458af4b133', 1008, 'http://kxenvXidim.com/33pwZ5u6KU.ogg', 4, 8, '5VL8e6SknY', '2015-08-18 23:42:40.08166');
INSERT INTO server_mounts VALUES ('4f088230-07c8-42c6-aeaa-45b29c8d9c9b', 995, 'http://IMiMydnrBy.com/9vajHR0Kd8.ogg', 9, 36, '05H9ZRg9uJ', '2015-08-18 23:42:33.853888');
INSERT INTO server_mounts VALUES ('dd473202-52f0-4321-86ec-21ea5744dda4', 862, 'http://EKR96fN6OB.com/IjVUVvRxkw.ogg', 4, 20, 'lNWEOmJRnt', '2015-08-18 23:42:28.008118');
INSERT INTO server_mounts VALUES ('3fa8e693-08d0-4c6d-9bca-3e95dac7cf82', 929, 'http://jbVg0CQveA.com/v8OIZfdV2e.ogg', 0, 0, '2pXHtc7X2m', '2015-08-18 23:42:40.148601');
INSERT INTO server_mounts VALUES ('1e938eb2-880f-4114-af16-32f9a8bba124', 943, 'http://Y4IC5FdXqB.com/szfBldoEOu.ogg', 0, 0, 'WD7orBXoF4', '2015-08-18 23:42:38.063186');
INSERT INTO server_mounts VALUES ('a80e04ad-c235-444f-bf39-6636aeba0e1f', 947, 'http://LNsROb0oOj.com/kEZdQqi99J.ogg', 1, 2, 'VEfepxmY1O', '2015-08-18 23:42:33.893375');
INSERT INTO server_mounts VALUES ('d28bf006-2af1-4280-a969-66456b4c9a10', 844, 'http://fcwyUO738K.com/sUMvwIm2IU.ogg', 8, 24, 'R1jqRNwc3h', '2015-08-18 23:42:33.933661');
INSERT INTO server_mounts VALUES ('f7353f17-0934-4d15-adaf-013fffee42ca', 907, 'http://oOu4k9vos5.com/DSRZVJao7R.ogg', 5, 5, 'fRUbkfGhtN', '2015-08-18 23:42:28.038137');
INSERT INTO server_mounts VALUES ('29b1c099-6425-483d-b108-1b51fabfa414', 891, 'http://aFoIfQyYbO.com/r6qoCw4Hx9.ogg', 5, 25, 'UTvP356ej2', '2015-08-18 23:42:38.38338');
INSERT INTO server_mounts VALUES ('e12a3819-fb62-4572-b9f2-cd2f8f38095c', 832, 'http://5asfyoUyjh.com/68zAAsdLkW.ogg', 3, 9, 'b1s2w3Kfsx', '2015-08-18 23:42:38.420903');
INSERT INTO server_mounts VALUES ('f3b8cd36-0c9a-45da-bd9b-a96c390ce4f4', 918, 'http://fNqbEpigAu.com/YBgIErkWjc.ogg', 2, 4, 'rTuuTjc2fb', '2015-08-18 23:42:28.045686');
INSERT INTO server_mounts VALUES ('24d623cf-6dc3-4b05-b163-7ed5cdc23242', 882, 'http://dkobOJGqRo.com/oiTN38Ynr5.ogg', 0, 0, 'UeqXODWqWH', '2015-08-18 23:42:28.014981');
INSERT INTO server_mounts VALUES ('3dbd2c2e-fdc9-468b-8808-8cc99e64b082', 954, 'http://esny6WictT.com/lOm0Q6EgFX.ogg', 0, 0, 'oH32elGIF7', '2015-08-18 23:42:28.076283');
INSERT INTO server_mounts VALUES ('1f8afd98-819c-43f6-a6d6-4776a90c6ef1', 1000, 'http://q9mxGfXRqi.com/PlF9LBs6zf.ogg', 9, 18, 'FY8LU3a7Ip', '2015-08-18 23:42:34.301067');
INSERT INTO server_mounts VALUES ('5cdcd1cf-d8bb-4255-93dc-855f71f2235d', 912, 'http://vHXueFmoiV.com/0J3jSRIbqg.ogg', 4, 4, 'bFdr3Vks2K', '2015-08-18 23:42:28.048604');
INSERT INTO server_mounts VALUES ('bbcd1619-68ec-4b8d-b454-e88ceb77feff', 985, 'http://eOOqT1e3dY.com/96UtA57efi.ogg', 0, 0, 'CuzBl2Jjzc', '2015-08-18 23:42:35.354928');
INSERT INTO server_mounts VALUES ('b0c9742d-b740-4dd1-a6db-79585a94bf6e', 898, 'http://2CrDQHB7v1.com/bxxrlyX8ou.ogg', 6, 30, 'WJNzNZrAEH', '2015-08-18 23:42:28.025032');
INSERT INTO server_mounts VALUES ('9b65a159-4eb0-41ab-9271-33d2284f8f7e', 924, 'http://sjNJ68FueH.com/4mS6r5JhXD.ogg', 6, 6, 'BdWkQuMifA', '2015-08-18 23:42:28.054278');
INSERT INTO server_mounts VALUES ('d67b891f-f627-47cf-97b6-d27039068007', 938, 'http://FJhc7WX95X.com/16sh1FJFMc.ogg', 1, 1, 'UoNy9VHLUv', '2015-08-18 23:42:35.697919');
INSERT INTO server_mounts VALUES ('cc6e5d2e-0b36-4c7b-8afd-1bff24f7705c', 859, 'http://akTpZelJ2H.com/hXsvlYuiYy.ogg', 0, 0, 'qjNQULbDfF', '2015-08-18 23:42:38.492182');
INSERT INTO server_mounts VALUES ('65506555-11fa-4ef8-bf9f-f238dc6b2094', 1025, 'http://uEJidXBiS8.com/wASiSU832Z.ogg', 3, 6, 'MBry0fsPNB', '2015-08-18 23:42:28.129617');
INSERT INTO server_mounts VALUES ('2384ab2b-02a4-43e4-84ad-449ede2a422b', 972, 'http://odQDhiVKpP.com/J09KqIDRXJ.ogg', 1, 5, '0E53unfR2W', '2015-08-18 23:42:38.506157');
INSERT INTO server_mounts VALUES ('81c99a8f-80c2-4442-ae31-170f716dae4e', 997, 'http://Ps5TeGSZtA.com/gzJS1RtXFZ.ogg', 5, 20, 'YE0Yz13JLp', '2015-08-18 23:42:38.585492');
INSERT INTO server_mounts VALUES ('dbebb3d5-1bee-417e-9e8d-a3929b4f3c69', 1005, 'http://EP5WxTk1wO.com/tD4A5xXwpy.ogg', 3, 9, 'C09ey60nwF', '2015-08-18 23:42:39.154932');
INSERT INTO server_mounts VALUES ('460e5181-a819-4ea1-bae0-ce4ffd165cf4', 866, 'http://cfouQeB2gY.com/Q5vjAIgiYg.ogg', 6, 24, 'u3Ke4Dj5rU', '2015-08-18 23:42:39.22762');
INSERT INTO server_mounts VALUES ('e80bfe30-0e1c-405d-a00a-f0ce7b21e4e6', 904, 'http://kP0JivA8g2.com/TFcfL1Mlmy.ogg', 0, 0, 'ZdwMfkv2wh', '2015-08-18 23:42:39.281601');
INSERT INTO server_mounts VALUES ('e2aae5ee-3430-4b01-97bc-e6ccf5c644aa', 958, 'http://zTnPimwyqu.com/31sqngzDG3.ogg', 5, 5, 'k2Hi75h7qk', '2015-08-18 23:42:36.389947');
INSERT INTO server_mounts VALUES ('54bb1d92-5115-4c30-a2ff-e0e98628320f', 959, 'http://sxqnM87swo.com/vfwIJblLUq.ogg', 5, 10, 'ZPq5JNeciD', '2015-08-18 23:42:28.084986');
INSERT INTO server_mounts VALUES ('d9d8838d-213a-4a93-90fc-ed52f48e2a56', 816, 'http://eUq8nRrdpT.com/CFZReswYKQ.ogg', 5, 25, 'XAnofDffNz', '2015-08-18 23:42:39.321503');
INSERT INTO server_mounts VALUES ('60ab11ea-38ac-4f71-9a0d-302ae2751625', 1033, 'http://2X7sEY24OU.com/Z5v7SztOaC.ogg', 3, 15, 'o0S5uaRwwe', '2015-08-18 23:42:28.13474');
INSERT INTO server_mounts VALUES ('5fbe4c96-df23-4994-afbb-5ff1b4e60a73', 975, 'http://j6UvCSzjGj.com/IuR8mnft0r.ogg', 5, 15, 'WttrY2xT6v', '2015-08-18 23:42:28.096042');
INSERT INTO server_mounts VALUES ('8ed6e38b-044d-4268-a4ab-d15d5daa7901', 871, 'http://SNDznoihdL.com/iRobOhWMzp.ogg', 5, 10, 'BckbaXLRKP', '2015-08-18 23:42:39.659967');
INSERT INTO server_mounts VALUES ('55f10439-342e-4a1c-88da-b4985fbb0b4a', 850, 'http://LczJld2V92.com/49s3ZDLTGl.ogg', 3, 12, 'xPXVEOGph3', '2015-08-18 23:42:39.76255');
INSERT INTO server_mounts VALUES ('ee2479de-0aa2-4319-969d-6da7f5e3df15', 1042, 'http://skGRrej6sL.com/C3Bifnnf92.ogg', 2, 6, 'RJ8Q8oAqnP', '2015-08-18 23:42:36.624099');
INSERT INTO server_mounts VALUES ('ae05eb24-81f5-4fb6-be24-6174b09f30c8', 1018, 'http://YBGgRIWo0x.com/dQV2ff7KdG.ogg', 0, 0, 'EpVFyXCul2', '2015-08-18 23:42:28.122744');
INSERT INTO server_mounts VALUES ('075e4b29-0656-40b0-b8ac-c38a23686325', 1044, 'http://5XttHl5sLN.com/ZN4Jw9OeMZ.ogg', 6, 24, 'EwLY3fzU5u', '2015-08-18 23:42:28.14303');
INSERT INTO server_mounts VALUES ('3fefd466-5980-433b-bfd9-34fc6de5b4dc', 880, 'http://LkwHz57nxl.com/BGZSsXYs59.ogg', 4, 4, '7acYS1VCQS', '2015-08-18 23:42:39.896858');
INSERT INTO server_mounts VALUES ('dd735a25-0a8b-41e2-9ae9-cbf7911595dc', 840, 'http://wL1ffdqacY.com/2qCSjpDjKx.ogg', 1, 5, 'zaXzElYZje', '2015-08-18 23:42:33.776784');
INSERT INTO server_mounts VALUES ('b3b8cf39-1d38-4c5e-9431-d2d480c927e3', 901, 'http://w14BJqwncQ.com/4MueovXitg.ogg', 8, 40, 'cD8NfsSLO7', '2015-08-18 23:42:37.07474');
INSERT INTO server_mounts VALUES ('53f05f45-ea12-4c07-9d41-4d3b1123c41d', 927, 'http://KFtKotRf9w.com/fDysKxEba3.ogg', 6, 18, 'ln9WHcbpqS', '2015-08-18 23:42:37.458366');
INSERT INTO server_mounts VALUES ('c5a7c483-3097-4113-a651-e79e974b1286', 963, 'http://XeNrXIOJxw.com/ApglpIdtHI.ogg', 6, 30, 'IftnE16686', '2015-08-18 23:42:37.696762');
INSERT INTO server_mounts VALUES ('a590f96a-c6aa-4da4-8ef5-21d4d592c186', 890, 'http://45LpW0iIMG.com/9HEu7w6XYs.ogg', 4, 16, '3lDmILkSsc', '2015-08-18 23:42:35.788331');
INSERT INTO server_mounts VALUES ('10f27874-85ed-4a14-98f5-cb350a166497', 991, 'http://SE8oEyDFNk.com/Biv5eVDS2Z.ogg', 0, 0, '70AO9DpsXz', '2015-08-18 23:42:35.94639');
INSERT INTO server_mounts VALUES ('66c39c61-4408-4548-b171-47b4e9b9e873', 965, 'http://HEDShh7mrV.com/umroGkVFoX.ogg', 4, 12, 'KYlwlSdnl7', '2015-08-18 23:42:36.139541');
INSERT INTO server_mounts VALUES ('64ac6562-3ceb-4e2f-af0e-8952716251b1', 937, 'http://yoLyh90jmG.com/jI2maVjrhy.ogg', 3, 3, 'Xm2tOBfonC', '2015-08-18 23:42:36.725446');
INSERT INTO server_mounts VALUES ('5b8563ac-6e29-45c1-ae9d-295579a9917f', 980, 'http://Fwdrzafbhr.com/Vqt31iEqFy.ogg', 0, 0, '6JNky58Kqt', '2015-08-18 23:42:28.099176');
INSERT INTO server_mounts VALUES ('745669b6-1edf-480d-9d01-834b60e88360', 829, 'http://A0ZI7YTJNd.com/ONEhtPfd1N.ogg', 2, 8, 'L74waxebyU', '2015-08-18 23:42:27.684359');
INSERT INTO server_mounts VALUES ('37dfd20b-9b81-4cdd-a63b-19ce5b7c2b43', 835, 'http://i1eduSENXJ.com/7NCnAXzG6w.ogg', 9, 45, '9jOcBAaCJZ', '2015-08-18 23:42:27.844131');
INSERT INTO server_mounts VALUES ('8feaaf3f-715d-450e-a089-4c50967db73b', 838, 'http://m64ssFivSp.com/GZD1G2rvwU.ogg', 6, 12, 'VwSQZstjFA', '2015-08-18 23:42:27.982635');
INSERT INTO server_mounts VALUES ('666201e4-5b80-463c-8f78-0b2663d81fc2', 956, 'http://3esm0R0htY.com/SEy3e6kJ3F.ogg', 0, 0, 'gZGxY7HZVn', '2015-08-18 23:42:37.029414');
INSERT INTO server_mounts VALUES ('a0490df5-cb52-4767-9657-1c332ebfcd8e', 863, 'http://7Ik4EWUgxQ.com/mneoup4dSN.ogg', 8, 16, 'xKxA7fVLMy', '2015-08-18 23:42:28.001556');
INSERT INTO server_mounts VALUES ('bf665e85-5fa3-4aad-b633-20089b8fc5c8', 873, 'http://ZQYSAvH4c6.com/UpbvSRFy4E.ogg', 0, 0, 'jMGCwCjV8t', '2015-08-18 23:42:37.09874');
INSERT INTO server_mounts VALUES ('38519b16-6055-4ad1-ba0f-5f692f82afaa', 1031, 'http://eNNqpgeO6m.com/Va8aoYpt4F.ogg', 4, 20, 'dT8Q7pxUEW', '2015-08-18 23:42:37.148676');
INSERT INTO server_mounts VALUES ('dabef9ff-0fa3-45c3-8033-61475bc382f9', 881, 'http://JNTsliBrJM.com/B5raPil1CZ.ogg', 2, 2, 'I7WeCN4ArV', '2015-08-18 23:42:28.014717');
INSERT INTO server_mounts VALUES ('9c4a3229-de18-41dc-8473-35a88930f36a', 1011, 'http://icuMUe06W3.com/R29VWvh6tz.ogg', 7, 7, 'oZyjaW9HVu', '2015-08-18 23:42:38.226198');
INSERT INTO server_mounts VALUES ('e84b5fd1-c4e2-4ed3-825e-d32150927009', 899, 'http://qhgy6uCcIr.com/EQGosFdkSQ.ogg', 6, 24, '9a8A2O5AMX', '2015-08-18 23:42:38.602249');
INSERT INTO server_mounts VALUES ('f556408b-f21c-471b-b7ab-6ebf61977c78', 946, 'http://M2sAfKFx41.com/7KIdkLOsqL.ogg', 1, 3, '0brynf3fw5', '2015-08-18 23:42:38.76549');
INSERT INTO server_mounts VALUES ('84deefd1-0fba-47ec-ba6d-706c8799f2b2', 974, 'http://MXUJsj0Gx5.com/qq7fB1e1V0.ogg', 7, 7, '9Kw9ks3U0V', '2015-08-18 23:42:39.084008');
INSERT INTO server_mounts VALUES ('c6e34396-435d-41e4-a845-bcecc688dc4f', 910, 'http://s4xBfIQ3kC.com/FUgiQ0ARbu.ogg', 2, 10, 'PJ3370pD0m', '2015-08-18 23:42:28.047484');
INSERT INTO server_mounts VALUES ('5e04bb5a-2582-4c50-a3ed-cb57c3d7c352', 852, 'http://V1VCmqzHGe.com/dIdHNpqmZZ.ogg', 6, 30, 'DRsIu54iN8', '2015-08-18 23:42:39.641791');
INSERT INTO server_mounts VALUES ('cdf3f374-970d-441f-8cfc-f6d2ddb1ea6c', 818, 'http://ueGX67uUnF.com/60mvNDDmnL.ogg', 7, 7, '6I0C2wLHp7', '2015-08-18 23:42:39.822991');
INSERT INTO server_mounts VALUES ('853c28da-aa33-463e-a018-da77db1d31ac', 993, 'http://nxqItMlePs.com/lo4flOCSSU.ogg', 8, 40, '2034BKIYvr', '2015-08-18 23:42:39.849453');
INSERT INTO server_mounts VALUES ('dcc59259-f1a2-443e-8414-c448509fa0a7', 906, 'http://VDuEnVqmHW.com/s5G3Jw1kYy.ogg', 1, 5, 'cetNxLXVQw', '2015-08-18 23:42:33.394141');
INSERT INTO server_mounts VALUES ('c5de5700-c450-4b75-af90-745107ef5dfd', 1022, 'http://N84u15VCiZ.com/AF2qITYhBa.ogg', 0, 0, 'SC0DBqpMYL', '2015-08-18 23:42:34.089653');
INSERT INTO server_mounts VALUES ('00a64726-132d-41a5-8a37-7830d8f356c7', 925, 'http://GkOyWRKn8t.com/WL5cwOmJv0.ogg', 3, 12, 'inr1XLJQcs', '2015-08-18 23:42:34.814675');
INSERT INTO server_mounts VALUES ('86122b91-b61d-4e48-9f21-5be248bc1dc9', 1029, 'http://wJsGr1TlUb.com/NiXzyzTOtc.ogg', 5, 5, 'NxrpwZCr4U', '2015-08-18 23:42:39.975229');
INSERT INTO server_mounts VALUES ('fc9ddf5d-283a-4153-9be0-1d050bc2b1d6', 900, 'http://oG8ueFU9nz.com/TyWibndhU3.ogg', 3, 12, '3LVn8Wjckm', '2015-08-18 23:42:36.016736');
INSERT INTO server_mounts VALUES ('c0312466-199f-4caa-829b-c69bc32f1080', 833, 'http://bj6PfY8aP2.com/nCpcRMAA44.ogg', 2, 2, 'geBhxDoVYp', '2015-08-18 23:42:36.455862');
INSERT INTO server_mounts VALUES ('72c9b582-7445-4d5c-80e6-5cab0088ced1', 810, 'http://3I6HsLu2AV.com/0GyqvlwXYX.ogg', 7, 28, 'wGAPK7ZEfx', '2015-08-18 23:42:27.475275');
INSERT INTO server_mounts VALUES ('3925286c-4590-4b89-9a1b-2c0f0c97e548', 955, 'http://BWAdVmUMEr.com/4vU1rCrAQb.ogg', 9, 27, 'rt4MAuUMUw', '2015-08-18 23:42:36.495453');
INSERT INTO server_mounts VALUES ('c03f2bf2-2a73-42b9-9a78-c397aafbbbad', 1014, 'http://wiBpGkz6bi.com/BN9FpugfLm.ogg', 9, 27, 'NLmjRZO1Hs', '2015-08-18 23:42:28.126729');
INSERT INTO server_mounts VALUES ('461c15b9-499e-49ef-b60e-48729abc6d27', 964, 'http://obRZeDPIKs.com/vBkoJabRy9.ogg', 4, 16, 'JAPglt5rxQ', '2015-08-18 23:42:36.906273');
INSERT INTO server_mounts VALUES ('aa297414-3876-4f85-840c-959261941662', 1023, 'http://Ia9leInxnL.com/fBeCpEZOgm.ogg', 2, 6, 'MP20mOmE27', '2015-08-18 23:42:28.133878');
INSERT INTO server_mounts VALUES ('b3b4c733-183a-45ea-8353-bea2acf85a61', 846, 'http://1Nqr0MUykE.com/w1hw2qj8g1.ogg', 3, 12, 'Hjy4PbedvF', '2015-08-18 23:42:37.9993');
INSERT INTO server_mounts VALUES ('800ed99a-2367-49cc-b76f-c4de25d3582d', 872, 'http://i8s5jJhvw8.com/Xz4XVEmqE6.ogg', 4, 4, 'cNCDYTf8JZ', '2015-08-18 23:42:38.354524');
INSERT INTO server_mounts VALUES ('f15dda63-4268-48fb-897a-8b41ebe033f3', 878, 'http://CiWUydj145.com/01HtzRUeSi.ogg', 3, 12, 'y6v1gcg8Dh', '2015-08-18 23:42:28.013765');
INSERT INTO server_mounts VALUES ('6215ef36-752c-40ec-977d-8752ddd46ed0', 826, 'http://faYqwiMMmF.com/N2PcPkCi0l.ogg', 8, 8, 'f6KLcUnuQl', '2015-08-18 23:42:33.744043');
INSERT INTO server_mounts VALUES ('eeb27655-2c59-45b1-8ec2-6885c1f9525a', 889, 'http://vruhHbwWzp.com/grC6N1uoIN.ogg', 8, 8, 'hfYLlUcEGO', '2015-08-18 23:42:28.019637');
INSERT INTO server_mounts VALUES ('f9db81e8-9a57-43b2-9781-f7372de011e2', 905, 'http://HCPnlFgPKg.com/ZyhSrvDKqA.ogg', 9, 36, '2MxnXHrXHM', '2015-08-18 23:42:33.945857');
INSERT INTO server_mounts VALUES ('64e7cade-9956-46d8-ac5b-956648b81f49', 919, 'http://laoFWhZFw5.com/W6SJFU99yj.ogg', 6, 6, 'zJRkQ7aTl1', '2015-08-18 23:42:39.21143');
INSERT INTO server_mounts VALUES ('115a74d3-e302-4fb9-8cbf-f24997a2bf96', 976, 'http://yLcSX1D7rM.com/o8hedIeHut.ogg', 4, 8, 'hah7C4iQXU', '2015-08-18 23:42:34.709589');
INSERT INTO server_mounts VALUES ('b2b01b02-18f1-4458-a121-e9bc605d9828', 856, 'http://RhjHYNGMqD.com/wj5IdqogwK.ogg', 9, 36, 'IFjZsOuK9Z', '2015-08-18 23:42:34.950276');
INSERT INTO server_mounts VALUES ('a7f1b15f-de9c-44df-be36-ed9c141189f1', 1039, 'http://4gCMV1x8LZ.com/wsA39wIvGv.ogg', 2, 2, 'NewtPxLX0H', '2015-08-18 23:42:39.275354');
INSERT INTO server_mounts VALUES ('e05b7c83-669c-40c3-a950-1ea084892292', 928, 'http://HRHD2areyE.com/DqydhEfOvC.ogg', 8, 8, '7T0XTiuUiZ', '2015-08-18 23:42:28.064554');
INSERT INTO server_mounts VALUES ('571e2752-0bc8-485e-af0b-4218008a4741', 839, 'http://kC3EJO6ROj.com/kU5hxllQbB.ogg', 0, 0, 'dYyy8arAyG', '2015-08-18 23:42:39.767324');
INSERT INTO server_mounts VALUES ('6df6af35-601f-4ff8-ba04-c358fbad109b', 945, 'http://uxi5ZjjpLU.com/WyhmkiquDI.ogg', 6, 6, 'WPt3xwuOBj', '2015-08-18 23:42:39.899366');
INSERT INTO server_mounts VALUES ('0a98096e-899b-41d8-9568-4e2871b7b415', 911, 'http://GaTEynGfQr.com/6bX3NyKfLb.ogg', 9, 36, 'BkIXlhauO7', '2015-08-18 23:42:39.921876');
INSERT INTO server_mounts VALUES ('5033d7e7-c57d-427d-8726-1c0a11bf6747', 1004, 'http://GP9ejlb76O.com/6uIEvVSN3c.ogg', 4, 4, 'NHeKujYCWJ', '2015-08-18 23:42:40.126797');
INSERT INTO server_mounts VALUES ('c648da38-69d2-48b3-b3be-90b08096645e', 973, 'http://qa6Usvan8p.com/V4jXRJVsqF.ogg', 8, 32, 'Y35lofSHmS', '2015-08-18 23:42:28.093816');
INSERT INTO server_mounts VALUES ('d596c4ae-4ec4-41e6-ae63-ca7ccc52c67f', 994, 'http://9rseIpfwn8.com/zxxtmjdsPN.ogg', 7, 28, 'zWJCQ13GZp', '2015-08-18 23:42:28.109168');
INSERT INTO server_mounts VALUES ('98e66924-7653-4fd1-a7fd-4fae9e287f46', 966, 'http://LIQKOmTbTb.com/hJdnmeD7j1.ogg', 3, 15, 'BgXxrAfOC8', '2015-08-18 23:42:35.384714');
INSERT INTO server_mounts VALUES ('40897198-985e-4471-9c5b-19ad3d3821e2', 1017, 'http://oe4Y92Hds3.com/xHaDInpd1Q.ogg', 2, 8, 'zUsf4bdKMf', '2015-08-18 23:42:33.617589');
INSERT INTO server_mounts VALUES ('76846228-446c-4927-abed-129c38ac7d2b', 813, 'http://WH4hdP8l0a.com/E11KYtDzvn.ogg', 8, 16, 'OrTfPfkEBv', '2015-08-18 23:42:27.491173');
INSERT INTO server_mounts VALUES ('eea11bbc-253b-4566-b54f-3b173e2489d5', 823, 'http://vUyNQFTya7.com/R87G3jZ3Vb.ogg', 2, 10, 'v6DABoFrGj', '2015-08-18 23:42:27.845137');
INSERT INTO server_mounts VALUES ('40297d9c-dbe7-4786-b652-31355af19d34', 847, 'http://dfvfQ62RFP.com/96jsHiBoln.ogg', 8, 32, 'Ysi65dh1G8', '2015-08-18 23:42:35.869871');
INSERT INTO server_mounts VALUES ('628ab175-23d4-43e1-a5e0-14d8184426b7', 874, 'http://zj5ytPy4yc.com/pLxorBSSmL.ogg', 6, 24, 'zAH4nFF2nc', '2015-08-18 23:42:36.042942');
INSERT INTO server_mounts VALUES ('d95ddfc8-e253-4324-8f83-107fb977a4f4', 1009, 'http://OXNuiP1Z3h.com/8EkxLmYGfL.ogg', 9, 45, '2xpECv7nE5', '2015-08-18 23:42:36.592639');
INSERT INTO server_mounts VALUES ('6c3d4793-74cd-4fad-9142-df4ea4a87fc1', 864, 'http://NJ5OwvK5YZ.com/u2QIImVNjm.ogg', 0, 0, 'LQq5T5A4Fz', '2015-08-18 23:42:28.003608');
INSERT INTO server_mounts VALUES ('705bd22a-6859-4d50-b3f9-d7d7d7522aca', 908, 'http://1uvlBUlCOF.com/dGtGxA57sU.ogg', 0, 0, 'RLtuJkxhzw', '2015-08-18 23:42:37.438024');
INSERT INTO server_mounts VALUES ('c8dc61ed-0a62-44fb-b08a-f435571142bf', 968, 'http://ux2JwhQpCg.com/6psrtkZ8XR.ogg', 7, 28, 'PepwNrqJrJ', '2015-08-18 23:42:37.487587');
INSERT INTO server_mounts VALUES ('326f12e6-a481-4fc7-bd82-896a766745e0', 1043, 'http://zMgJkFOkrQ.com/VT3qrvqYMc.ogg', 6, 30, 'sVYFRevhkP', '2015-08-18 23:42:37.836103');
INSERT INTO server_mounts VALUES ('08b7bbcd-5b4a-4adc-bc00-a9a993ae8b77', 920, 'http://g3IXGTd6YB.com/dMolepSds5.ogg', 6, 6, 'mYuv625Id8', '2015-08-18 23:42:38.540483');
INSERT INTO server_mounts VALUES ('94a7c92d-2de1-4033-b848-7673a3c91742', 986, 'http://U6ZXWqAyZN.com/W0APghF6hb.ogg', 2, 8, 'qx1KOSmw8M', '2015-08-18 23:42:38.94006');
INSERT INTO server_mounts VALUES ('e334e702-3575-4f92-900a-dbc0da46078d', 957, 'http://2vu42ANBwB.com/Ygaqf05oeg.ogg', 4, 12, 'mDph0xLj3V', '2015-08-18 23:42:28.078191');
INSERT INTO server_mounts VALUES ('33671933-8e18-475d-8654-6858b13bc9a3', 1034, 'http://niT3njXAYa.com/zyKuUzRLsA.ogg', 6, 6, 'cweIN5syUG', '2015-08-18 23:42:39.264977');
INSERT INTO server_mounts VALUES ('9d4c2fc2-fd63-4711-ad35-6fe2ba73833a', 893, 'http://oX4AAwF9Bv.com/FBnwsbgyY8.ogg', 2, 6, '1DRnOuAvWZ', '2015-08-18 23:42:39.287755');
INSERT INTO server_mounts VALUES ('4c81ca10-40c3-4603-b173-a3c172743585', 940, 'http://jgk8FNEpqY.com/HroeT6bn1l.ogg', 7, 28, 'PSevD3IcST', '2015-08-18 23:42:39.433178');
INSERT INTO server_mounts VALUES ('770520ec-374b-4cec-b883-28f5a99b7914', 853, 'http://6r2YpDcVAM.com/FwHRlQB7jJ.ogg', 5, 20, 'bs0il01qvF', '2015-08-18 23:42:39.552658');
INSERT INTO server_mounts VALUES ('2e24b447-abae-428a-8026-223edd7d9e2b', 996, 'http://aKFqtSVE9f.com/5TfM3U3uOg.ogg', 8, 24, 'n3ZNsOxokC', '2015-08-18 23:42:28.109794');
INSERT INTO server_mounts VALUES ('534327ad-77a1-4059-b49d-c8f742efd9de', 931, 'http://p5VaUiQJ3N.com/kHG6nIznne.ogg', 0, 0, 'rcBftQeKV3', '2015-08-18 23:42:39.931517');
INSERT INTO server_mounts VALUES ('bc25837b-97d2-41a4-b8b5-890fef3e0a8f', 1006, 'http://pjdcBWRWv1.com/v9km9SietH.ogg', 2, 4, '9nCZmIRMOk', '2015-08-18 23:42:28.116287');
INSERT INTO server_mounts VALUES ('96db97cd-53dd-421b-bf59-8dcf529230b3', 921, 'http://rv57i1dXHV.com/8IzcXUSr5l.ogg', 6, 24, '9odlt556UN', '2015-08-18 23:42:34.979993');
INSERT INTO server_mounts VALUES ('9349cf50-5df0-4965-9858-2ebeaa3d8f0e', 915, 'http://UboMebe78P.com/iFplTMB0XZ.ogg', 8, 8, 'h9lxCfCKwn', '2015-08-18 23:42:36.277991');
INSERT INTO server_mounts VALUES ('b68802a1-433c-42e2-b64b-4e8c1450eda6', 888, 'http://i1Aq9RnBxc.com/LghZzlBPDq.ogg', 1, 4, 'k721O2HZ8k', '2015-08-18 23:42:37.089892');
INSERT INTO server_mounts VALUES ('9b60a101-488e-490b-af74-04454935d5fe', 819, 'http://gZrLWfHnRy.com/dgowjdyqJ6.ogg', 7, 28, 'XKSNvCXzP9', '2015-08-18 23:42:27.656456');
INSERT INTO server_mounts VALUES ('df5c7c0a-b66b-4f7e-89d7-96ebf0df6a33', 903, 'http://k75PBWnJMF.com/A60ZzFHdDs.ogg', 3, 3, 'mASnOVSvVT', '2015-08-18 23:42:37.164705');
INSERT INTO server_mounts VALUES ('cee94425-197c-46eb-a816-15285291b194', 936, 'http://ulokqKYNUz.com/j7Hwbc7sHE.ogg', 6, 12, 'n6krC6SgXC', '2015-08-18 23:42:37.6558');
INSERT INTO server_mounts VALUES ('bd506142-bcb1-465e-9af0-676f0d120a99', 851, 'http://MkOK0drLWz.com/RKLVGgT889.ogg', 8, 24, 'MEiAM1FG9a', '2015-08-18 23:42:27.987695');
INSERT INTO server_mounts VALUES ('d9a7a308-3f0b-4a9f-83ea-e73f0f8f8402', 875, 'http://0GicWrVRVj.com/alfAQIQTq0.ogg', 5, 25, 'c1VQYSOvJB', '2015-08-18 23:42:37.78352');
INSERT INTO server_mounts VALUES ('135ccc37-3677-44d2-b803-767cac6044e5', 1003, 'http://1NDZ9CpLlh.com/O239zc4jDG.ogg', 3, 3, 'RkYj3BfiLC', '2015-08-18 23:42:37.830986');
INSERT INTO server_mounts VALUES ('f47489d5-24e9-4fa7-a940-c1d8b41b3a2a', 868, 'http://cPHlhyNb4O.com/DXzPTb6hUR.ogg', 4, 8, 'iJDjunIDuQ', '2015-08-18 23:42:28.005538');
INSERT INTO server_mounts VALUES ('82c2ca24-4f39-406d-89ea-67e28b3df9da', 827, 'http://0NXW1gu7cd.com/gYmHETUj4s.ogg', 3, 9, 'FEdxVswEB8', '2015-08-18 23:42:38.020346');
INSERT INTO server_mounts VALUES ('50b02257-63af-4112-8350-9362420c4562', 1016, 'http://Fxhkrz1fdu.com/XjE5ZTyLA1.ogg', 0, 0, 'PxeqIaj0Fl', '2015-08-18 23:42:38.128828');
INSERT INTO server_mounts VALUES ('d2cfbc84-9819-46ba-b791-631031fe2881', 1041, 'http://goDsuGKwtZ.com/jEe8nvHmOZ.ogg', 9, 27, '5AghEBu7GI', '2015-08-18 23:42:28.140595');
INSERT INTO server_mounts VALUES ('46d8e9c9-a79c-4a9a-8c2e-a399667c6e2b', 982, 'http://OHnBFSV86i.com/jZmpZZYKHF.ogg', 7, 14, 'GbnJ2sJShm', '2015-08-18 23:42:38.183842');
INSERT INTO server_mounts VALUES ('3ae0591e-67bd-40a1-b40f-ace1fbb32d33', 886, 'http://vsLjqz5SI1.com/z1frBqOC6u.ogg', 5, 20, 'PcFiX8luDt', '2015-08-18 23:42:38.277018');
INSERT INTO server_mounts VALUES ('9c315d34-759c-4328-8042-e0c70c1ec056', 932, 'http://Hz8QsE5B7I.com/FPgZ04lEBU.ogg', 3, 3, 'hNGKqeLdlt', '2015-08-18 23:42:28.059821');
INSERT INTO server_mounts VALUES ('bc1f33e2-9bab-4938-b759-9711d7b6b766', 858, 'http://16olVwfsQh.com/PMEM8ka9bA.ogg', 7, 21, 'EI6V6ZWzeq', '2015-08-18 23:42:34.773418');
INSERT INTO server_mounts VALUES ('6d70cd24-2566-4822-b597-1ae5f999b112', 815, 'http://nYoDdHtk89.com/wdOkLyap9L.ogg', 0, 0, 'RUyqesPaRU', '2015-08-18 23:42:38.789377');
INSERT INTO server_mounts VALUES ('436c329d-7737-48fb-96ed-76e6f3978748', 984, 'http://eI3B9RG970.com/YDLoswAxph.ogg', 1, 5, 'N1TbRcQh6B', '2015-08-18 23:42:38.858931');
INSERT INTO server_mounts VALUES ('cfc4f129-5aae-42e1-b751-882440c9761a', 969, 'http://VwXBSs7aG6.com/rLJphsjEvc.ogg', 3, 12, 'iZhBFEoPjA', '2015-08-18 23:42:28.091438');
INSERT INTO server_mounts VALUES ('7facb515-466e-42d2-94e5-de1414bb59c4', 953, 'http://HvVj6rWwNk.com/LsBtZVVEPl.ogg', 0, 0, 'DkuJrlYqbz', '2015-08-18 23:42:38.883579');
INSERT INTO server_mounts VALUES ('2e5ed3eb-2d3d-47d4-966a-dd7e1fc95666', 1013, 'http://grcxuyNDpa.com/Vvq6fv3117.ogg', 2, 4, 'voN3m4zrBp', '2015-08-18 23:42:39.128632');
INSERT INTO server_mounts VALUES ('b89e84da-131c-4f0b-9c9a-1971ba886550', 841, 'http://uMs096pLrC.com/Ij7DVN72f2.ogg', 2, 10, 'L4mwiY5u6q', '2015-08-18 23:42:39.338693');
INSERT INTO server_mounts VALUES ('65876b03-5dd5-404a-92d6-05f3e23f3580', 1024, 'http://XOfrGjW9zA.com/RaZeXLHz7a.ogg', 6, 24, '8fOQraxMuv', '2015-08-18 23:42:39.726954');
INSERT INTO server_mounts VALUES ('8c599be5-b158-476d-b0e3-67de8cbb6297', 949, 'http://jEgjcJ8GEc.com/nwTuQzcmtt.ogg', 0, 0, '03ZbrCGJII', '2015-08-18 23:42:40.089116');
INSERT INTO server_mounts VALUES ('f2c0a59e-93c2-449e-b71a-f363817c87b8', 845, 'http://EU2grbIstl.com/M5jZzOTbFG.ogg', 5, 10, '0mh54Fgd5v', '2015-08-18 23:42:35.137057');
INSERT INTO server_mounts VALUES ('376422dc-ee19-40fb-b462-ef8b6e9ec3ba', 950, 'http://cQi6bAJ0J5.com/W3iSl3e2hp.ogg', 8, 24, 'eDFG139TbL', '2015-08-18 23:42:35.782143');
INSERT INTO server_mounts VALUES ('e96f8ca1-196a-495e-bd01-4c3a0bf88c11', 821, 'http://jSFbaF2Zag.com/Nj9uQfaJbB.ogg', 9, 36, 'tiYYLoxwdL', '2015-08-18 23:42:27.658023');
INSERT INTO server_mounts VALUES ('bc5fea2e-7103-4600-9b08-0a1beef0f809', 1027, 'http://4IFuytQmHJ.com/9mmeepW8dg.ogg', 0, 0, 'DBtcRNfy50', '2015-08-18 23:42:35.821083');
INSERT INTO server_mounts VALUES ('24e0ff63-c6ed-43ce-b035-68b2fd392708', 825, 'http://7Uqf1yJm3x.com/FuHC2652oV.ogg', 1, 2, 'xhC7V6n7m9', '2015-08-18 23:42:27.691958');
INSERT INTO server_mounts VALUES ('c9e25b38-1ab3-4b25-8c25-d6edfbf34e2c', 978, 'http://AtFZtyjW7T.com/z518fRdZIT.ogg', 2, 6, 'rQVGjFJFWS', '2015-08-18 23:42:36.054457');
INSERT INTO server_mounts VALUES ('091416a4-a8f1-4290-b864-49a90c59bf7f', 933, 'http://N0DREJrwsI.com/VSPMoOjKxX.ogg', 4, 4, 'Sh3ajHFPgE', '2015-08-18 23:42:36.666351');
INSERT INTO server_mounts VALUES ('5824aa57-a44d-450a-b2db-7207179ef99e', 876, 'http://YwbvGOszt9.com/VsJAI5w0F8.ogg', 4, 16, 'mboPw8MzrD', '2015-08-18 23:42:28.012238');
INSERT INTO server_mounts VALUES ('41bf9de0-39c8-49cb-9339-e23758362f4e', 861, 'http://drOJnxdHIN.com/wxHjjPBxua.ogg', 7, 7, '2OVgCQVWDq', '2015-08-18 23:42:37.785432');
INSERT INTO server_mounts VALUES ('376b7c39-f5b0-4dcd-8b6c-3f108bea1407', 887, 'http://OS2yh20duj.com/goZbWzIGQ3.ogg', 1, 3, 'Kk4WLFFjRx', '2015-08-18 23:42:28.023842');
INSERT INTO server_mounts VALUES ('d83556be-6e15-414e-9b29-7f17181f54b6', 817, 'http://geDYa8nJTt.com/UfF5U5d7f6.ogg', 6, 12, '1gInlXxLr5', '2015-08-18 23:42:37.909008');
INSERT INTO server_mounts VALUES ('bca3221e-8ed0-40c7-91a3-017061fbcb0f', 999, 'http://8juUI5BIg3.com/nnFhsC6toj.ogg', 6, 30, '2hhLXhPBj3', '2015-08-18 23:42:38.085525');
INSERT INTO server_mounts VALUES ('d6248f40-6a21-4595-a9b0-3dddd864644c', 916, 'http://3WE5W4TgGX.com/zLgUGetv2l.ogg', 0, 0, 'pEFqlZ48AQ', '2015-08-18 23:42:28.044325');
INSERT INTO server_mounts VALUES ('dca6167a-57cf-4c62-a136-70742dc70be7', 922, 'http://5vjo0i5x0H.com/87ZuE4xNqY.ogg', 7, 35, 'IQf4lxWXfl', '2015-08-18 23:42:28.051828');
INSERT INTO server_mounts VALUES ('8f506a88-0a7c-4fe3-86fd-89cccf1d9c1b', 1040, 'http://y55KlAfdTZ.com/ug90xRKval.ogg', 5, 10, 'jNU7mizpEu', '2015-08-18 23:42:28.145969');
INSERT INTO server_mounts VALUES ('8258a8a0-857d-4dc9-a51a-367a5552e620', 970, 'http://bcrtkZ7hKQ.com/tjTcVfuerg.ogg', 1, 5, 'G0XGnG4qKd', '2015-08-18 23:42:33.807255');
INSERT INTO server_mounts VALUES ('ed85481e-0c8d-409e-8251-0ac39a3f11fd', 1020, 'http://FUZqWWUaum.com/jfLl4AAmcd.ogg', 2, 10, 'yuvefBr0bP', '2015-08-18 23:42:38.521887');
INSERT INTO server_mounts VALUES ('b7467032-58b8-4014-890b-cb802b8798c8', 989, 'http://o33lWFjuUx.com/YkpECZM55v.ogg', 2, 6, 'IDS9cVIIdC', '2015-08-18 23:42:33.93973');
INSERT INTO server_mounts VALUES ('6924e515-9043-4842-95c8-f8b528b918d0', 842, 'http://R0xlgXzBT6.com/bsE43f8qDV.ogg', 9, 9, 'YAm0PIOSEI', '2015-08-18 23:42:39.069059');
INSERT INTO server_mounts VALUES ('59a35b5a-84eb-4521-a048-90dcbb590345', 895, 'http://Vb0dshIVNP.com/zvreQ8yJlz.ogg', 8, 8, 'Qa5er9WV6F', '2015-08-18 23:42:34.759391');
INSERT INTO server_mounts VALUES ('14a7760f-d277-4cda-b30d-2ebfbe9c3357', 1037, 'http://Fih2lmSv6A.com/ysHzkzUT8b.ogg', 0, 0, 'ZUwzuZjIYf', '2015-08-18 23:42:39.154061');
INSERT INTO server_mounts VALUES ('1b715e20-c2e8-478c-a344-7134fb06f5c1', 885, 'http://6DRMVIksvT.com/e0iqz1ltO8.ogg', 4, 4, 'iexJyPrBPm', '2015-08-18 23:42:39.310002');
INSERT INTO server_mounts VALUES ('42926ab4-0212-4950-92d9-71a40bfcb4d6', 869, 'http://RViUzH52dB.com/f0NGRiWSb4.ogg', 0, 0, 'vci4ns4aEX', '2015-08-18 23:42:39.31928');
INSERT INTO server_mounts VALUES ('5c33342f-9aff-4491-a593-c135d57a4950', 1007, 'http://hL2GDbqWPK.com/oL3KftPMaJ.ogg', 5, 10, 'o7miJfA1sb', '2015-08-18 23:42:39.850734');
INSERT INTO server_mounts VALUES ('d51da8dc-5add-418b-a47f-2f95d493613e', 961, 'http://MLCNfG1ELa.com/g32aLnmReE.ogg', 4, 12, 'mWbOB4WTrD', '2015-08-18 23:42:39.897884');
INSERT INTO server_mounts VALUES ('f970c01b-e54b-492d-b161-4fd033fc2752', 934, 'http://l0UEGhJuwU.com/C1Q91wYq9H.ogg', 1, 3, 'bFBdNptdgB', '2015-08-18 23:42:40.14781');
INSERT INTO server_mounts VALUES ('0cb65598-2753-4a38-ab21-c00d5300304a', 935, 'http://xZEuKNmvYA.com/lOB8qywoXw.ogg', 4, 20, '5DqNpTU4Lx', '2015-08-18 23:42:35.328247');
INSERT INTO server_mounts VALUES ('49791c8f-82e8-4604-acad-283dd44a117e', 830, 'http://BUHGdc6kiT.com/YSsV02PJZA.ogg', 2, 8, 'tgty8kAOwx', '2015-08-18 23:42:35.754081');
INSERT INTO server_mounts VALUES ('e2957609-f6e7-4a67-a214-f591bb09db77', 944, 'http://NpGhRc4oT7.com/Jua95aqwkK.ogg', 2, 10, 'MArC8ipTof', '2015-08-18 23:42:36.393172');
INSERT INTO server_mounts VALUES ('7d9d83d4-6a7b-45af-b3d7-26bc8251df8d', 831, 'http://ADSpeH9GTo.com/ncebPxzCon.ogg', 9, 36, 'IBgJ2JKofL', '2015-08-18 23:42:27.906908');
INSERT INTO server_mounts VALUES ('43127ba8-4a80-420e-a6a1-cec30482ca1c', 971, 'http://RLk2zj2GIF.com/6aGY3e875D.ogg', 4, 8, '7FMwg7qRQg', '2015-08-18 23:42:36.399178');
INSERT INTO server_mounts VALUES ('a79e2879-84f4-4a2a-8dbd-62148964d19b', 870, 'http://IJfMwlM6T9.com/gkyt4i7pgC.ogg', 1, 3, 'F4c1OqFk0e', '2015-08-18 23:42:28.006691');
INSERT INTO server_mounts VALUES ('5abdeac3-5ba2-4428-8748-3d0c768d2df9', 820, 'http://9RZmPPZsMR.com/9JDbqkakYA.ogg', 5, 5, 'zl5753rneU', '2015-08-18 23:42:36.448711');
INSERT INTO server_mounts VALUES ('b3d7702a-79d4-4912-a997-0d3f645717d1', 843, 'http://T80nyCDQEr.com/WdCvtL6N4d.ogg', 6, 24, 'z8g6dEe0DR', '2015-08-18 23:42:36.64678');
INSERT INTO server_mounts VALUES ('5f6fce78-3718-422c-9413-42425a025cfb', 1010, 'http://yI7wEZfpWD.com/5jCGbo3wE3.ogg', 3, 9, 'bkJqAwDrh1', '2015-08-18 23:42:36.726784');
INSERT INTO server_mounts VALUES ('018269a3-a26c-43ab-89b7-088689dc95e8', 1032, 'http://VM6bzoQCpx.com/yApEdApgOg.ogg', 3, 3, 'LraVSio7sj', '2015-08-18 23:42:28.13827');
INSERT INTO server_mounts VALUES ('57665d1a-8df0-4a6b-9d72-a948e60080dc', 877, 'http://IJuvLqC7dT.com/FzsjrhnMjX.ogg', 1, 1, 'kCZvkfZYzc', '2015-08-18 23:42:33.480429');
INSERT INTO server_mounts VALUES ('7a754a0d-f96e-4caf-948e-ca434513195f', 1021, 'http://VPv1NR0JQ6.com/cHn3ihWQSo.ogg', 6, 6, 'PYIgEse5eo', '2015-08-18 23:42:37.028418');
INSERT INTO server_mounts VALUES ('6a705a75-b918-43f2-9d0b-52b409b48759', 942, 'http://QM5hmZkGs3.com/HY7G4DdkG6.ogg', 2, 8, 'HozB0HrPfu', '2015-08-18 23:42:28.069084');
INSERT INTO server_mounts VALUES ('173b937f-875d-4616-96c7-c28b08335961', 992, 'http://qS7yu3IWpT.com/VMs6dULxUD.ogg', 9, 45, 'oJPp70Wb9A', '2015-08-18 23:42:37.979343');
INSERT INTO server_mounts VALUES ('4d304a7d-f24b-4028-bcd1-d72d7b4e6620', 962, 'http://CNvN1qHI74.com/mN7OOkKzdT.ogg', 8, 24, 'OdBO6YljFA', '2015-08-18 23:42:28.081156');
INSERT INTO server_mounts VALUES ('13dfcc67-a406-42d0-b557-e6b221417a23', 1028, 'http://5pjsDQkW0k.com/QAIyjregHj.ogg', 4, 16, 'x1aH2gGHh7', '2015-08-18 23:42:38.101064');
INSERT INTO server_mounts VALUES ('e42bb07f-1728-4c72-baed-b01517f226dd', 811, 'http://3RLiJtZGCo.com/x2uacumN4e.ogg', 3, 9, 'c2abqRyrxt', '2015-08-18 23:42:38.402931');
INSERT INTO server_mounts VALUES ('c5bdba43-c05b-48b0-b711-bda3160bbf63', 897, 'http://M5lwY0lU3F.com/6zGhUVBTjq.ogg', 8, 40, 'jh0uBz4tlw', '2015-08-18 23:42:38.730031');
INSERT INTO server_mounts VALUES ('3c627966-0be1-4f48-9426-8efb2a539551', 923, 'http://08IJloUPlr.com/wd5HCVNBa9.ogg', 9, 18, 'ZhUbGSZSRg', '2015-08-18 23:42:38.953258');
INSERT INTO server_mounts VALUES ('08a6f268-1a53-465f-a466-527416654fb1', 896, 'http://cah5PRTTSQ.com/Lf7DoXF8rb.ogg', 5, 10, 'Y8iWsteBLO', '2015-08-18 23:42:39.085268');
INSERT INTO server_mounts VALUES ('16653670-59ba-4425-bd31-f4d029ca779a', 979, 'http://uGwyqiU5i4.com/rIEmHM1lyF.ogg', 4, 8, 'f772NSVyuF', '2015-08-18 23:42:39.092859');
INSERT INTO server_mounts VALUES ('59b95d76-50db-4796-8d38-d7f408be1c13', 917, 'http://cpdWnopLH8.com/hjYZZ5uj2A.ogg', 7, 28, 'WFyS9crIMY', '2015-08-18 23:42:39.152756');
INSERT INTO server_mounts VALUES ('f6326926-02dc-47a7-82bd-c318f30e8f12', 879, 'http://46XXmlExzG.com/4YBYQEG8k0.ogg', 8, 8, 'A3u6ITJbpD', '2015-08-18 23:42:39.222204');
INSERT INTO server_mounts VALUES ('76d1c29e-4407-483a-86a6-30588c928ae8', 860, 'http://1yglpcx843.com/rHaFUsg6mD.ogg', 7, 35, 't78WWoVons', '2015-08-18 23:42:39.320675');
INSERT INTO server_mounts VALUES ('f05ddd5c-8c34-4135-98b9-79a8456417b6', 990, 'http://L33lHkHJzz.com/SA1x7BpopF.ogg', 1, 5, 'yEMfw31jV8', '2015-08-18 23:42:39.824231');
INSERT INTO server_mounts VALUES ('05b4149f-196a-427e-a910-1b4b9c67f325', 998, 'http://GsQ56rJAL9.com/twhJhqdoZK.ogg', 8, 40, 'fTy28y60kL', '2015-08-18 23:42:35.107319');
INSERT INTO server_mounts VALUES ('9d65cbc6-cc8d-4528-8b44-fb0c0f4de19d', 892, 'http://m7gmVro4sj.com/PyxqtFX4CR.ogg', 5, 10, 'OoT9d4dR6W', '2015-08-18 23:42:35.258683');
INSERT INTO server_mounts VALUES ('c6b4b1fe-26eb-4920-a674-b4412218faa1', 812, 'http://pTSs6LwFHA.com/4BWl4S1WOF.ogg', 1, 4, '0hvX6y1NI2', '2015-08-18 23:42:27.485762');
INSERT INTO server_mounts VALUES ('8ec416f5-f67d-4a54-a80a-ff53619afd72', 1019, 'http://PlAYAw0dsC.com/WU5R5xRLbG.ogg', 0, 0, 'NjTDItlC1k', '2015-08-18 23:42:28.123307');
INSERT INTO server_mounts VALUES ('34084449-67b1-480b-a298-d87cf577392b', 824, 'http://Q87XWdpvQ4.com/58plAzN8zE.ogg', 9, 9, 'TrztpQtL4R', '2015-08-18 23:42:27.687004');
INSERT INTO server_mounts VALUES ('3d6597e5-387b-4e6b-957c-e865bcbbe309', 848, 'http://4KudOzkZwH.com/itnEZyn2yq.ogg', 9, 45, 'ED857HCVUe', '2015-08-18 23:42:35.682994');
INSERT INTO server_mounts VALUES ('8a86bbd0-ba5f-45c4-851b-cd67aec04ae3', 837, 'http://Gna5bxtCRE.com/nzJR85vusA.ogg', 6, 24, 'dUQKv1cAvk', '2015-08-18 23:42:27.846066');
INSERT INTO server_mounts VALUES ('2428dd4c-4804-4910-83d4-f44e4f7bf489', 865, 'http://kImi3shWUj.com/TtsuQ0hwpT.ogg', 0, 0, 'UxNVsTGHL8', '2015-08-18 23:42:28.010595');
INSERT INTO server_mounts VALUES ('1a913174-96c3-458d-8889-34c857077e38', 854, 'http://SqhZeqbuhl.com/Y2trWW8XV1.ogg', 8, 32, 'Xjgkbjflv4', '2015-08-18 23:42:36.568382');
INSERT INTO server_mounts VALUES ('1401aaf3-2722-4bf4-b85d-1500a84ab48b', 883, 'http://RynhoJjyYF.com/NM1VV1THwv.ogg', 2, 2, 'w1RL1apqqD', '2015-08-18 23:42:28.015438');
INSERT INTO server_mounts VALUES ('55b44106-46fb-4971-903c-e2cc97ce2462', 1045, 'http://Zr5QBeLgiM.com/CLk8VvovDg.ogg', 9, 45, 'dvtEuvjVnf', '2015-08-18 23:42:28.144858');
INSERT INTO server_mounts VALUES ('b9a458c4-0553-4c6d-9837-8159b957751a', 930, 'http://CeAUlNMsPf.com/I0Q8CwUvta.ogg', 7, 7, 'dm7w47v48Z', '2015-08-18 23:42:34.165976');
INSERT INTO server_mounts VALUES ('d1d572db-0fa3-4955-8840-cc59ddb77ea3', 977, 'http://YW2zVSqcB6.com/5qQlzsiqev.ogg', 8, 24, '8NAHBDcoNw', '2015-08-18 23:42:34.446472');
INSERT INTO server_mounts VALUES ('db46358d-9ef5-46fc-a0f6-e00275f5c53e', 909, 'http://WOLwP138NJ.com/j52wO58EMg.ogg', 0, 0, 'xkSoxdBQpr', '2015-08-18 23:42:28.040452');
INSERT INTO server_mounts VALUES ('d9b68b1c-ad8f-445f-aec0-3ccd4324e59a', 988, 'http://wU2BQ1wNxe.com/kmc14K1P9U.ogg', 6, 24, 'mjvEjH96p0', '2015-08-18 23:42:34.565573');
INSERT INTO server_mounts VALUES ('8c5db92f-f0ab-461d-ad30-0b9743b3e59f', 952, 'http://Fxk1Lt0N9d.com/8WQNaNyfkk.ogg', 5, 10, 'WImlxhSDtt', '2015-08-18 23:42:37.237904');
INSERT INTO server_mounts VALUES ('0e3738ff-b555-4ca1-ac8f-624c0bc063bb', 913, 'http://MBMAvJx0Dm.com/xCvwpOF8xZ.ogg', 6, 6, 'WcOVYE3JZ9', '2015-08-18 23:42:37.609129');
INSERT INTO server_mounts VALUES ('53b047db-49a9-4fb1-ab95-46e21b1262d5', 902, 'http://06z5v9vTWV.com/KBuoaPVaRq.ogg', 3, 6, 'pmEauVfipu', '2015-08-18 23:42:38.036676');
INSERT INTO server_mounts VALUES ('1ae8ff6f-cf44-40d5-946f-d044fd96f86e', 939, 'http://YShOqTeVdj.com/I6rIvLW3Xi.ogg', 6, 18, 'M2dpKELO8b', '2015-08-18 23:42:28.067209');
INSERT INTO server_mounts VALUES ('1d82e08c-fd5a-4421-ad48-878142497fae', 948, 'http://QdCnX0RS6e.com/jKv7UQ5Iw5.ogg', 1, 5, 'rcln0Vc0xf', '2015-08-18 23:42:38.100124');
INSERT INTO server_mounts VALUES ('bb63bac2-ca55-46ff-a236-df6471f16f09', 1036, 'http://tOeSDYM8pO.com/Ew5Yuf9m8c.ogg', 8, 24, 'uALaDHPgWV', '2015-08-18 23:42:39.41461');
INSERT INTO server_mounts VALUES ('70cea59c-a98e-4fc0-91f7-8296999f61fc', 1001, 'http://a7lrPwqqmq.com/zO72iUFc23.ogg', 1, 1, '8iq72LKFFZ', '2015-08-18 23:42:39.472778');
INSERT INTO server_mounts VALUES ('30016615-7029-4fbd-8df3-d9cafe923ac0', 960, 'http://fsZFiM2cbd.com/XMgS5obKWK.ogg', 0, 0, 'Z5rjy2A1ij', '2015-08-18 23:42:28.08529');
INSERT INTO server_mounts VALUES ('ced30429-3915-4d3e-8773-7133da951c39', 1026, 'http://myxyWCdjUv.com/oPe3KGORzG.ogg', 7, 7, 'D6HdzSZZb2', '2015-08-18 23:42:39.725917');
INSERT INTO server_mounts VALUES ('df176e38-8e6e-4167-b60e-016007826acf', 926, 'http://g1yh1MyCbN.com/Jfo3t6aseJ.ogg', 1, 5, '8C0uKFaYKz', '2015-08-18 23:42:36.049778');
INSERT INTO server_mounts VALUES ('93f1db8a-cf8b-4613-88b8-f0a0d3014ed1', 828, 'http://mlcOp7SzGO.com/DLzFWEG2t0.ogg', 5, 20, 'CWMmfnNZ8r', '2015-08-18 23:42:36.13031');
INSERT INTO server_mounts VALUES ('485cc757-ba00-4c1a-b471-35777b84cc42', 884, 'http://fkoD8noCF7.com/KOZie73PvU.ogg', 3, 3, 'hohaFnOLmS', '2015-08-18 23:42:36.238747');
INSERT INTO server_mounts VALUES ('55068150-fcbf-4f36-99e4-ea350f1ac2af', 1015, 'http://33s7FYbTsi.com/dF1wGJKibT.ogg', 5, 15, 'VLm7FnuKal', '2015-08-18 23:42:36.625602');
INSERT INTO server_mounts VALUES ('be86e792-8809-4c80-8333-ffb609c8012a', 834, 'http://yrD6GOoVtK.com/UfCNH5Ifte.ogg', 2, 2, 's6TcbkJ6GQ', '2015-08-18 23:42:27.847467');
INSERT INTO server_mounts VALUES ('7717851f-5796-4019-a400-31763cd78db3', 867, 'http://HRn7ZStb1J.com/JrZAFF7X7i.ogg', 0, 0, 'ZpakmOj9vb', '2015-08-18 23:42:37.782135');
INSERT INTO server_mounts VALUES ('778b85cd-8044-4839-b4f1-1e91a1c130fc', 1030, 'http://JKRKy7Qjfx.com/mmL8m5vTto.ogg', 3, 6, 'ZMsfGWKyPv', '2015-08-18 23:42:37.826181');
INSERT INTO server_mounts VALUES ('8bd53129-2648-4524-9254-6fb383357d22', 857, 'http://5bNWCmIFPB.com/78WamOo6G2.ogg', 3, 12, 'Keaxb2w9QC', '2015-08-18 23:42:37.875897');
INSERT INTO server_mounts VALUES ('b34a52ae-af90-4e82-8cc2-78410f0d8450', 849, 'http://3UK8DzWmrK.com/sR2OaSv6pV.ogg', 3, 3, 'SNXOTEC1sT', '2015-08-18 23:42:38.371783');
INSERT INTO server_mounts VALUES ('62f33edf-b4bc-4125-9a23-6265967e2dd3', 1012, 'http://UpOsvb5ekl.com/X3dOHkKIyD.ogg', 5, 25, 'NTwpUFPGxL', '2015-08-18 23:42:38.534853');
INSERT INTO server_mounts VALUES ('01a427f5-34dd-42ab-8f92-563aa4738313', 951, 'http://DkZuHh2EHp.com/08co0cP9ZH.ogg', 0, 0, 'dCcUksqTix', '2015-08-18 23:42:38.810852');
INSERT INTO server_mounts VALUES ('f28a7446-8d59-45e6-85ac-6e61d96c3d40', 967, 'http://9SLN2bivjN.com/8bD9o86i56.ogg', 3, 3, '6hobp1Vpxu', '2015-08-18 23:42:39.056368');
INSERT INTO server_mounts VALUES ('2383ae0b-6152-4a18-8305-029fea9e2f83', 941, 'http://9FkvpXHq6y.com/5fWuHUXY73.ogg', 5, 20, 'HBVABKDh9g', '2015-08-18 23:42:28.073754');
INSERT INTO server_mounts VALUES ('34cfdc7d-c7d8-4682-b3ff-7c0158688b76', 914, 'http://rmEP5vlSsH.com/qSXgbYk0US.ogg', 3, 15, 'aMdBTP21LE', '2015-08-18 23:42:39.268041');
INSERT INTO server_mounts VALUES ('452f90f4-29f3-4d15-8407-3a1c1161fb0f', 894, 'http://gWzXElweUH.com/UJKFC56aMS.ogg', 2, 2, '4eZv0S4CTU', '2015-08-18 23:42:40.039201');
INSERT INTO server_mounts VALUES ('e9bffde3-b63d-4252-a43a-e15c7c120953', 981, 'http://szF67YViLJ.com/vs33iMtQpx.ogg', 2, 10, 'D8E5nKFcDH', '2015-08-18 23:42:28.099459');
INSERT INTO server_mounts VALUES ('8bf40586-c8ab-497a-a3e3-df7bcf6dcc0b', 983, 'http://y48a0ZuiVA.com/tiHqi2pXJc.ogg', 7, 21, 'zF7PzuyJfb', '2015-08-18 23:42:28.107234');
INSERT INTO server_mounts VALUES ('3d0bb8f7-74a4-47e6-a789-73ed4283e159', 1002, 'http://ygoHvOD5Rt.com/Yb7mQFr8L3.ogg', 1, 5, 'Ozf8gW4o3X', '2015-08-18 23:42:28.114077');
INSERT INTO server_mounts VALUES ('9bb73f6f-9d59-4ac2-9af4-721db32cc5e4', 1038, 'http://I854S299sP.com/hpsfyaXYd4.ogg', 1, 4, 'DOKIUv3tqL', '2015-08-18 23:42:28.139307');
INSERT INTO server_mounts VALUES ('0ae387a8-0fab-4d35-a1b5-8a2222802a94', 814, 'http://MMM6l36nzZ.com/7G8eRRb1ce.ogg', 9, 9, 'OaRULrZK1h', '2015-08-18 23:42:34.080642');


--
-- Data for Name: streams; Type: TABLE DATA; Schema: public; Owner: marcof
--

INSERT INTO streams VALUES (892, '2iXKixIYoJ', 'audio/aacp', NULL, NULL, 'OoT9d4dR6W', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Pop}');
INSERT INTO streams VALUES (932, '1wRMap9XhV', 'application/ogg+vorbis', NULL, NULL, 'hNGKqeLdlt', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative,Trance,Music,Alternative}');
INSERT INTO streams VALUES (1028, 'fyOUSfLdTf', 'audio/mpeg', NULL, NULL, 'x1aH2gGHh7', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Trance}');
INSERT INTO streams VALUES (859, 'nMlGHRz3ip', 'application/ogg+vorbis', NULL, NULL, 'qjNQULbDfF', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Pop,Pop,Blues}');
INSERT INTO streams VALUES (972, 'HEMt0x8xKG', 'application/ogg+theora', NULL, NULL, '0E53unfR2W', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Rock,Trance}');
INSERT INTO streams VALUES (997, 'PhRPHBVG05', 'audio/aac', NULL, NULL, 'YE0Yz13JLp', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Trance}');
INSERT INTO streams VALUES (824, 'NgABUwRFxd', 'application/ogg+theora', NULL, NULL, 'TrztpQtL4R', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Trance,Christian,Hits,Pop}');
INSERT INTO streams VALUES (899, '2eVliUoIlX', 'audio/mpeg', NULL, NULL, '9a8A2O5AMX', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Blues,Trance,Hits}');
INSERT INTO streams VALUES (835, '7Hqviao3xE', 'application/ogg+theora', NULL, NULL, '9jOcBAaCJZ', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Hits,Trance,Blues}');
INSERT INTO streams VALUES (923, 'IJxTRyPJL6', 'audio/mpeg', NULL, NULL, 'ZhUbGSZSRg', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Hits,Trance,Various}');
INSERT INTO streams VALUES (1013, 'oOo0ZkAzwP', 'application/ogg+theora', NULL, NULL, 'voN3m4zrBp', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Alternative}');
INSERT INTO streams VALUES (917, 'BCGjazhfo6', 'audio/aac', NULL, NULL, 'WFyS9crIMY', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative,Trance}');
INSERT INTO streams VALUES (1005, 'N4Gp0ZUf3X', 'application/ogg+vorbis', NULL, NULL, 'C09ey60nwF', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Christian,Jazz}');
INSERT INTO streams VALUES (1036, 'jRk1PkLR6B', 'audio/mpeg', NULL, NULL, 'uALaDHPgWV', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Blues,Radio,Blues}');
INSERT INTO streams VALUES (907, 'qcu4RHLv3n', 'application/ogg+vorbis', NULL, NULL, 'fRUbkfGhtN', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Blues,Pop,Music,Pop,Blues}');
INSERT INTO streams VALUES (957, 'BFcplMAJwf', 'audio/aacp', NULL, NULL, 'mDph0xLj3V', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Trance,Pop}');
INSERT INTO streams VALUES (884, 'HgtkJhq3TU', 'audio/aac', NULL, NULL, 'hohaFnOLmS', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Radio}');
INSERT INTO streams VALUES (940, 'Nai2Kr9Xh3', 'video/nsv', NULL, NULL, 'PSevD3IcST', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Electro,Radio}');
INSERT INTO streams VALUES (843, '8Scb6XF3t8', 'application/ogg+theora', NULL, NULL, 'z8g6dEe0DR', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Trance,Jazz}');
INSERT INTO streams VALUES (980, '94LocIU8Yj', 'audio/mpeg', NULL, NULL, '6JNky58Kqt', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Pop,Radio,Trance,Pop}');
INSERT INTO streams VALUES (964, 'h5yXylxQTh', 'audio/mpeg', NULL, NULL, 'JAPglt5rxQ', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Pop}');
INSERT INTO streams VALUES (1021, 'yPko7J68wo', 'audio/aac', NULL, NULL, 'PYIgEse5eo', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative,Christian}');
INSERT INTO streams VALUES (867, 'ISGdQGjApL', 'audio/aac', NULL, NULL, 'ZpakmOj9vb', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative,Various}');
INSERT INTO streams VALUES (875, 'KLHijHhAPg', 'audio/aacp', NULL, NULL, 'c1VQYSOvJB', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Various,Jazz}');
INSERT INTO streams VALUES (1044, '1vOer4UtJk', 'video/nsv', NULL, NULL, 'EwLY3fzU5u', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz}');
INSERT INTO streams VALUES (989, 'OXHbJAPPyA', 'audio/aacp', NULL, NULL, 'IDS9cVIIdC', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Music}');
INSERT INTO streams VALUES (817, 'TOlHjB9YK9', 'application/ogg+vorbis', NULL, NULL, '1gInlXxLr5', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Pop,Music,Radio,Pop}');
INSERT INTO streams VALUES (948, 'pJhHwYSImi', 'application/ogg+vorbis', NULL, NULL, 'rcln0Vc0xf', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Music,Hits}');
INSERT INTO streams VALUES (927, 'idbVmZRxQH', 'audio/aacp', NULL, NULL, 'ln9WHcbpqS', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Trance,Pop}');
INSERT INTO streams VALUES (809, 'TEneLBSKQN', 'audio/aac', NULL, NULL, '4VoKoYQaQt', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Radio,Electro}');
INSERT INTO streams VALUES (998, 'RgFDlQoN4n', 'audio/aac', NULL, NULL, 'fTy28y60kL', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Trance,Electro,Radio}');
INSERT INTO streams VALUES (1016, 'mXvzQgYkOG', 'application/ogg+vorbis', NULL, NULL, 'PxeqIaj0Fl', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative,Radio}');
INSERT INTO streams VALUES (845, 'VwMxMZJroM', 'application/ogg+vorbis', NULL, NULL, '0mh54Fgd5v', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Pop,Pop}');
INSERT INTO streams VALUES (943, 'gfxs4eQGAV', 'audio/aac', NULL, NULL, 'WD7orBXoF4', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop}');
INSERT INTO streams VALUES (918, 'n5DJVcXB7s', 'audio/aac', NULL, NULL, 'rTuuTjc2fb', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian,Alternative,Various}');
INSERT INTO streams VALUES (834, 'YzZVXGwrgJ', 'application/ogg+theora', NULL, NULL, 's6TcbkJ6GQ', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian,Radio}');
INSERT INTO streams VALUES (965, 'RovZFGvqZF', 'audio/aacp', NULL, NULL, 'KYlwlSdnl7', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Radio,Trance,Trance,Radio}');
INSERT INTO streams VALUES (958, 'I39BFegJNJ', 'audio/aacp', NULL, NULL, 'k2Hi75h7qk', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Alternative,Radio,Alternative}');
INSERT INTO streams VALUES (831, '4MBz7SjlYJ', 'audio/mpeg', NULL, NULL, 'IBgJ2JKofL', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian,Hits}');
INSERT INTO streams VALUES (819, 'rUISH7Atkf', 'audio/aac', NULL, NULL, 'XKSNvCXzP9', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Various,Jazz,Pop}');
INSERT INTO streams VALUES (829, 'cJWWLkBN7R', 'application/ogg+vorbis', NULL, NULL, 'L74waxebyU', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Electro,Trance,Electro,Blues}');
INSERT INTO streams VALUES (876, 'ko9XTp5Z48', 'application/ogg+theora', NULL, NULL, 'mboPw8MzrD', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative,Christian,Pop,Radio}');
INSERT INTO streams VALUES (984, '8pOxqFgz4V', 'audio/aacp', NULL, NULL, 'N1TbRcQh6B', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio}');
INSERT INTO streams VALUES (933, 'h9qFuPSCd8', 'audio/aacp', NULL, NULL, 'Sh3ajHFPgE', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Rock}');
INSERT INTO streams VALUES (895, 'LTfZgD2oZQ', 'audio/aac', NULL, NULL, 'Qa5er9WV6F', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Alternative,Blues}');
INSERT INTO streams VALUES (886, 'z4wAQovj5R', 'application/ogg+theora', NULL, NULL, 'PcFiX8luDt', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian,Alternative}');
INSERT INTO streams VALUES (870, 'nI5xrEUxuj', 'audio/aacp', NULL, NULL, 'F4c1OqFk0e', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative,Alternative,Alternative,Pop}');
INSERT INTO streams VALUES (855, '4Wh0szkDRz', 'audio/mpeg', NULL, NULL, 'IMUQ2TOIL3', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Blues,Pop,Pop}');
INSERT INTO streams VALUES (909, 'lvWgeXcnmd', 'audio/aac', NULL, NULL, 'xkSoxdBQpr', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Jazz,Trance,Hits,Alternative}');
INSERT INTO streams VALUES (849, 'VaWcYIUY98', 'application/ogg+vorbis', NULL, NULL, 'SNXOTEC1sT', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Blues,Pop,Music,Music,Various}');
INSERT INTO streams VALUES (866, 'FHoxp4VFQR', 'audio/aac', NULL, NULL, 'u3Ke4Dj5rU', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Blues,Music}');
INSERT INTO streams VALUES (1001, 'Ti35kRGN3I', 'application/ogg+vorbis', NULL, NULL, '8iq72LKFFZ', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Trance,Hits}');
INSERT INTO streams VALUES (901, '4DVu1Y40hE', 'audio/aacp', NULL, NULL, 'cD8NfsSLO7', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Alternative}');
INSERT INTO streams VALUES (912, '46FgdQmvLx', 'audio/aac', NULL, NULL, 'bFdr3Vks2K', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Blues}');
INSERT INTO streams VALUES (858, 'cazbZPt2KP', 'audio/aacp', NULL, NULL, 'EI6V6ZWzeq', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Various}');
INSERT INTO streams VALUES (924, 'e8U2ruTHqE', 'audio/mpeg', NULL, NULL, 'BdWkQuMifA', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Pop,Radio,Alternative}');
INSERT INTO streams VALUES (968, 'ABDmJWGRGY', 'audio/aac', NULL, NULL, 'PepwNrqJrJ', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Blues,Hits}');
INSERT INTO streams VALUES (1030, 'Bn5ZbT7Gkz', 'audio/aac', NULL, NULL, 'ZMsfGWKyPv', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Hits,Various}');
INSERT INTO streams VALUES (949, 'QdCU93u1cs', 'audio/aacp', NULL, NULL, '03ZbrCGJII', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative,Pop}');
INSERT INTO streams VALUES (1037, 'YMtQC19Wet', 'application/ogg+vorbis', NULL, NULL, 'ZUwzuZjIYf', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Jazz,Jazz}');
INSERT INTO streams VALUES (879, 'U4HH4i64Qs', 'application/ogg+theora', NULL, NULL, 'A3u6ITJbpD', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Blues,Pop,Jazz}');
INSERT INTO streams VALUES (941, 'dD5lQdJ6UG', 'audio/aac', NULL, NULL, 'HBVABKDh9g', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian,Hits}');
INSERT INTO streams VALUES (1029, '9iuBMaKGvu', 'application/ogg+theora', NULL, NULL, 'NxrpwZCr4U', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio}');
INSERT INTO streams VALUES (981, 'OfV59btJ14', 'video/nsv', NULL, NULL, 'D8E5nKFcDH', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Blues,Hits}');
INSERT INTO streams VALUES (893, 'L0Z0PFvwlY', 'application/ogg+vorbis', NULL, NULL, '1DRnOuAvWZ', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Hits}');
INSERT INTO streams VALUES (973, 'f18PHnW8pw', 'application/ogg+theora', NULL, NULL, 'Y35lofSHmS', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop}');
INSERT INTO streams VALUES (818, 'LqGyuyJKCY', 'video/nsv', NULL, NULL, '6I0C2wLHp7', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Hits,Radio}');
INSERT INTO streams VALUES (990, 'RdxkwS5fIH', 'application/ogg+theora', NULL, NULL, 'yEMfw31jV8', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Blues,Music,Various,Christian}');
INSERT INTO streams VALUES (1022, 'BCyRZz9QCJ', 'audio/aac', NULL, NULL, 'SC0DBqpMYL', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio}');
INSERT INTO streams VALUES (1006, 'cdwE5Kx2zz', 'application/ogg+vorbis', NULL, NULL, '9nCZmIRMOk', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative,Trance,Pop,Jazz,Rock}');
INSERT INTO streams VALUES (1045, 'IQIYmd3Sgc', 'application/ogg+theora', NULL, NULL, 'dvtEuvjVnf', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Pop}');
INSERT INTO streams VALUES (1014, '3FEJIc5d9X', 'audio/aacp', NULL, NULL, 'NLmjRZO1Hs', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Pop,Radio}');
INSERT INTO streams VALUES (856, 'NIcoWTItYl', 'audio/aac', NULL, NULL, 'IFjZsOuK9Z', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Christian,Music,Music}');
INSERT INTO streams VALUES (810, 'QkwX3U5Hmw', 'audio/aac', NULL, NULL, 'wGAPK7ZEfx', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Trance,Radio}');
INSERT INTO streams VALUES (821, 'nslrgt9YEQ', 'audio/aacp', NULL, NULL, 'tiYYLoxwdL', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Music,Rock}');
INSERT INTO streams VALUES (935, 'pWwZ3l4Quj', 'application/ogg+vorbis', NULL, NULL, '5DqNpTU4Lx', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Radio}');
INSERT INTO streams VALUES (966, 'VPAcempQAW', 'audio/aacp', NULL, NULL, 'BgXxrAfOC8', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Blues,Jazz,Hits}');
INSERT INTO streams VALUES (830, 'oTe9lPniDv', 'application/ogg+vorbis', NULL, NULL, 'tgty8kAOwx', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Various,Trance,Music}');
INSERT INTO streams VALUES (991, 'T2pDVVu7wK', 'application/ogg+theora', NULL, NULL, '70AO9DpsXz', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Music,Various,Trance}');
INSERT INTO streams VALUES (820, '3T1n0CUaht', 'application/ogg+theora', NULL, NULL, 'zl5753rneU', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Blues,Radio}');
INSERT INTO streams VALUES (887, 'KQKIBeWbA6', 'application/ogg+theora', NULL, NULL, 'Kk4WLFFjRx', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Jazz,Hits}');
INSERT INTO streams VALUES (903, 'ytO6C6mwUW', 'application/ogg+theora', NULL, NULL, 'mASnOVSvVT', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Hits,Electro,Christian}');
INSERT INTO streams VALUES (942, 'L2JSSHs4AW', 'application/ogg+vorbis', NULL, NULL, 'HozB0HrPfu', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative,Hits,Music}');
INSERT INTO streams VALUES (952, 'vf6iLWlBLB', 'application/ogg+theora', NULL, NULL, 'WImlxhSDtt', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Hits,Trance}');
INSERT INTO streams VALUES (1032, 'JoPT3Z8DgR', 'audio/aacp', NULL, NULL, 'LraVSio7sj', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Blues}');
INSERT INTO streams VALUES (1017, 'GPlsPgRyCq', 'application/ogg+theora', NULL, NULL, 'zUsf4bdKMf', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop}');
INSERT INTO streams VALUES (840, 'Q1JkcUXCAT', 'application/ogg+vorbis', NULL, NULL, 'zaXzElYZje', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Blues}');
INSERT INTO streams VALUES (999, 'hTgB6xxcEN', 'application/ogg+vorbis', NULL, NULL, '2hhLXhPBj3', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian}');
INSERT INTO streams VALUES (925, 'LYwobQtIJt', 'audio/aac', NULL, NULL, 'inr1XLJQcs', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz}');
INSERT INTO streams VALUES (982, 'WOKXdi5Frf', 'application/ogg+theora', NULL, NULL, 'GbnJ2sJShm', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian,Music,Jazz,Pop}');
INSERT INTO streams VALUES (974, 'wgRjp0URwc', 'application/ogg+vorbis', NULL, NULL, '9Kw9ks3U0V', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Blues,Hits}');
INSERT INTO streams VALUES (871, 'C9ohfsHDoO', 'audio/aacp', NULL, NULL, 'BckbaXLRKP', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Rock,Jazz}');
INSERT INTO streams VALUES (850, 'P6U2sdrHEI', 'application/ogg+theora', NULL, NULL, 'xPXVEOGph3', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Radio}');
INSERT INTO streams VALUES (1007, '91SP0Ui9An', 'application/ogg+theora', NULL, NULL, 'o7miJfA1sb', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Jazz,Trance}');
INSERT INTO streams VALUES (911, 'L8Tmu2Q9VF', 'application/ogg+vorbis', NULL, NULL, 'BkIXlhauO7', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian,Alternative,Blues,Various}');
INSERT INTO streams VALUES (1012, 'ObpVbiT6sW', 'application/ogg+theora', NULL, NULL, 'NTwpUFPGxL', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Electro,Hits,Hits}');
INSERT INTO streams VALUES (1027, '7WTxQcGM9A', 'audio/aac', NULL, NULL, 'DBtcRNfy50', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Blues}');
INSERT INTO streams VALUES (900, 'Ecg7MLpVN1', 'audio/aacp', NULL, NULL, '3LVn8Wjckm', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian}');
INSERT INTO streams VALUES (874, 'lb7RPexthw', 'audio/aacp', NULL, NULL, 'zAH4nFF2nc', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian,Music,Pop,Blues,Electro}');
INSERT INTO streams VALUES (971, '8gBGESyldx', 'application/ogg+theora', NULL, NULL, '7FMwg7qRQg', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Electro,Alternative,Electro}');
INSERT INTO streams VALUES (996, 'o2hHvVaTrD', 'application/ogg+theora', NULL, NULL, 'n3ZNsOxokC', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative,Jazz}');
INSERT INTO streams VALUES (979, 'v32IZwyvzt', 'application/ogg+theora', NULL, NULL, 'f772NSVyuF', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Music,Trance,Various}');
INSERT INTO streams VALUES (939, 'VFacm2kCzV', 'audio/aacp', NULL, NULL, 'M2dpKELO8b', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music}');
INSERT INTO streams VALUES (825, 'YGZuC120BN', 'audio/mpeg', NULL, NULL, 'xhC7V6n7m9', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Trance,Pop,Hits,Electro}');
INSERT INTO streams VALUES (883, 'yVObugPOqR', 'video/nsv', NULL, NULL, 'w1RL1apqqD', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Rock,Alternative,Pop}');
INSERT INTO streams VALUES (839, 'c4cGQlzqf5', 'application/ogg+theora', NULL, NULL, 'dYyy8arAyG', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Music,Trance}');
INSERT INTO streams VALUES (851, 'hW8juBovgw', 'application/ogg+theora', NULL, NULL, 'MEiAM1FG9a', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Pop}');
INSERT INTO streams VALUES (988, 'oSBbeng5Sc', 'audio/aacp', NULL, NULL, 'mjvEjH96p0', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Rock,Trance,Various}');
INSERT INTO streams VALUES (931, 'OE4NBlTgNd', 'audio/aacp', NULL, NULL, 'rcBftQeKV3', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Trance}');
INSERT INTO streams VALUES (956, 'TukGejwDGv', 'application/ogg+theora', NULL, NULL, 'gZGxY7HZVn', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Various}');
INSERT INTO streams VALUES (865, '8HJUX2bPEJ', 'audio/aacp', NULL, NULL, 'UxNVsTGHL8', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Various}');
INSERT INTO streams VALUES (1004, 'vmA28x09rH', 'application/ogg+theora', NULL, NULL, 'NHeKujYCWJ', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Pop,Pop,Christian}');
INSERT INTO streams VALUES (963, '1q7XWZE51f', 'audio/aacp', NULL, NULL, 'IftnE16686', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Radio,Christian}');
INSERT INTO streams VALUES (916, '5D9DnLpuZ3', 'application/ogg+theora', NULL, NULL, 'pEFqlZ48AQ', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Blues,Electro,Alternative}');
INSERT INTO streams VALUES (922, 'iy3rjfgS2I', 'audio/aacp', NULL, NULL, 'IQf4lxWXfl', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Jazz,Hits,Electro}');
INSERT INTO streams VALUES (1043, 'k7Ucz4J4q0', 'application/ogg+theora', NULL, NULL, 'sVYFRevhkP', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Trance}');
INSERT INTO streams VALUES (857, 'q8f6kwGJ8T', 'audio/mpeg', NULL, NULL, 'Keaxb2w9QC', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Hits}');
INSERT INTO streams VALUES (891, 'XssZ6DeaB9', 'application/ogg+theora', NULL, NULL, 'UTvP356ej2', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Alternative,Blues}');
INSERT INTO streams VALUES (811, 'ppHYwZzbeu', 'audio/aac', NULL, NULL, 'c2abqRyrxt', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Trance,Trance}');
INSERT INTO streams VALUES (1020, 'KUTpXKIy0g', 'audio/aacp', NULL, NULL, 'yuvefBr0bP', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian}');
INSERT INTO streams VALUES (906, 'HkoB0jAQYV', 'video/nsv', NULL, NULL, 'cetNxLXVQw', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Jazz,Blues,Trance,Pop}');
INSERT INTO streams VALUES (1035, 'YeXPYWhJQm', 'application/ogg+vorbis', NULL, NULL, 'vJCszEKwjm', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Music}');
INSERT INTO streams VALUES (947, 'gzTvQrTJAu', 'application/ogg+vorbis', NULL, NULL, 'VEfepxmY1O', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Electro}');
INSERT INTO streams VALUES (921, '9wZf22RXyQ', 'audio/mpeg', NULL, NULL, '9odlt556UN', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Music,Jazz,Christian}');
INSERT INTO streams VALUES (873, 'PkQSn6H9hE', 'application/ogg+theora', NULL, NULL, 'jMGCwCjV8t', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Trance,Electro,Various,Hits}');
INSERT INTO streams VALUES (812, '8VrPX5n0hO', 'application/ogg+vorbis', NULL, NULL, '0hvX6y1NI2', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Trance,Various,Trance}');
INSERT INTO streams VALUES (882, 'CSxcl055by', 'audio/aacp', NULL, NULL, 'UeqXODWqWH', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Electro,Christian,Blues,Hits}');
INSERT INTO streams VALUES (905, 'zjgQar7S9g', 'application/ogg+theora', NULL, NULL, '2MxnXHrXHM', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative,Electro,Trance}');
INSERT INTO streams VALUES (1003, 'p6kEz43L3r', 'application/ogg+theora', NULL, NULL, 'RkYj3BfiLC', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz}');
INSERT INTO streams VALUES (987, 'CMliF0z3pd', 'application/ogg+vorbis', NULL, NULL, 'w0YBLXDTqL', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian,Blues}');
INSERT INTO streams VALUES (1011, 'DnbjcEC8ad', 'audio/aacp', NULL, NULL, 'oZyjaW9HVu', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Trance,Christian,Music,Radio}');
INSERT INTO streams VALUES (898, 'qG4DirIuUv', 'audio/mpeg', NULL, NULL, 'WJNzNZrAEH', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Electro,Radio,Music}');
INSERT INTO streams VALUES (930, 'Hc9p0IBZ91', 'video/nsv', NULL, NULL, 'dm7w47v48Z', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Alternative,Christian}');
INSERT INTO streams VALUES (864, 'DD9RCCgDuM', 'video/nsv', NULL, NULL, 'LQq5T5A4Fz', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Blues,Hits}');
INSERT INTO streams VALUES (946, 'ohkZMbvRMY', 'application/ogg+vorbis', NULL, NULL, '0brynf3fw5', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Various}');
INSERT INTO streams VALUES (842, '0sdT8PCpsh', 'audio/aacp', NULL, NULL, 'YAm0PIOSEI', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop}');
INSERT INTO streams VALUES (848, 'Csx4WNlMLA', 'application/ogg+theora', NULL, NULL, 'ED857HCVUe', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Trance}');
INSERT INTO streams VALUES (1034, 'Wy53pD8dRK', 'audio/aac', NULL, NULL, 'cweIN5syUG', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Blues,Radio,Radio}');
INSERT INTO streams VALUES (1026, 'BkBW2XZG2I', 'video/nsv', NULL, NULL, 'D6HdzSZZb2', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Hits}');
INSERT INTO streams VALUES (962, 'mEqos9PUQh', 'application/ogg+vorbis', NULL, NULL, 'OdBO6YljFA', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Trance,Hits,Pop}');
INSERT INTO streams VALUES (938, 'huBNGmPTXK', 'audio/aac', NULL, NULL, 'UoNy9VHLUv', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian,Jazz,Blues}');
INSERT INTO streams VALUES (890, 'JjIreZxl6C', 'application/ogg+vorbis', NULL, NULL, '3lDmILkSsc', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Blues,Hits,Music,Blues}');
INSERT INTO streams VALUES (1019, 'JB85w1BQdv', 'audio/aacp', NULL, NULL, 'NjTDItlC1k', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Trance,Trance}');
INSERT INTO streams VALUES (978, 'NLWD5soPvx', 'video/nsv', NULL, NULL, 'rQVGjFJFWS', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Various}');
INSERT INTO streams VALUES (915, 'pPzrUPGAfz', 'application/ogg+vorbis', NULL, NULL, 'h9lxCfCKwn', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Alternative,Blues}');
INSERT INTO streams VALUES (833, 'qV7sEj2RK4', 'audio/aacp', NULL, NULL, 'geBhxDoVYp', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Pop,Trance,Hits}');
INSERT INTO streams VALUES (955, 'si5cdg9hMb', 'audio/aac', NULL, NULL, 'rt4MAuUMUw', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative,Trance}');
INSERT INTO streams VALUES (854, 'AZcV44OkED', 'application/ogg+vorbis', NULL, NULL, 'Xjgkbjflv4', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian,Pop,Various}');
INSERT INTO streams VALUES (1038, 'KU6cTYpgkD', 'application/ogg+theora', NULL, NULL, 'DOKIUv3tqL', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative}');
INSERT INTO streams VALUES (826, 'OqpShdJHrr', 'audio/aacp', NULL, NULL, 'f6KLcUnuQl', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music}');
INSERT INTO streams VALUES (970, 'owDKQ8zlXM', 'application/ogg+vorbis', NULL, NULL, 'G0XGnG4qKd', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Blues}');
INSERT INTO streams VALUES (995, 't7EU1NdUig', 'application/ogg+vorbis', NULL, NULL, '05H9ZRg9uJ', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Music}');
INSERT INTO streams VALUES (1042, 'kmWmajd8U7', 'video/nsv', NULL, NULL, 'RJ8Q8oAqnP', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Trance}');
INSERT INTO streams VALUES (841, 'tF9eGHQuBr', 'application/ogg+vorbis', NULL, NULL, 'L4mwiY5u6q', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian,Trance,Pop,Trance}');
INSERT INTO streams VALUES (847, 'xpByeoYWGS', 'audio/aacp', NULL, NULL, 'Ysi65dh1G8', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Rock,Various,Various,Trance}');
INSERT INTO streams VALUES (853, 'Fb7gxiQsL9', 'video/nsv', NULL, NULL, 'bs0il01qvF', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Rock}');
INSERT INTO streams VALUES (937, 'vETgo7GEoC', 'audio/aac', NULL, NULL, 'Xm2tOBfonC', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits}');
INSERT INTO streams VALUES (1010, 'JxCkJjGP0i', 'application/ogg+theora', NULL, NULL, 'bkJqAwDrh1', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Jazz,Radio}');
INSERT INTO streams VALUES (961, 'pAhBVv1VPd', 'application/ogg+vorbis', NULL, NULL, 'mWbOB4WTrD', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Blues}');
INSERT INTO streams VALUES (945, 'NZmmc6yNNL', 'application/ogg+vorbis', NULL, NULL, 'WPt3xwuOBj', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Music,Pop,Christian}');
INSERT INTO streams VALUES (813, 'Xd0Nasmkmc', 'application/ogg+theora', NULL, NULL, 'OrTfPfkEBv', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative,Trance}');
INSERT INTO streams VALUES (1025, 'S9pNatkyvD', 'audio/mpeg', NULL, NULL, 'MBry0fsPNB', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Christian,Jazz,Various}');
INSERT INTO streams VALUES (822, 'KLSrF1zPfc', 'application/ogg+vorbis', NULL, NULL, 'Y1XutGvIdW', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Christian,Blues,Jazz}');
INSERT INTO streams VALUES (929, 'R0gZNjmZjn', 'video/nsv', NULL, NULL, '2pXHtc7X2m', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Hits,Blues}');
INSERT INTO streams VALUES (969, '4gn8ieXSTJ', 'application/ogg+vorbis', NULL, NULL, 'iZhBFEoPjA', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian,Various,Blues,Music}');
INSERT INTO streams VALUES (863, '7xLO5ohRDY', 'application/ogg+theora', NULL, NULL, 'xKxA7fVLMy', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Blues,Various,Various,Pop}');
INSERT INTO streams VALUES (872, 'VZOnvsblCa', 'application/ogg+theora', NULL, NULL, 'cNCDYTf8JZ', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Blues}');
INSERT INTO streams VALUES (881, 'XnI3WIGdAY', 'application/ogg+theora', NULL, NULL, 'I7WeCN4ArV', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Electro,Jazz}');
INSERT INTO streams VALUES (832, 'p7YDHnz6ny', 'application/ogg+vorbis', NULL, NULL, 'b1s2w3Kfsx', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Blues,Hits}');
INSERT INTO streams VALUES (889, 'GfKQAZZT6U', 'application/ogg+vorbis', NULL, NULL, 'hfYLlUcEGO', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Trance}');
INSERT INTO streams VALUES (920, 'WxOl5vHrjL', 'audio/mpeg', NULL, NULL, 'mYuv625Id8', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative,Music,Radio,Electro}');
INSERT INTO streams VALUES (1033, 'cXFOOf5b4c', 'application/ogg+theora', NULL, NULL, 'o0S5uaRwwe', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Trance}');
INSERT INTO streams VALUES (897, 'B2PfQjF2vL', 'application/ogg+vorbis', NULL, NULL, 'jh0uBz4tlw', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative,Jazz}');
INSERT INTO streams VALUES (986, 'YVrqlUoOc7', 'application/ogg+vorbis', NULL, NULL, 'qx1KOSmw8M', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Rock,Radio}');
INSERT INTO streams VALUES (954, '5Vhc9Cdclm', 'application/ogg+theora', NULL, NULL, 'oH32elGIF7', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Music,Alternative}');
INSERT INTO streams VALUES (994, '7yWfPZEOJo', 'audio/aacp', NULL, NULL, 'zWJCQ13GZp', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Jazz}');
INSERT INTO streams VALUES (914, 'CdDKykcFOy', 'audio/aacp', NULL, NULL, 'aMdBTP21LE', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Pop,Blues,Various}');
INSERT INTO streams VALUES (1041, 'K2DuzEbraG', 'video/nsv', NULL, NULL, '5AghEBu7GI', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Jazz}');
INSERT INTO streams VALUES (1002, 'VEToj0Dug6', 'video/nsv', NULL, NULL, 'Ozf8gW4o3X', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Hits,Trance,Blues}');
INSERT INTO streams VALUES (1018, 'UzJwRjTQCU', 'audio/aacp', NULL, NULL, 'EpVFyXCul2', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Hits}');
INSERT INTO streams VALUES (904, 'TYHy0WXy7J', 'video/nsv', NULL, NULL, 'ZdwMfkv2wh', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Electro}');
INSERT INTO streams VALUES (977, 'zZvHbvWB1q', 'audio/aac', NULL, NULL, '8NAHBDcoNw', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Blues,Various}');
INSERT INTO streams VALUES (944, '3Fla67tNim', 'video/nsv', NULL, NULL, 'MArC8ipTof', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Blues,Electro,Hits}');
INSERT INTO streams VALUES (1009, 'lNqMHiXlyk', 'video/nsv', NULL, NULL, '2xpECv7nE5', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Jazz,Hits}');
INSERT INTO streams VALUES (913, 'J6le6Ka108', 'audio/aacp', NULL, NULL, 'WcOVYE3JZ9', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian,Jazz,Various,Rock}');
INSERT INTO streams VALUES (827, 'i8egn9EFrn', 'audio/aacp', NULL, NULL, 'FEdxVswEB8', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Electro,Alternative}');
INSERT INTO streams VALUES (838, 'ALlvrdykFv', 'audio/mpeg', NULL, NULL, 'VwSQZstjFA', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Blues,Radio,Christian}');
INSERT INTO streams VALUES (953, 'V1dMFP4gfc', 'audio/aac', NULL, NULL, 'DkuJrlYqbz', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Alternative,Jazz,Rock}');
INSERT INTO streams VALUES (862, 'ViOxKH9le1', 'application/ogg+theora', NULL, NULL, 'lNWEOmJRnt', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Rock,Trance,Trance,Hits,Radio}');
INSERT INTO streams VALUES (896, 'poSElw5lnK', 'audio/aac', NULL, NULL, 'Y8iWsteBLO', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Blues,Electro,Various}');
INSERT INTO streams VALUES (852, '2Z7ZCFpM90', 'application/ogg+theora', NULL, NULL, 'DRsIu54iN8', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz}');
INSERT INTO streams VALUES (1040, 'XmGnuTEHZs', 'application/ogg+vorbis', NULL, NULL, 'jNU7mizpEu', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Rock,Trance,Blues}');
INSERT INTO streams VALUES (1024, 'SfMkuFPjKi', 'application/ogg+vorbis', NULL, NULL, '8fOQraxMuv', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Hits,Jazz,Various}');
INSERT INTO streams VALUES (814, 'vMHR40MjuJ', 'application/ogg+theora', NULL, NULL, 'OaRULrZK1h', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Trance}');
INSERT INTO streams VALUES (928, 'WTZehEytax', 'audio/aac', NULL, NULL, '7T0XTiuUiZ', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Jazz,Alternative,Radio}');
INSERT INTO streams VALUES (960, 'hjD4gMdb1n', 'application/ogg+theora', NULL, NULL, 'Z5rjy2A1ij', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Electro}');
INSERT INTO streams VALUES (976, 'dioDTjFgpA', 'audio/mpeg', NULL, NULL, 'hah7C4iQXU', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Pop,Jazz}');
INSERT INTO streams VALUES (993, 'PtvL5mrzjo', 'audio/mpeg', NULL, NULL, '2034BKIYvr', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Trance,Rock,Alternative}');
INSERT INTO streams VALUES (880, '0N6wiKYpbn', 'audio/mpeg', NULL, NULL, '7acYS1VCQS', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Christian,Pop}');
INSERT INTO streams VALUES (1015, '9oWhe0Wv09', 'audio/aac', NULL, NULL, 'VLm7FnuKal', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Music,Hits,Blues}');
INSERT INTO streams VALUES (888, 'o330ofXX3R', 'application/ogg+vorbis', NULL, NULL, 'k721O2HZ8k', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Hits,Hits}');
INSERT INTO streams VALUES (823, 'BqCdZAv7KZ', 'application/ogg+vorbis', NULL, NULL, 'v6DABoFrGj', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Rock}');
INSERT INTO streams VALUES (837, 'CvfjO7OVch', 'video/nsv', NULL, NULL, 'dUQKv1cAvk', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Blues,Jazz,Alternative,Rock,Trance,Jazz}');
INSERT INTO streams VALUES (1031, 'M4K5w0M9GO', 'application/ogg+vorbis', NULL, NULL, 'dT8Q7pxUEW', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Radio}');
INSERT INTO streams VALUES (908, '19Wcfeqjdj', 'application/ogg+vorbis', NULL, NULL, 'RLtuJkxhzw', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Trance,Pop,Alternative}');
INSERT INTO streams VALUES (983, 'ihFQesgeJ6', 'audio/aacp', NULL, NULL, 'zF7PzuyJfb', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian,Trance}');
INSERT INTO streams VALUES (878, 'XqUx4DH7eV', 'application/ogg+theora', NULL, NULL, 'y6v1gcg8Dh', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Hits}');
INSERT INTO streams VALUES (902, 'FTAXlU1Ni3', 'application/ogg+theora', NULL, NULL, 'pmEauVfipu', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Radio,Various,Pop}');
INSERT INTO streams VALUES (815, 'xq0g4zV5gW', 'video/nsv', NULL, NULL, 'RUyqesPaRU', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Electro}');
INSERT INTO streams VALUES (951, '7RAYYv4WG0', 'audio/aacp', NULL, NULL, 'dCcUksqTix', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Music}');
INSERT INTO streams VALUES (967, 'vRuQByTJom', 'application/ogg+vorbis', NULL, NULL, '6hobp1Vpxu', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Various,Alternative,Pop}');
INSERT INTO streams VALUES (919, 'Q0cZbkucJO', 'application/ogg+theora', NULL, NULL, 'zJRkQ7aTl1', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Alternative,Alternative,Various,Trance}');
INSERT INTO streams VALUES (869, 'di812KgF6q', 'audio/aac', NULL, NULL, 'vci4ns4aEX', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Blues,Hits,Christian,Various}');
INSERT INTO streams VALUES (844, 'kEL8bOGjf4', 'audio/mpeg', NULL, NULL, 'R1jqRNwc3h', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Rock,Various,Jazz}');
INSERT INTO streams VALUES (1000, 'yTCF7pYeaY', 'audio/aac', NULL, NULL, 'FY8LU3a7Ip', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian,Christian}');
INSERT INTO streams VALUES (860, 'BwIqeNQUjQ', 'audio/aacp', NULL, NULL, 't78WWoVons', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Trance,Radio}');
INSERT INTO streams VALUES (934, 'F708W5VR1z', 'video/nsv', NULL, NULL, 'bFBdNptdgB', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Various,Jazz,Various,Electro}');
INSERT INTO streams VALUES (836, 'UlmnggqTnK', 'audio/aac', NULL, NULL, 'Noz8MLWshj', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian}');
INSERT INTO streams VALUES (985, 'BqXrOL05Zk', 'application/ogg+vorbis', NULL, NULL, 'CuzBl2Jjzc', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Music,Music}');
INSERT INTO streams VALUES (950, '2QMOOS3Y7E', 'audio/aacp', NULL, NULL, 'eDFG139TbL', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Christian,Blues,Alternative,Hits}');
INSERT INTO streams VALUES (926, 'EVXtDEwDhc', 'audio/aacp', NULL, NULL, '8C0uKFaYKz', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Pop,Rock}');
INSERT INTO streams VALUES (828, 'TGDHfEzedS', 'audio/aacp', NULL, NULL, 'CWMmfnNZ8r', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Trance,Rock}');
INSERT INTO streams VALUES (936, 'cGzknO60Gq', 'application/ogg+vorbis', NULL, NULL, 'n6krC6SgXC', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative,Alternative,Trance}');
INSERT INTO streams VALUES (861, 'UcvajjCHNp', 'audio/aac', NULL, NULL, '2OVgCQVWDq', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Radio,Music,Alternative,Alternative}');
INSERT INTO streams VALUES (868, 'zgB7rzxzIM', 'video/nsv', NULL, NULL, 'iJDjunIDuQ', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Electro,Pop,Music}');
INSERT INTO streams VALUES (959, '2XBnkwhQ8L', 'audio/aac', NULL, NULL, 'ZPq5JNeciD', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Music}');
INSERT INTO streams VALUES (992, '3nBrd4eDVk', 'application/ogg+theora', NULL, NULL, 'oJPp70Wb9A', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Alternative}');
INSERT INTO streams VALUES (846, 'yMhUmczH3C', 'application/ogg+theora', NULL, NULL, 'Hjy4PbedvF', NULL, '{Theora}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Blues,Music,Radio,Trance,Christian}');
INSERT INTO streams VALUES (975, 'tmDvR6l36L', 'audio/aacp', NULL, NULL, 'WttrY2xT6v', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Music,Radio}');
INSERT INTO streams VALUES (910, 'qeBXk9kWF8', 'audio/aac', NULL, NULL, 'PJ3370pD0m', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Hits,Alternative}');
INSERT INTO streams VALUES (1039, 'Fy0jBk44qn', 'audio/aac', NULL, NULL, 'NewtPxLX0H', NULL, '{AAC}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Various}');
INSERT INTO streams VALUES (885, 'a10jpZfeWq', 'audio/mpeg', NULL, NULL, 'iexJyPrBPm', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Blues,Radio,Music,Blues}');
INSERT INTO streams VALUES (816, 'y85oo3eLN1', 'audio/aacp', NULL, NULL, 'XAnofDffNz', NULL, '{AAC+}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Blues,Hits,Blues}');
INSERT INTO streams VALUES (894, 'pWGZnke8cX', 'video/nsv', NULL, NULL, '4eZv0S4CTU', NULL, '{NSV}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Jazz,Blues,Electro,Alternative}');
INSERT INTO streams VALUES (1023, 'rp5v0qY69r', 'application/ogg+vorbis', NULL, NULL, 'MP20mOmE27', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Radio,Music,Blues}');
INSERT INTO streams VALUES (1008, 'TyRVg5Tv6B', 'audio/mpeg', NULL, NULL, '5VL8e6SknY', NULL, '{MP3}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Trance}');
INSERT INTO streams VALUES (877, '0RaCSJ41wO', 'application/ogg+vorbis', NULL, NULL, 'kCZvkfZYzc', NULL, '{Vorbis}', 128, NULL, NULL, NULL, NULL, NULL, NULL, '{Pop,Jazz,Trance,Jazz}');


--
-- Name: streams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marcof
--

SELECT pg_catalog.setval('streams_id_seq', 1045, true);


--
-- Name: server_mounts_listenurl_key; Type: CONSTRAINT; Schema: public; Owner: marcof; Tablespace:
--

ALTER TABLE ONLY server_mounts
    ADD CONSTRAINT server_mounts_listenurl_key UNIQUE (listenurl);


--
-- Name: server_mounts_pkey; Type: CONSTRAINT; Schema: public; Owner: marcof; Tablespace:
--

ALTER TABLE ONLY server_mounts
    ADD CONSTRAINT server_mounts_pkey PRIMARY KEY (sid);


--
-- Name: streams_pkey; Type: CONSTRAINT; Schema: public; Owner: marcof; Tablespace:
--

ALTER TABLE ONLY streams
    ADD CONSTRAINT streams_pkey PRIMARY KEY (id);


--
-- Name: streams_stream_name_bitrate_codec_sub_types_key; Type: CONSTRAINT; Schema: public; Owner: marcof; Tablespace:
--

ALTER TABLE ONLY streams
    ADD CONSTRAINT streams_stream_name_bitrate_codec_sub_types_key UNIQUE (stream_name, bitrate, codec_sub_types);


--
-- Name: server_mounts_stream_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: marcof
--

ALTER TABLE ONLY server_mounts
    ADD CONSTRAINT server_mounts_stream_id_fkey FOREIGN KEY (stream_id) REFERENCES streams(id);


--
-- PostgreSQL database dump complete
--

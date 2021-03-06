-- Create VAST tables
CREATE SEQUENCE s_sid_seq;
CREATE TABLE schools (
	s_sid int not null default nextval('s_sid_seq'),
	s_sname varchar(128),
	primary key (s_sid)
);

CREATE SEQUENCE c_cid_seq;
CREATE TABLE courses (
	c_cid int not null default nextval('c_cid_seq'),
	c_name varchar(64) not null,
	c_semester varchar(8) not null,
	c_year int not null,
	c_instructor varchar(64),
	primary key (c_cid)
);

CREATE SEQUENCE a_ass_seq;
CREATE TABLE assignments (
	a_aid int not null default nextval('a_ass_seq'),
	a_aname varchar(128) not null,
	a_weight float not null default 1,
	a_score float,
	primary key (a_aid)
);

CREATE SEQUENCE user_uid_seq;
CREATE TABLE users (
	u_uid int not null default nextval('user_uid_seq'),
	u_name varchar(48),
	u_email varchar(64),
	u_password varchar(32),
	u_schoolid int not null,
	u_resetPW boolean not null default false,
	primary key (u_uid),
	foreign key (u_schoolid) REFERENCES schools (s_sid)
);

CREATE TABLE takes (
	t_uid int not null,
	t_cid int not null,
	t_grade char(2),
	foreign key (t_uid) REFERENCES users (u_uid),
	foreign key (t_cid) REFERENCES courses (c_cid)
);


CREATE TABLE homeworks (
	h_cid int not null,
	h_aid int not null,
	foreign key (h_cid) REFERENCES courses(c_cid),
	foreign key (h_aid) REFERENCES assignments(a_aid)
);

CREATE SEQUENCE g_grade_seq;
CREATE TABLE gradebook (
	g_gid int not null default nextval('g_grade_seq'),
	g_uid int not null,
	g_grade char(1) not null,
	g_creds float not null,
	g_scale float not null default 4,
	g_semester char(8) not null,
	g_year int not null,
	primary key (g_gid),
	foreign key (g_uid) REFERENCES users (u_uid)
);



-- Test Data:
INSERT INTO schools VALUES (default, 'UMASS Amherst');
insert into schools VALUES(default, 'University of Michigan');
insert into schools VALUES(default, 'MIT - Massachusetts Institute of Technology');
insert into schools VALUES(default, 'WPI - Worchester Polytechnic Institute');
insert into schools VALUES(default, 'Massasoit Community College');
INSERT INTO users VALUES (default, 'Tristan Warneke', 'twarneke@student.umass.edu', 'abc123', 1, default);
INSERT INTO users VALUES (default, 'Sean Avery', 'savery@student.umass.edu', 'abc123', 1, default);
INSERT INTO users VALUES (default, 'Anh Nguyen', '', 'abc123', 1, default);
Insert into courses values(default, 'CS383 AI', 'FALL', 2011, 'Barto, Andrew');
Insert into courses values(default, 'CS230 Systems', 'FALL', 2011, 'Richards, Timothy');
Insert into courses values(default, 'CS311 Algorithms', 'FALL', 2011, 'Siegelmann, Hava');

CREATE DATABASE RailwayManagement;

USE RailwayManagement;

IF NOT EXISTS (SELECT *
               FROM   sys.objects
               WHERE  object_id = Object_id(N'[dbo].[USER]')
                      AND type IN ( N'U' ))
BEGIN
	create table [USER](
		user_id int primary key,
		first_name varchar(50),
		last_name varchar(50),
		adhar_no varchar(20),
		gender char,
		age int,
		mobile_no varchar(50),
		email varchar(50),
		city varchar(50),
		state varchar(50),
		pincode varchar(20),
		_password varchar(50),
		security_ques varchar(50),
		security_ans varchar(50)
	);
END

IF NOT EXISTS (SELECT *
               FROM   sys.objects
               WHERE  object_id = Object_id(N'[dbo].[TRAIN]')
                      AND type IN ( N'U' ))
BEGIN
	create table TRAIN(
		train_no int primary key,
		train_name varchar(50),
		arrival_time time,
		departure_time time,
		availability_of_seats char,
		date date
	);
END

IF NOT EXISTS (SELECT *
               FROM   sys.objects
               WHERE  object_id = Object_id(N'[dbo].[STATION]')
                      AND type IN ( N'U' ))
BEGIN
	create table STATION(
		station_no int,
		name varchar(50),
		hault int,
		arrival_time time,
		train_no int,
		primary key(station_no, train_no),
		foreign key(train_no)
		references TRAIN(train_no)
	);
END

IF NOT EXISTS (SELECT *
               FROM   sys.objects
               WHERE  object_id = Object_id(N'[dbo].[TRAIN_STATUS]')
                      AND type IN ( N'U' ))
BEGIN
	create table TRAIN_STATUS(
		train_no int primary key,
		b_seats1 int,
		b_seats2 int,
		a_seats1 int,
		a_seats2 int,
		w_seats1 int,
		w_seats2 int,
		farel float,
		fare2 float
	);
END

IF NOT EXISTS (SELECT *
               FROM   sys.objects
               WHERE  object_id = Object_id(N'[dbo].[TICKET]')
                      AND type IN ( N'U' ))
BEGIN
	create table TICKET(
		id int primary key,
		user_id int,
		status char,
		no_of_passengers int,
		train_no int,
		foreign key(user_id) references [USER](user_id),
		foreign key(train_no) references TRAIN(train_no)
	);
END

IF NOT EXISTS (SELECT *
               FROM   sys.objects
               WHERE  object_id = Object_id(N'[dbo].[PASSENGER]')
                      AND type IN ( N'U' ))
BEGIN
	create table PASSENGER(
		passenger_id int primary key,
		pnr_no int,
		age int,
		gender char,
		user_id int,
		reservation_status char,
		seat_number varchar(5),
		name varchar(50),
		ticket_id int,
		foreign key(user_id) references [USER](user_id),
		foreign key(ticket_id) references TICKET(id)
	);	
END

IF NOT EXISTS (SELECT *
               FROM   sys.objects
               WHERE  object_id = Object_id(N'[dbo].[STARTS]')
                      AND type IN ( N'U' ))
BEGIN
	create table STARTS( 
		train_no int primary key,
		station_no int,
		foreign key(train_no) references TRAIN(train_no),
		foreign key(station_no) references STATION(no)
	);	
END

IF NOT EXISTS (SELECT *
               FROM   sys.objects
               WHERE  object_id = Object_id(N'[dbo].[STOPS_AT]')
                      AND type IN ( N'U' ))
BEGIN
	create table STOPS_AT( 
		train_no int,
		station_no int,
		foreign key(train_no) references TRAIN(train_no),
		foreign key(station_no) references STATION(station_no)
	);
END

IF NOT EXISTS (SELECT *
               FROM   sys.objects
               WHERE  object_id = Object_id(N'[dbo].[REACHES]')
                      AND type IN ( N'U' ))
BEGIN
	create table REACHES(
		train_no int,
		station_no int,
		time time,
		foreign key(train_no) references TRAIN(train_no),
		foreign key(station_no) references STATION(station_no)
	);	
END﻿

IF NOT EXISTS (SELECT *
               FROM   sys.objects
               WHERE  object_id = Object_id(N'[dbo].[BOOKS]')
                      AND type IN ( N'U' ))
BEGIN
	create table BOOKS( 
		user_id int,
		id int,
		foreign key(user_id) references [USER](user_id),
		foreign key(id) references TICKET(id)
	);	
END

IF NOT EXISTS (SELECT *
               FROM   sys.objects
               WHERE  object_id = Object_id(N'[dbo].[CANCEL]')
                      AND type IN ( N'U' ))
BEGIN
	create table CANCEL(
		user_id int,
		id int,
		passenger_id int,
		foreign key(id) references TICKET(id),
		foreign key(passenger_id) PASSENGER(passenger_id),
		foreign key(user_id) references references USER(user_id)
	);	
END



﻿


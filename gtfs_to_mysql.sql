--https://github.com/BlinkTagInc/gtfs-to-mysql/tree/master
USING mbta;

DROP TABLE IF EXISTS agency;

CREATE TABLE agency (
  agency_id integer PRIMARY KEY,
  agency_name VARCHAR(255),
  agency_url VARCHAR(255),
  agency_timezone VARCHAR(50),
  agency_phone VARCHAR(50)
);

DROP TABLE IF EXISTS calendar;

CREATE TABLE calendar (
  service_id INTEGER PRIMARY KEY,
  monday NUMERIC(1),
  tuesday NUMERIC(1),
  wednesday NUMERIC(1),
  thursday NUMERIC(1),
  friday NUMERIC(1),
  saturday NUMERIC(1),
  sunday NUMERIC(1),
  start_date VARCHAR(8),
  end_date VARCHAR(8)
);

DROP TABLE IF EXISTS calendar_dates;

CREATE TABLE calendar_dates (
  service_id NUMERIC(11),
  "date" VARCHAR(8),
  exception_type NUMERIC(2),
  KEY `service_id` (service_id),
  KEY `exception_type` (exception_type)
);

DROP TABLE IF EXISTS fare_attributes;

CREATE TABLE fare_attributes (
  fare_id NUMERIC(11) PRIMARY KEY,
  price DECIMAL(9,6),
  currency_type VARCHAR(8),
  payment_method NUMERIC(11),
  transfers NUMERIC(11)
);

DROP TABLE IF EXISTS fare_rules;

CREATE TABLE fare_rules (
  fare_id NUMERIC(11),
  route_id NUMERIC(11),
  KEY `fare_id` (fare_id),
  KEY `route_id` (route_id)
);


DROP TABLE IF EXISTS routes;

CREATE TABLE routes (
  route_id NUMERIC(11) PRIMARY KEY,
  route_short_name VARCHAR(50),
  route_long_name VARCHAR(255),
  route_type NUMERIC(2),
  KEY `route_type` (route_type)
);

DROP TABLE IF EXISTS shapes;

CREATE TABLE shapes (
  shape_id VARCHAR(50),
  shape_pt_lat DECIMAL(9,6),
  shape_pt_lon DECIMAL(9,6),
  shape_pt_sequence NUMERIC(11),
  KEY `shape_id` (shape_id)
);

DROP TABLE IF EXISTS stop_times;

CREATE TABLE stop_times (
  trip_id NUMERIC(11),
  arrival_time VARCHAR(8),
  departure_time VARCHAR(8),
  stop_id NUMERIC(11),
  stop_sequence NUMERIC(11),
  KEY `trip_id` (trip_id),
  KEY `stop_id` (stop_id),
  KEY `stop_sequence` (stop_sequence)
);

DROP TABLE IF EXISTS stops;

CREATE TABLE stops (
  stop_id NUMERIC(11) PRIMARY KEY,
  stop_name VARCHAR(255),
  stop_lat DECIMAL(9,6),
  stop_lon DECIMAL(9,6),
  KEY `stop_lat` (stop_lat),
  KEY `stop_lon` (stop_lon)
);

DROP TABLE IF EXISTS trips;

CREATE TABLE trips (
  route_id NUMERIC(11),
  service_id NUMERIC(11),
  trip_id NUMERIC(11) PRIMARY KEY,
  trip_headsign VARCHAR(255),
  direction_id NUMERIC(1),
  shape_id VARCHAR(50),
  KEY `route_id` (route_id),
  KEY `service_id` (service_id),
  KEY `direction_id` (direction_id),
  KEY `shape_id` (shape_id)
);

LOAD DATA LOCAL INFILE 'agency.txt' INTO TABLE agency FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'calendar.txt' INTO TABLE calendar FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'calendar_dates.txt' INTO TABLE calendar_dates FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'fare_attributes.txt' INTO TABLE fare_attributes FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'fare_rules.txt' INTO TABLE fare_rules FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'routes.txt' INTO TABLE routes FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'stop_times.txt' INTO TABLE stop_times FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'stops.txt' INTO TABLE stops FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'trips.txt' INTO TABLE trips FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;
CREATE TABLE IF NOT EXISTS carriers (
  `cid` VARCHAR(5) NOT NULL UNIQUE primary key,
  `name` VARCHAR(45) NULL
);
.mode csv 
.import "./data/carriers.csv" carriers


CREATE TABLE IF NOT EXISTS months (
  `mid` INT NOT NULL UNIQUE primary key,
  `month` VARCHAR(45) NULL
);
.mode csv 
.import "./data/months.csv" months

CREATE TABLE IF NOT EXISTS weekdays (
  `did` INT NOT NULL UNIQUE primary key,
  `day_of_week` VARCHAR(45) NULL
);
.mode csv 
.import "./data/weekdays.csv" weekdays


CREATE TABLE IF NOT EXISTS flights (
  `fid` INT NOT NULL UNIQUE primary key,
  `year` INT NULL,
  `month_id` INT NOT NULL,
  `day_of_month` INT NULL,
  `day_of_week_id` INT NOT NULL,
  `carrier_id` INT NOT NULL,
  `flight_num` INT NULL,
  `origin_city` VARCHAR(45) NULL,
  `origin_state` VARCHAR(45) NULL,
  `dest_city` VARCHAR(45) NULL,
  `dest_state` VARCHAR(45) NULL,
  `departure_delay` INT NULL,
  `taxi_out` INT NULL,
  `arrival_delay` INT NULL,
  `canceled` BINARY(1) NULL,
  `actual_time` INT NULL,
  `distance` INT NULL,
  FOREIGN KEY(carrier_id) REFERENCES carriers(cid),
  FOREIGN KEY(month_id) REFERENCES months(mid),
  FOREIGN KEY(day_of_week_id) REFERENCES weekdays(did)
);
.mode csv 
.import "./data/flights-small.csv" flights
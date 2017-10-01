/************* QUESTION 1 ************************/
select distinct fid from flights
    where origin_city like 'Seattle WA' and
          dest_city like 'Boston MA' and
          carrier_id like 'AS' and
          day_of_week_id = 1
/********************************************************/


/************* QUESTION 2 ************************/
CREATE  TEMPORARY TABLE flight_one AS
WITH F1 AS (
    select * from flights
    where origin_city like 'Seattle WA'
)
SELECT * FROM F1;

CREATE  TEMPORARY TABLE flight_two AS
WITH F2 AS (
    select * from flights
    where dest_city like 'Boston MA'
)
SELECT * FROM F2;

select 
    flight_one.carrier_id as FlightOneCarrier,
    flight_one.fid as FlightOneFID,
    flight_one.origin_city as FlightOneOrigin,
    flight_one.dest_city as FlightOneDestination,
    flight_one.actual_time as FlightOneFlightTime,
    flight_two.carrier_id as FlightTwoCarrier,
    flight_two.fid as FlightTwoFID,
    flight_two.origin_city as FlightTwoOrigin,
    flight_two.dest_city as FlightTwoDestination,
    flight_two.actual_time as FlightTwoFlightTime,
    flight_one.actual_time + flight_two.actual_time as TotalTime

from flight_one INNER JOIN flight_two on flight_one.dest_city=flight_two.origin_city
where flight_one.day_of_month = flight_two.day_of_month and
        flight_one.day_of_week_id = flight_two.day_of_week_id and
        flight_one.year = flight_two.year and
        flight_one.carrier_id = flight_two.carrier_id and
        (flight_one.actual_time + flight_two.actual_time)/60 < 7
/********************************************************/


/************* QUESTION 3 ************************/
select day_of_week 
    from weekdays 
    where did = (select day_of_week_id from 
                        (select max(avg), day_of_week_id FROM 
                            (select avg(arrival_delay) as avg, day_of_week_id from flights 
                                group by day_of_week_id)))
/********************************************************/


/************* QUESTION 4 ************************/
select distinct carrier_id
from (
        select count(*) as total, 
            carrier_id, 
            day_of_month, 
            day_of_week_id, 
            year
        from flights 
        group by day_of_week_id, 
                day_of_month, 
                year
     )
where total > 1000;
/********************************************************/


/************* QUESTION 5 ************************/
CREATE  TEMPORARY TABLE carriers_greater05 AS
WITH tmp1 AS (
    select * 
    from (
        select 
            sum(canceled)*1.0/count(*)*100 percent,
            carrier_id
        from flights 
        group by carrier_id
    ) where percent > 0.5
)
SELECT * FROM tmp1;

select 
    carriers.name,
    percent
from carriers_greater05 JOIN carriers 
                        on carriers_greater05.carrier_id = carriers.cid
order by percent 
/********************************************************/
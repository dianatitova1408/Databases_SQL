WITH total_seats AS (
           SELECT flight_id,
                  COUNT(seat_no) AS total
             FROM seats 
        LEFT JOIN Aircrafts AS air
            USING(aircraft_code)
        LEFT JOIN Flights AS fl
            USING(aircraft_code)
            GROUP BY flight_id
           
         )
    
         ,booked_seats AS (
           SELECT flights.flight_id,
                  (COUNT(seat_no)) AS booked
             FROM boarding_passes
        LEFT JOIN Flights 
            ON flights.flight_id = boarding_passes.flight_id
            GROUP BY flights.flight_id)


          , seats_flights AS(
          SELECT DISTINCT total_seats.flight_id,  ROUND(AVG(total-booked)) as free_seats
          FROM total_seats
        LEFT JOIN booked_seats
        ON total_seats.flight_id = booked_seats.flight_id  
        WHERE (total-booked) IS NOT NULL
        GROUP BY total_seats.flight_id)
        
        SELECT ROUND(AVG(free_seats)) AS averaged_free_seats
        FROM seats_flights
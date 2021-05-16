SELECT DISTINCT model,  AVG(DATE_PART('day',scheduled_arrival - scheduled_departure)*24 + DATE_PART('hour',scheduled_arrival - scheduled_departure)) AS travel_time 
            FROM flights
            LEFT JOIN Aircrafts 
            USING(aircraft_code)
            GROUP BY model
            ORDER BY travel_time DESC
            LIMIT 3
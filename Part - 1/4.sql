SELECT DISTINCT departure_airport,
        (AVG(amount)/(DATE_PART('day', scheduled_arrival - scheduled_departure) * 24  
        + DATE_PART('hour',scheduled_arrival - scheduled_departure)*60 + DATE_PART('MINUTE',scheduled_arrival - scheduled_departure)))  AS aver 
        FROM ticket_flights
        LEFT JOIN Flights 
        Using(flight_id)
        GROUP BY departure_airport, scheduled_arrival, scheduled_departure
        ORDER BY  aver DESC
        LIMIT 10
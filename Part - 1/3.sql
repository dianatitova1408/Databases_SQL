WITH sea AS(
            SELECT SUBSTRING(seat_no, 1, 2) AS seat_num, flights.flight_id, passenger_name
            FROM boarding_passes
            LEFT JOIN flights
            ON flights.flight_id = boarding_passes.flight_id
            LEFT JOIN tickets
            USING (ticket_no)
            WHERE SUBSTRING(seat_no, 2, 1) != 'A' AND SUBSTRING(seat_no, 2, 1) != 'B'
            AND SUBSTRING(seat_no, 2, 1) != 'C' AND SUBSTRING(seat_no, 2, 1) != 'D'
            AND SUBSTRING(seat_no, 2, 1) != 'E' AND SUBSTRING(seat_no, 2, 1) != 'F'
            AND SUBSTRING(seat_no, 2, 1) != 'G' AND SUBSTRING(seat_no, 2, 1) != 'H'
            AND SUBSTRING(seat_no, 2, 1) != 'I' AND SUBSTRING(seat_no, 2, 1) != 'G'
            AND SUBSTRING(seat_no, 2, 1) != 'K' AND SUBSTRING(seat_no, 2, 1) != 'H'
            AND SUBSTRING(seat_no, 3, 1) != 'B' AND SUBSTRING(seat_no, 3, 1) != 'E'
            GROUP BY flights.flight_id, passenger_name, seat_no)
            
            ,max AS(
            SELECT DISTINCT  MAX(seat_num) AS last_row, FLIGHT_ID
            FROM sea
            GROUP BY FLIGHT_ID)
            
            SELECT last_row, max.FLIGHT_ID, seat_no, passenger_name, DATE_PART('day',   actual_departure - scheduled_departure) * 24  + DATE_PART('hour', actual_departure - scheduled_departure)*60 +DATE_PART('minute', actual_departure - scheduled_departure) 
            + DATE_PART('day',actual_arrival- scheduled_arrival) * 24  + DATE_PART('hour',actual_arrival- scheduled_arrival)* 60 + DATE_PART('minute',actual_arrival- scheduled_arrival)   AS delay
            FROM max
            LEFT JOIN boarding_passes
            ON boarding_passes.flight_id = max.flight_id AND SUBSTRING(seat_no, 1, 2) = last_row
            LEFT JOIN tickets
            ON boarding_passes.ticket_no = tickets.ticket_no
            LEFT JOIN flights
            ON flights.flight_id = max.flight_id
            WHERE DATE_PART('day',   actual_departure - scheduled_departure) * 24  + DATE_PART('hour', actual_departure - scheduled_departure)*60 +DATE_PART('minute', actual_departure - scheduled_departure) 
            + DATE_PART('day',actual_arrival- scheduled_arrival) * 24  + DATE_PART('hour',actual_arrival- scheduled_arrival)* 60 + DATE_PART('minute',actual_arrival- scheduled_arrival) IS NOT NULL
            AND DATE_PART('day',   actual_departure - scheduled_departure) * 24  + DATE_PART('hour', actual_departure - scheduled_departure)*60 +DATE_PART('minute', actual_departure - scheduled_departure) 
            + DATE_PART('day',actual_arrival- scheduled_arrival) * 24  + DATE_PART('hour',actual_arrival- scheduled_arrival)* 60 + DATE_PART('minute',actual_arrival- scheduled_arrival) > 15
            ORDER BY delay DESC
# Part 1.
Analysis of airplane dataset: https://postgrespro.com/education/demodb 

Tasks for Part 1: 
1. Empty plane
How many seats on average are free on a flight?

2. Phileas Fogg
What are the top 3 aircrafts by average flight duration?

3. Losers
What are the names of the passengers who flew on the flight with the most delay (time between scheduled departure and actual departure plus time between scheduled arrival and actual arrival) sitting on the last row of the plane on the central seat (neither at the window nor near the corridor: it's often B or E)?

4. It's OK to be rich...
What are the top 10 airports by the average price of the flight ticket divided by flight duration?

# Part 2
Creation of database with followIng conditions.



Band

band_id (TEXT / UUID) — primary key
name (TEXT)
genre (TEXT)
Album

album_id (TEXT / UUID) — primary key
band_id - references Band.band_id
name (TEXT)
date_released (DATE / INTEGER)
Song

album_id — references Album.album_id
song_id (TEXT / UUID) — primary key
name (TEXT)
duration (INTEGER)
lyrics_author — references Musician.musician_id
music_author — references Musician.musician_id
Musician

musician_id (TEXT / UUID) — primary key
name (TEXT)
musician_band

musician_id — references Musician.musician_id
band_id — references Band.band_id
started_at (DATE / INTEGER)
finished_at (DATE / INTEGER)
instrument (TEXT)


**Restrictions should be following:**

If anyone deletes any band, all the corresponding data should be deleted with cascade method.
No one can delete any musician while there is at least one corresponding record exists in any other table.

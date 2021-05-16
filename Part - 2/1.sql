CREATE TABLE IF NOT EXISTS Band (
    band_id TEXT PRIMARY KEY,
    name TEXT,
    genre TEXT
    );
    
    CREATE TABLE IF NOT EXISTS Album(
    album_id TEXT  PRIMARY KEY,
    band_id  TEXT ,
    name_album TEXT,
    date_released INTEGER,
    FOREIGN KEY (band_id) REFERENCES Band (band_id)  ON DELETE CASCADE 
    );
    CREATE TABLE IF NOT EXISTS Musician(
     musician_id TEXT  PRIMARY KEY , 
     name TEXT
     );
    CREATE TABLE IF NOT EXISTS Song(
    song_id TEXT  PRIMARY KEY,
    album_id,
    name_song TEXT,
    duration INTEGER,
    lyrics_author,
    music_author,
    
    FOREIGN KEY (album_id) REFERENCES Album(album_id),
    FOREIGN KEY (lyrics_author) REFERENCES Musician(musician_id) ON DELETE RESTRICT,
    FOREIGN KEY (music_author) REFERENCES Musician(musician_id) ON DELETE RESTRICT
    );
    
    CREATE TABLE IF NOT EXISTS musician_band(
      musician_id, 
      band_id,
      started_at INTEGER ,
      finished_at INTEGER,
     instrument TEXT,
     FOREIGN KEY (musician_id) REFERENCES Musician(musician_id) ON DELETE RESTRICT,
     FOREIGN KEY (band_id) REFERENCES Band(band_id) ON DELETE CASCADE);
    
    INSERT INTO Band VALUES ('b_1', 'Gorillaz', 'Rock'),  ('b_2', 'My chemical Romance', 'Rock');
    INSERT INTO Album VALUES ('a_1', 'b_1', 'Demon Days',  2005),('a_2', 'b_2', 'Welcome to the black parade', 2005);
    INSERT INTO Musician VALUES ('m_1', 'Gorillaz'), ('m_2', 'My chemical Romance');
    INSERT INTO Song VALUES ( 's_1', 'a_1', 'November has come', 166, 'm_1', 'm_1'), ('s_2', 'a_2', 'Black Parade', 180, 'm_2', 'm_2');           
    INSERT INTO musician_band VALUES('m_1', 'b_1', 1998, 2040, 'guitar'), ('m_2', 'b_2', 2000, 2045, 'drums');
    
    
      SELECT * FROM  Band
      LEFT JOIN Album
      USING(band_id)
      LEFT JOIN Song
      USING(album_id)
      LEFT JOIN musician_band
      USING(band_id)
      LEFT JOIN musician
      USING(musician_id)
    
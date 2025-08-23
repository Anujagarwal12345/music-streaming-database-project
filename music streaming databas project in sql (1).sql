CREATE DATABASE music_streaming; 
USE music_streaming;
CREATE TABLE users(
user_id INT PRIMARY KEY,
user_name VARCHAR(50),
country VARCHAR(20)
);
SELECT * FROM users;
INSERT INTO users
(user_id,user_name,country)
VALUES
(101,'Bob','Austreliya'),
(102,'Tramp','U.K.'),
(103,'Baiden','U.S.A.'),
(104,'Rajveer','INDIA');
CREATE TABLE artists(
artist_id INT PRIMARY KEY,
artist_name VARCHAR(50),
genre VARCHAR(50)
);
INSERT INTO artists 
(artist_id, artist_name, genre)
VALUES 
(1, 'Arijit Singh', 'Romantic'),
(2, 'Neha Kakkar', 'Pop'),
(3, 'A.R. Rahman', 'Classical Fusion'),
(4, 'Badshah', 'Hip Hop');
SELECT * FROM artists;
CREATE TABLE albums(
album_id INT PRIMARY KEY,
album_name VARCHAR(50),
artist_id INT,
release_year INT,
FOREIGN KEY (artist_id) REFERENCES artists (artist_id)
);
INSERT INTO albums
(album_id,album_name,artist_id,release_year)
values
(1,'soulful_vibes',1,2020),
(2,'golden_hits',2,2018),
(3,'panjabi_beats',3,2021),
(4,'melody_queen',1,2015);
SELECT * FROM albums;
CREATE TABLE songs(
song_id INT PRIMARY KEY,
song_name VARCHAR(50),
album_id INT,
duration INT,
FOREIGN KEY (album_id) REFERENCES albums(album_id)
);
INSERT INTO songs
(song_id,song_name,album_id,duration)
VALUES
(1,'saiyaara',1,250),
(2,'water',3,320),
(3,'neele neele amber par',2,450),
(4,'paro',3,150);
SELECT*FROM songs;
CREATE TABLE listening_history(
history_id INT PRIMARY KEY,
user_id INT,
song_id INT,
listen_date DATE,
FOREIGN KEY (user_id) REFERENCES users(user_id),
FOREIGN KEY (song_id) REFERENCES songs(song_id)
);
CREATE TABLE listening_history(
history_id INT PRIMARY KEY,
user_id INT,
song_id INT,
listen_date DATE,
FOREIGN KEY (user_id) REFERENCES users(user_id),
FOREIGN KEY (song_id) REFERENCES songs(song_id)
);
INSERT INTO listening_history
(history_id,user_id,song_id,listen_date)
VALUES
(1,101,1,'2025-07-10'),
(2,102,2,'2025-05-15'),
(3,103,3,'2025-04-09'),
(4,104,4,'2025-03-08');
SELECT*FROM listening_history;
-- Most Played Songs
SELECT s.song_name, count(*) AS plays
FROM listening_history AS lh
JOIN songs AS s ON lh.song_id=s.song_id
GROUP BY song_name
ORDER BY plays DESC;  
-- Song Played by a Specific User
SELECT u.user_name,s.song_name,lh.listen_date
FROM listening_history AS lh
JOIN users AS u ON lh.user_id=u.user_id
JOIN songs AS s ON lh.song_id=s.song_id
WHERE u.user_name='rajveer';
-- Songs by Artist
SELECT artist_name,song_name
FROM songs AS s
JOIN albums AS a ON s.album_id=a.album_id
JOIN artists AS b ON a.artist_id=b.artist_id
WHERE b.artist_name='neha kakkar'; 
-- Listening Activity Par Day
SELECT listen_date, count(*) total_plays
FROM listening_history
GROUP BY listen_date
ORDER BY listen_date;
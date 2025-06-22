--Creating Database
CREATE DATABASE music_streaming_service

-- Drop foreign keys in the tracks table if they exist
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
           WHERE CONSTRAINT_NAME = 'FK_tracks_artist_id')
    ALTER TABLE dbo.tracks DROP CONSTRAINT FK_tracks_artist_id;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
           WHERE CONSTRAINT_NAME = 'FK_tracks_album_id')
    ALTER TABLE dbo.tracks DROP CONSTRAINT FK_tracks_album_id;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
           WHERE CONSTRAINT_NAME = 'FK_tracks_genre_id')
    ALTER TABLE dbo.tracks DROP CONSTRAINT FK_tracks_genre_id;

-- Drop foreign keys in the artists table if they exist
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
           WHERE CONSTRAINT_NAME = 'FK_artists_album_id')
    ALTER TABLE dbo.artists DROP CONSTRAINT FK_artists_album_id;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
           WHERE CONSTRAINT_NAME = 'FK_artists_track_id')
    ALTER TABLE dbo.artists DROP CONSTRAINT FK_artists_track_id;

-- Drop foreign keys in the albums table if they exist
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
           WHERE CONSTRAINT_NAME = 'FK_albums_artist_id')
    ALTER TABLE dbo.albums DROP CONSTRAINT FK_albums_artist_id;

-- Drop foreign keys in the sessions table if they exist
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
           WHERE CONSTRAINT_NAME = 'FK_sessions_user_id')
    ALTER TABLE dbo.sessions DROP CONSTRAINT FK_sessions_user_id;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
           WHERE CONSTRAINT_NAME = 'FK_sessions_track_id')
    ALTER TABLE dbo.sessions DROP CONSTRAINT FK_sessions_track_id;

-- Drop foreign keys in the tracks_genres table if they exist
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
           WHERE CONSTRAINT_NAME = 'FK_tracks_genres_track_id')
    ALTER TABLE dbo.tracks_genres DROP CONSTRAINT FK_tracks_genres_track_id;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
           WHERE CONSTRAINT_NAME = 'FK_tracks_genres_genre_id')
    ALTER TABLE dbo.tracks_genres DROP CONSTRAINT FK_tracks_genres_genre_id;

-- Drop foreign keys in the users_subscriptions table if they exist
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
           WHERE CONSTRAINT_NAME = 'FK_users_subscription_user_id')
    ALTER TABLE dbo.users_subscriptions DROP CONSTRAINT FK_users_subscription_user_id;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
           WHERE CONSTRAINT_NAME = 'FK_users_subscription_subscription_id')
    ALTER TABLE dbo.users_subscriptions DROP CONSTRAINT FK_users_subscription_subscription_id;

DROP TABLE IF EXISTS Albums, Artists, sessions, Users, Genres, tracks_genres, subscriptions, users_subscriptions, tracks;

-- Create Genres table
CREATE TABLE [dbo].[genres](
    [genre_id] [INT] NOT NULL,
    [genres_genre_name] VARCHAR(255) NOT NULL,
    [genres_description] VARCHAR(255) NULL,
    CONSTRAINT [PK_genres_genre_id] PRIMARY KEY ([genre_id]),
    CONSTRAINT [U_genres_genre_name] UNIQUE ([genres_genre_name])
);

-- Create Subscriptions table
CREATE TABLE [dbo].[subscriptions](
    [subscription_id] [INT] NOT NULL,
    [subscriptions_subscription_name] VARCHAR(255) NOT NULL,
    CONSTRAINT [PK_subscriptions_subscription_id] PRIMARY KEY ([subscription_id]),
    CONSTRAINT [U_subscriptions_subscription_name] UNIQUE ([subscriptions_subscription_name])
);

-- Create Users table
CREATE TABLE [dbo].[users](
    [user_id] [INT] NOT NULL,
    [users_first_name] VARCHAR(255) NOT NULL,
    [users_last_name] VARCHAR(255) NOT NULL,
    [users_user_name] VARCHAR(50) UNIQUE NOT NULL,
    [users_user_email] VARCHAR(255) UNIQUE NOT NULL,
    [users_password] VARCHAR(255) NOT NULL,
    [users_date_of_birth] [DATE] NOT NULL,
    [users_state] VARCHAR(50) NOT NULL,
    [users_subscription_type] VARCHAR(50) NOT NULL,
    CONSTRAINT [PK_users_user_id] PRIMARY KEY ([user_id]),
    CONSTRAINT [U_users_user_name] UNIQUE ([users_user_name]),
    CONSTRAINT [U_users_user_email] UNIQUE ([users_user_email])
);

-- Create Artists table
CREATE TABLE [dbo].[artists](
    [artist_id] [INT] NOT NULL,
    [artists_artist_name] VARCHAR(255) NOT NULL,
    [artists_first_name] VARCHAR(255) NOT NULL,
    [artists_last_name] VARCHAR(255) NOT NULL,
    [artists_country] VARCHAR (50) NULL,
    CONSTRAINT [PK_artists_artist_id] PRIMARY KEY ([artist_id]),
    CONSTRAINT [U_artists_artist_name] UNIQUE ([artists_artist_name])
);


-- Create Albums table
CREATE TABLE [dbo].[albums](
    [album_id] [INT] NOT NULL,
    [albums_title] VARCHAR(255) NOT NULL,
    [albums_release_date] [DATE] NULL,
    [albums_artist_id] [INT] NOT NULL,
    CONSTRAINT [PK_albums_album_id] PRIMARY KEY ([album_id])
);


-- Create Tracks Table
CREATE TABLE [dbo].[tracks](
    [track_id] [INT] NOT NULL,
    [tracks_album_id] [INT] NOT NULL,
    [tracks_genre_id] [INT] NOT NULL,
    [tracks_artist_id] [INT] NOT NULL,
    [tracks_title] VARCHAR(255) NOT NULL,
    [tracks_duration] [INT] NULL,
    [tracks_release_date] [DATE] NULL,
    [tracks_genre] VARCHAR(50) NOT NULL,
    [tracks_language] VARCHAR(50) NOT NULL,
    CONSTRAINT [PK_tracks_track_id] PRIMARY KEY ([track_id])
);

-- Create Sessions Table
CREATE TABLE [dbo].[sessions](
    [session_id] [INT] NOT NULL,
    [sessions_user_id] [INT] NOT NULL,
    [sessions_track_id] [INT] NOT NULL,
    [sessions_start_timestamp] [DATETIME] NOT NULL,
    [sessions_end_timestamp] [DATETIME] NOT NULL,
    CONSTRAINT [PK_sessions_session_id] PRIMARY KEY ([session_id])
);

 
CREATE TABLE [dbo].[tracks_genres](
    tracks_genres_genre_id [INT] NOT NULL,
    tracks_genres_track_id [INT] NOT NULL
);

 
CREATE TABLE [dbo].[users_subscriptions](
    users_subscription_user_id [INT] NOT NULL,
    users_subscription_subscription_id [INT] NOT NULL,
);

-- Add foreign key constraints to tracks_genres table

ALTER TABLE [dbo].[tracks_genres]
    ADD CONSTRAINT [FK_tracks_genres_track_id] FOREIGN KEY ([tracks_genres_track_id]) REFERENCES [dbo].[tracks]([track_id]);

ALTER TABLE [dbo].[tracks_genres]
    ADD CONSTRAINT [FK_tracks_genres_genre_id] FOREIGN KEY ([tracks_genres_genre_id]) REFERENCES [dbo].[genres]([genre_id]);

-- Add foreign key constraints to Users_Subscriptions table
ALTER TABLE [dbo].[users_subscriptions]
    ADD CONSTRAINT [FK_users_subscription_user_id] FOREIGN KEY ([users_subscription_user_id]) REFERENCES [dbo].[users]([user_id]);

ALTER TABLE [dbo].[users_subscriptions]
    ADD CONSTRAINT [FK_users_subscription_subscription_id] FOREIGN KEY ([users_subscription_subscription_id]) REFERENCES [dbo].[subscriptions]([subscription_id]);

-- Add foreign key constraints to Sessions table
ALTER TABLE [dbo].[sessions]
    ADD CONSTRAINT [FK_sessions_user_id] FOREIGN KEY ([sessions_user_id]) REFERENCES [dbo].[users]([user_id]);

ALTER TABLE [dbo].[sessions]
    ADD CONSTRAINT [FK_sessions_track_id] FOREIGN KEY ([sessions_track_id]) REFERENCES [dbo].[tracks]([track_id]);
 
-- Add foreign key constraints to tracks table
ALTER TABLE [dbo].[tracks]
    ADD CONSTRAINT [FK_tracks_artist_id] FOREIGN KEY ([tracks_artist_id]) REFERENCES [dbo].[artists]([artist_id]);

ALTER TABLE [dbo].[tracks]
    ADD CONSTRAINT [FK_tracks_album_id] FOREIGN KEY ([tracks_album_id]) REFERENCES [dbo].[albums]([album_id]);

ALTER TABLE [dbo].[tracks]
    ADD CONSTRAINT [FK_tracks_genre_id] FOREIGN KEY ([tracks_genre_id]) REFERENCES [dbo].[genres]([genre_id]);

-- Add foreign key constraint to albums table
 ALTER TABLE [dbo].[albums]
    ADD CONSTRAINT [FK_albums_artist_id] FOREIGN KEY ([albums_artist_id]) REFERENCES [dbo].[artists]([artist_id]);


-- Insert data into genres table
INSERT INTO dbo.genres (genre_id, genres_genre_name, genres_description)
VALUES 
  (1, 'Rock', 'Rock music genre'),
  (2, 'Pop', 'Popular music genre'),
  (3, 'Hip Hop', 'Hip Hop music genre'),
  (4, 'Electronic', 'Electronic music genre'),
  (5, 'Jazz', 'Jazz music genre'),
  (6, 'Country', 'Country music genre'),
  (7, 'R&B', 'Rhythm and Blues music genre'),
  (8, 'Classical', 'Classical music genre'),
  (9, 'Metal', 'Metal music genre'),
  (10, 'Alternative', 'Alternative music genre'),
  (11, 'Reggae', 'Reggae music genre'),
  (12, 'Blues', 'Blues music genre'),
  (13, 'Funk', 'Funk music genre'),
  (14, 'Indie', 'Indie music genre'),
  (15, 'Soul', 'Soul music genre'),
  (16, 'Latin', 'Latin music genre'),
  (17, 'Punk', 'Punk music genre'),
  (18, 'World', 'World music genre'),
  (19, 'Gospel', 'Gospel music genre'),
  (20, 'Disco', 'Disco music genre'), 
  (21, 'Folk', 'Folk music genre'),
  (22, 'Ambient', 'Ambient music genre'),
  (23, 'Trap', 'Trap music genre'),
  (24, 'Ska', 'Ska music genre'),
  (25, 'Electronic Dance Music (EDM)', 'EDM music genre'),
  (26, 'Techno', 'Techno music genre'),
  (27, 'Acoustic', 'Acoustic music genre'),
  (28, 'House', 'House music genre'),
  (29, 'Chillout', 'Chillout music genre'),
  (30, 'Grime', 'Grime music genre'),
  (31, 'Dancehall', 'Dancehall music genre'),
  (32, 'Hard Rock', 'Hard Rock music genre'),
  (33, 'Ambient House', 'Ambient House music genre'),
  (34, 'Trance', 'Trance music genre'),
  (35, 'Country Rock', 'Country Rock music genre'),
  (36, 'Psychedelic', 'Psychedelic music genre'),
  (37, 'Salsa', 'Salsa music genre'),
  (38, 'Jungle', 'Jungle music genre'),
  (39, 'Grunge', 'Grunge music genre'),
  (40, 'Electropop', 'Electropop music genre');

-- Insert data into subscriptions table
INSERT INTO dbo.subscriptions (subscription_id, subscriptions_subscription_name)
VALUES 
  (1, 'Basic'),
  (2, 'Premium'),
  (3, 'Student'),
  (4, 'Family');


-- Insert data into users table
INSERT INTO dbo.users (user_id, users_first_name, users_last_name, users_user_name, users_user_email, users_password, users_date_of_birth, users_state, users_subscription_type)
VALUES 
(1, 'John', 'Doe', 'johndoe', 'john.doe@email.com', 'password123', '1990-01-01', 'California', 'Premium'),
(2, 'Jane', 'Smith', 'janesmith', 'jane.smith@email.com', 'password456', '1985-05-15', 'New York', 'Free'),
(3, 'Bob', 'Johnson', 'bobjohn', 'bob.john@email.com', 'password789', '1988-08-20', 'Texas', 'Family'),
(4, 'Alice', 'Davis', 'alicedavis', 'alice.davis@email.com', 'password987', '1992-03-10', 'Florida', 'Student'),
(5, 'Charlie', 'Brown', 'charliebrown', 'charlie.brown@email.com', 'password654', '1982-12-05', 'Ohio', 'Basic'),
(6, 'Emma', 'Wilson', 'emmawilson', 'emma.wilson@email.com', 'password321', '1995-06-28', 'Illinois', 'Premium'),
(7, 'David', 'White', 'davidwhite', 'david.white@email.com', 'password789', '1983-09-15', 'Michigan', 'Premium'),
(8, 'Olivia', 'Johnson', 'oliviajohnson', 'olivia.johnson@email.com', 'password567', '1991-11-03', 'Georgia', 'Basic'),
(9, 'Michael', 'Anderson', 'michaelanderson', 'michael.anderson@email.com', 'password234', '1986-04-17', 'Arizona', 'Basic'),
(10, 'Sophia', 'Lee', 'sophialee', 'sophia.lee@email.com', 'password876', '1989-07-22', 'Colorado', 'Premium'),
(11, 'Ethan', 'Harris', 'ethanharris', 'ethan.harris@email.com', 'password543', '1993-02-08', 'Washington', 'Basic'),
(12, 'Ava', 'Martinez', 'avamartinez', 'ava.martinez@email.com', 'password210', '1984-10-12', 'Oregon', 'Basic'),
(13, 'William', 'Garcia', 'williamgarcia', 'william.garcia@email.com', 'password789', '1994-08-05', 'Virginia', 'Basic'),
(14, 'Mia', 'Taylor', 'miataylor', 'mia.taylor@email.com', 'password876', '1987-06-19', 'Texas', 'Family'),
(15, 'James', 'Hernandez', 'jameshernandez', 'james.hernandez@email.com', 'password432', '1996-09-30', 'New Jersey', 'Premium'),
(16, 'Abigail', 'Lopez', 'abigaillopez', 'abigail.lopez@email.com', 'password109', '1981-03-25', 'California', 'Basic'),
(17, 'Benjamin', 'Adams', 'benjaminadams', 'benjamin.adams@email.com', 'password876', '1997-05-08', 'Florida', 'Premium'),
(18, 'Grace', 'Scott', 'gracescott', 'grace.scott@email.com', 'password543', '1980-12-18', 'Ohio', 'Family'),
(19, 'Daniel', 'Perez', 'danielperez', 'daniel.perez@email.com', 'password210', '1984-02-14', 'Georgia', 'Premium'),
(20, 'Lily', 'Rodriguez', 'lilyrodriguez', 'lily.rodriguez@email.com', 'password987', '1998-07-07', 'Illinois', 'Basic'),
(21, 'Alice', 'Johnson', 'alice.john', 'alice.john@email.com', 'pass789', '1992-06-25', 'Florida', 'Family'),
(22, 'Bob', 'Anderson', 'bob.and', 'bob.and@email.com', 'userpass321', '1987-09-10', 'California', 'Premium'),
(23, 'Catherine', 'Smith', 'cath.smith', 'cath.smith@email.com', 'securepass456', '1994-03-15', 'New York', 'Student'),
(24, 'David', 'Brown', 'david.brown', 'david.brown@email.com', 'passuser789', '1989-12-05', 'Texas', 'Basic'),
(25, 'Eva', 'Wilson', 'eva.wil', 'eva.wil@email.com', 'mypassword123', '1996-02-20', 'Illinois', 'Basic'),
(26, 'Frank', 'Taylor', 'frank.tay', 'frank.tay@email.com', 'userpass789', '1983-08-30', 'Ohio', 'Premium'),
(27, 'Grace', 'Harris', 'grace.har', 'grace.har@email.com', 'passuser456', '1991-11-05', 'Georgia', 'Student'),
(28, 'Henry', 'Clark', 'henry.clark', 'henry.clark@email.com', 'securepass789', '1986-04-10', 'Michigan', 'Basic'),
(29, 'Ivy', 'Roberts', 'ivy.rob', 'ivy.rob@email.com', 'pass789user', '1995-07-25', 'North Carolina', 'Family'),
(30, 'Jack', 'Davis', 'jack.dav', 'jack.dav@email.com', 'userpass1234', '1982-10-15', 'Arizona', 'Premium'),
(31, 'Kelly', 'Johnson', 'kelly.john', 'kelly.john@email.com', 'securepass789', '1993-04-28', 'Texas', 'Student'),
(32, 'Leo', 'Hill', 'leo.hill', 'leo.hill@email.com', 'passuser789', '1988-01-05', 'Florida', 'Family'),
(33, 'Mia', 'Baker', 'mia.bak', 'mia.bak@email.com', 'pass123user', '1990-03-20', 'California', 'Basic'),
(34, 'Nathan', 'Carter', 'nathan.cart', 'nathan.cart@email.com', 'securepass789', '1997-06-12', 'New York', 'Premium'),
(35, 'Olivia', 'Fisher', 'olivia.fish', 'olivia.fish@email.com', 'userpass1234', '1984-09-25', 'Texas', 'Family'),
(36, 'Paul', 'Evans', 'paul.eva', 'paul.eva@email.com', 'passuser789', '1996-12-08', 'Illinois', 'Student'),
(37, 'Quincy', 'Adams', 'quincy.adams', 'quincy.adams@email.com', 'securepass789', '1994-02-15', 'Ohio', 'Basic'),
(38, 'Rachel', 'Turner', 'rachel.turn', 'rachel.turn@email.com', 'pass789user', '1989-05-30', 'Georgia', 'Family'),
(39, 'Samuel', 'Wright', 'sam.wri', 'sam.wri@email.com', 'userpass1234', '1991-08-18', 'Michigan', 'Premium'),
(40, 'Tina', 'Mills', 'tina.mil', 'tina.mil@email.com', 'securepass789', '1986-11-05', 'North Carolina', 'Basic'),
(41, 'Ulysses', 'Grant', 'ulysses.grant', 'ulysses.grant@email.com', 'passuser789', '1997-03-20', 'Arizona', 'Basic'),
(42, 'Violet', 'Perez', 'violet.per', 'violet.per@email.com', 'pass123user', '1988-06-12', 'Florida', 'Student'),
(43, 'William', 'Cooper', 'william.coo', 'william.coo@email.com', 'securepass789', '1993-09-25', 'California', 'Family'),
(44, 'Xander', 'Henderson', 'xander.hen', 'xander.hen@email.com', 'userpass1234', '1984-12-08', 'Texas', 'Premium'),
(45, 'Yasmine', 'Lopez', 'yasmine.lop', 'yasmine.lop@email.com', 'securepass789', '1996-02-15', 'Illinois', 'Basic'),
(46, 'Zachary', 'Rogers', 'zachary.rog', 'zachary.rog@email.com', 'passuser789', '1991-05-30', 'Ohio', 'Student'),
(47, 'Amy', 'Barnes', 'amy.bar', 'amy.bar@email.com', 'userpass1234', '1987-08-18', 'Georgia', 'Basic'),
(48, 'Benjamin', 'Cruz', 'benjamin.cru', 'benjamin.cru@email.com', 'securepass789', '1994-11-05', 'Michigan', 'Premium'),
(49, 'Cynthia', 'Dean', 'cynthia.dean', 'cynthia.dean@email.com', 'passuser123', '1985-02-20', 'North Carolina', 'Family'),
(50, 'Derek', 'Fletcher', 'derek.flet', 'derek.flet@email.com', 'pass789user', '1992-07-12', 'Arizona', 'Student');

-- Insert data into artists table
INSERT INTO dbo.artists (artist_id, artists_artist_name, artists_first_name, artists_last_name, artists_country)
VALUES 
  (51, 'Coldplay', 'Chris', 'Martin', 'UK'),
  (52, 'Lady Gaga', 'Stefani', 'Germanotta', 'USA'),
  (53, 'Foo Fighters', 'Dave', 'Grohl', 'USA'),
  (54, 'Ariana Grande', 'Ariana', 'Grande', 'USA'),
  (55, 'The Weeknd', 'Abel', 'Tesfaye', 'Canada'),
  (56, 'Adele', 'Adele', 'Adkins', 'UK'),
  (57, 'Bruno Mars', 'Bruno', 'Mars', 'USA'),
  (58, 'Sia', 'Sia', 'Furler', 'Australia'),
  (59, 'The Beatles', 'John', 'Lennon', 'UK'),
  (60, 'Kanye West', 'Kanye', 'West', 'USA'),
  (61, 'Rihanna', 'Rihanna', 'Fenty', 'Barbados'),
  (62, 'Eagles', 'Don', 'Henley', 'USA'),
  (63, 'Sam Smith', 'Sam', 'Smith', 'UK'),
  (64, 'Justin Bieber', 'Justin', 'Bieber', 'Canada'),
  (65, 'Aerosmith', 'Steven', 'Tyler', 'USA'),
  (66, 'Billie Eilish', 'Billie', 'Eilish', 'USA'),
  (67, 'John Legend', 'John', 'Legend', 'USA'),
  (68, 'Shawn Mendes', 'Shawn', 'Mendes', 'Canada'),
  (69, 'Eminem', 'Marshall', 'Mathers', 'USA'),
  (70, 'Dua Lipa', 'Dua', 'Lipa', 'UK'),
  (71, 'Alicia Keys', 'Alicia', 'Keys', 'USA'),
  (72, 'Cardi B', 'Cardi', 'B', 'USA'),
  (73, 'The Rolling Stones', 'Mick', 'Jagger', 'UK'),
  (74, 'Drake', 'Aubrey', 'Graham', 'Canada'),
  (75, 'Post Malone', 'Post', 'Malone', 'USA'),
  (76, 'Fleetwood Mac', 'Stevie', 'Nicks', 'UK'),
  (77, 'Elvis Presley', 'Elvis', 'Presley', 'USA'),
  (78, 'Taylor Swift', 'Taylor', 'Swift', 'USA'),
  (79, 'Ed Sheeran', 'Ed', 'Sheeran', 'UK'),
  (80, 'Metallica', 'James', 'Hetfield', 'USA'),
  (81, 'BTS', 'RM', 'Kim', 'South Korea'),
  (82, 'Shakira', 'Shakira', 'Ripoll', 'Colombia'),
  (83, 'Whitney Houston', 'Whitney', 'Houston', 'USA'),
  (84, 'Bob Marley', 'Bob', 'Marley', 'Jamaica'),
  (85, 'Madonna', 'Madonna', 'Ciccone', 'USA'),
  (86, 'Linkin Park', 'Chester', 'Bennington', 'USA'),
  (87, 'Queen', 'Freddie', 'Mercury', 'UK'),
  (88, 'Beyoncé', 'Beyoncé', 'Knowles', 'USA'),
  (89, 'Guns N Roses', 'Axl', 'Rose', 'USA'),
  (90, 'U2', 'Bono', 'Hewson', 'Ireland');

-- Insert data into albums table
INSERT INTO dbo.albums (album_id, albums_title, albums_release_date, albums_artist_id)
VALUES 
  (51, 'A Head Full of Dreams', '2015-12-04', 51),
  (52, 'The Fame', '2008-08-19', 52),
  (53, 'Concrete and Gold', '2017-09-15', 53),
  (54, 'Dangerous Woman', '2016-05-20', 54),
  (55, 'After Hours', '2020-03-20', 55),
  (56, '25', '2015-11-20', 56),
  (57, '24K Magic', '2016-11-18', 57),
  (58, '1000 Forms of Fear', '2014-07-04', 58),
  (59, 'Abbey Road', '1969-09-26', 59),
  (60, 'My Beautiful Dark Twisted Fantasy', '2010-11-22', 60),
  (61, 'Anti', '2016-01-28', 61),
  (62, 'Hotel California', '1976-12-08', 62),
  (63, 'In the Lonely Hour', '2014-05-26', 63),
  (64, 'Purpose', '2015-11-13', 64),
  (65, 'Toys in the Attic', '1975-04-08', 65),
  (66, 'When We All Fall Asleep, Where Do We Go?', '2019-03-29', 66),
  (67, 'Get Lifted', '2004-11-30', 67),
  (68, 'Illuminate', '2016-09-23', 68),
  (69, 'The Marshall Mathers LP', '2000-05-23', 69),
  (70, 'Future Nostalgia', '2020-03-27', 70),
  (71, 'Songs in A Minor', '2001-06-05', 71),
  (72, 'Invasion of Privacy', '2018-04-05', 72),
  (73, 'Sticky Fingers', '1971-04-23', 73),
  (74, 'Scorpion', '2018-06-29', 74),
  (75, 'Hollywoods Bleeding', '2019-09-06', 75),
  (76, 'Rumours', '1977-02-04', 76),
  (77, 'Elvis Presley', '1956-03-23', 77),
  (78, '1989', '2014-10-27', 78),
  (79, '÷', '2017-03-03', 79),
  (80, 'Metallica', '1991-08-12', 80),
  (81, 'Map of the Soul: 7', '2020-02-21', 81),
  (82, 'El Dorado', '2017-05-26', 82),
  (83, 'Whitney Houston', '1985-02-14', 83),
  (84, 'Legend', '1984-05-08', 84),
  (85, 'Like a Virgin', '1984-11-12', 85),
  (86, 'Meteora', '2003-03-25', 86),
  (87, 'A Night at the Opera', '1975-11-21', 87),
  (88, 'Lemonade', '2016-04-23', 88),
  (89, 'Appetite for Destruction', '1987-07-21', 89),
  (90, 'The Joshua Tree', '1987-03-09', 90);

-- Insert data into Tracks table
INSERT INTO dbo.tracks (track_id, tracks_album_id, tracks_genre_id, tracks_artist_id, tracks_title, tracks_duration, tracks_release_date, tracks_genre, tracks_language)
VALUES
  (1, 51, 1, 51, 'Adventure of a Lifetime', 255, '2015-11-06', 'Pop', 'English'),
  (2, 52, 2, 52, 'Just Dance', 242, '2008-04-08', 'Pop', 'English'),
  (3, 53, 3, 53, 'The Pretender', 269, '2007-09-17', 'Rock', 'English'),
  (4, 54, 4, 54, 'Into You', 244, '2016-05-06', 'Pop', 'English'),
  (5, 55, 5, 55, 'Blinding Lights', 200, '2019-11-29', 'R&B', 'English'),
  (6, 56, 6, 56, 'Hello', 295, '2015-10-23', 'Pop', 'English'),
  (7, 57, 7, 57, '24K Magic', 225, '2016-10-07', 'Pop', 'English'),
  (8, 58, 8, 58, 'Chandelier', 216, '2014-03-17', 'Pop', 'English'),
  (9, 59, 9, 59, 'Come Together', 260, '1969-09-26', 'Rock', 'English'),
  (10, 60, 10, 60, 'Power', 334, '2010-11-22', 'Hip-Hop', 'English'),
  (11, 61, 11, 61, 'Needed Me', 193, '2016-03-30', 'R&B', 'English'),
  (12, 62, 12, 62, 'Hotel California', 391, '1976-12-08', 'Rock', 'English'),
  (13, 63, 13, 63, 'Stay with Me', 172, '2014-04-14', 'Pop', 'English'),
  (14, 64, 14, 64, 'Sorry', 200, '2015-10-23', 'Pop', 'English'),
  (15, 65, 15, 65, 'Dream On', 266, '1973-06-27', 'Rock', 'English'),
  (16, 66, 16, 66, 'Bad Guy', 194, '2019-03-29', 'Pop', 'English'),
  (17, 67, 17, 67, 'Ordinary People', 239, '2004-12-28', 'R&B', 'English'),
  (18, 68, 18, 68, 'Treat You Better', 187, '2016-06-03', 'Pop', 'English'),
  (19, 69, 19, 69, 'The Real Slim Shady', 284, '2000-05-16', 'Hip-Hop', 'English'),
  (20, 70, 20, 70, 'Levitating', 203, '2020-03-27', 'Pop', 'English'),
  (21, 71, 21, 71, 'Fallin', 229, '2001-04-02', 'R&B', 'English'),
  (22, 72, 22, 72, 'Bodak Yellow', 224, '2017-06-16', 'Hip-Hop', 'English'),
  (23, 73, 23, 73, 'Brown Sugar', 216, '1971-04-23', 'Rock', 'English'),
  (24, 74, 24, 74, 'In My Feelings', 217, '2018-07-10', 'Hip-Hop', 'English'),
  (25, 75, 25, 75, 'Circles', 215, '2019-08-30', 'Pop', 'English'),
  (26, 76, 26, 76, 'Go Your Own Way', 222, '1977-02-04', 'Rock', 'English'),
  (27, 77, 27, 77, 'Hound Dog', 136, '1956-06-05', 'Rock', 'English'),
  (28, 78, 28, 78, 'Shake It Off', 219, '2014-08-18', 'Pop', 'English'),
  (29, 79, 29, 79, 'Shape of You', 234, '2017-01-06', 'Pop', 'English'),
 (30, 80, 30, 80, 'Lucy in the Sky with Diamonds', 207, '1967-06-01', 'Rock', 'English'),
  (31, 81, 31, 81, 'Stay', 189, '2012-12-03', 'Pop', 'English'),
  (32, 82, 32, 82, 'Every Breath You Take', 243, '1983-05-20', 'Pop', 'English'),
  (33, 83, 33, 83, 'Superstition', 263, '1972-10-24', 'R&B', 'English'),
  (34, 84, 34, 84, 'Back in Black', 258, '1980-07-25', 'Rock', 'English'),
  (35, 85, 35, 85, 'Take Me to Church', 241, '2013-09-16', 'Rock', 'English'),
  (36, 86, 36, 86, 'I Will Always Love You', 273, '1992-11-03', 'R&B', 'English'),
  (37, 87, 37, 87, 'Bohemian Rhapsody', 354, '1975-10-31', 'Rock', 'English'),
  (38, 88, 38, 88, 'Blackbird', 178, '1968-11-22', 'Rock', 'English'),
  (39, 89, 39, 89, 'Crazy', 216, '2006-05-20', 'R&B', 'English'),
  (40, 90, 40, 90, 'Bad Romance', 294, '2009-10-26', 'Pop', 'English');

-- Insert data into Tracks_Genres table
INSERT INTO dbo.tracks_genres (tracks_genres_genre_id, tracks_genres_track_id)
VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5),
  (6, 6),
  (7, 7),
  (8, 8),
  (9, 9),
  (10, 10),
  (11, 11),
  (12, 12),
  (13, 13),
  (14, 14),
  (15, 15),
  (16, 16),
  (17, 17),
  (18, 18),
  (19, 19),
  (20, 20),
  (21, 21),
  (22, 22),
  (23, 23),
  (24, 24),
  (25, 25),
  (26, 26),
  (27, 27),
  (28, 28),
  (29, 29),
  (30, 30),
  (31, 1),
  (32, 2),
  (33, 3),
  (34, 4),
  (35, 5),
  (36, 6),
  (37, 7),
  (38, 8),
  (39, 9),
  (40, 10);

-- Insert data into User_Subscriptions table
INSERT INTO dbo.users_subscriptions(users_subscription_user_id, users_subscription_subscription_id)
VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 1),
  (6, 2),
  (7, 3),
  (8, 4),
  (9, 1),
  (10, 2),
  (11, 3),
  (12, 4),
  (13, 1),
  (14, 2),
  (15, 3),
  (16, 4),
  (17, 1),
  (18, 2),
  (19, 3),
  (20, 4),
  (21, 1),
  (22, 2),
  (23, 3),
  (24, 4),
  (25, 1),
  (26, 2),
  (27, 3),
  (28, 4),
  (29, 1),
  (30, 2),
  (31, 3),
  (32, 4),
  (33, 1),
  (34, 2),
  (35, 3),
  (36, 4),
  (37, 1),
  (38, 2),
  (39, 3),
  (40, 4),
  (41, 1),
  (42, 2),
  (43, 3),
  (44, 4),
  (45, 1),
  (46, 2),
  (47, 3),
  (48, 4),
  (49, 1),
  (50, 2);

-- Insert data into Sessions table
INSERT INTO dbo.sessions (session_id, sessions_user_id, sessions_track_id, sessions_start_timestamp, sessions_end_timestamp)
VALUES
(1,45,35,'2023-11-01 00:23:45','2023-11-01 00:28:45'),
(2,47,34,'2023-11-01 03:06:53','2023-11-01 03:11:53'),
(3,13,6,'2023-11-01 05:44:16','2023-11-01 05:49:16'),
(4,15,2,'2023-11-01 09:24:33','2023-11-01 09:26:33'),
(5,15,13,'2023-11-01 09:48:56','2023-11-01 09:53:56'),
(6,21,30,'2023-11-01 09:51:54','2023-11-01 09:53:54'),
(7,37,33,'2023-11-01 13:34:31','2023-11-01 13:36:31'),
(8,49,36,'2023-11-01 14:10:57','2023-11-01 14:13:57'),
(9,40,4,'2023-11-01 18:33:19','2023-11-01 18:36:19'),
(10,28,37,'2023-11-01 19:15:16','2023-11-01 19:19:16'),
(11,22,38,'2023-11-01 19:28:13','2023-11-01 19:30:13'),
(12,19,39,'2023-11-01 21:18:40','2023-11-01 21:20:40'),
(13,24,35,'2023-11-01 21:44:30','2023-11-01 21:47:30'),
(14,19,21,'2023-11-02 00:51:37','2023-11-02 00:52:37'),
(15,41,25,'2023-11-02 01:22:42','2023-11-02 01:27:42'),
(16,24,32,'2023-11-02 02:07:05','2023-11-02 02:11:05'),
(17,9,23,'2023-11-02 05:51:04','2023-11-02 05:56:04'),
(18,23,21,'2023-11-02 07:13:34','2023-11-02 07:17:34'),
(19,1,3,'2023-11-02 09:29:07','2023-11-02 09:32:07'),
(20,22,33,'2023-11-02 11:50:52','2023-11-02 11:52:52'),
(21,25,29,'2023-11-02 12:27:27','2023-11-02 12:32:27'),
(22,28,7,'2023-11-02 13:23:17','2023-11-02 13:26:17'),
(23,12,10,'2023-11-02 13:23:55','2023-11-02 13:26:55'),
(24,26,10,'2023-11-02 16:18:25','2023-11-02 16:22:25'),
(25,12,25,'2023-11-02 17:19:28','2023-11-02 17:22:28'),
(26,6,15,'2023-11-02 20:21:47','2023-11-02 20:22:47'),
(27,42,13,'2023-11-02 20:47:40','2023-11-02 20:51:40'),
(28,10,10,'2023-11-03 00:47:57','2023-11-03 00:52:57'),
(29,49,24,'2023-11-03 02:20:36','2023-11-03 02:24:36'),
(30,6,34,'2023-11-03 03:21:00','2023-11-03 03:24:00'),
(31,10,14,'2023-11-03 03:43:59','2023-11-03 03:48:59'),
(32,4,18,'2023-11-03 04:08:00','2023-11-03 04:09:00'),
(33,40,15,'2023-11-03 04:43:30','2023-11-03 04:45:30'),
(34,45,7,'2023-11-03 09:13:41','2023-11-03 09:14:41'),
(35,23,13,'2023-11-03 10:07:11','2023-11-03 10:12:11'),
(36,42,27,'2023-11-03 11:59:06','2023-11-03 12:03:06'),
(37,30,21,'2023-11-03 12:21:51','2023-11-03 12:22:51'),
(38,8,38,'2023-11-03 13:52:33','2023-11-03 13:56:33'),
(39,49,26,'2023-11-03 15:23:38','2023-11-03 15:26:38'),
(40,25,26,'2023-11-03 15:39:52','2023-11-03 15:41:52'),
(41,47,7,'2023-11-03 16:07:47','2023-11-03 16:10:47'),
(42,28,32,'2023-11-03 18:20:03','2023-11-03 18:23:03'),
(43,31,17,'2023-11-03 18:54:04','2023-11-03 18:55:04'),
(44,48,18,'2023-11-03 20:54:31','2023-11-03 20:57:31'),
(45,42,18,'2023-11-03 23:17:52','2023-11-03 23:19:52'),
(46,35,10,'2023-11-04 02:00:27','2023-11-04 02:04:27'),
(47,20,3,'2023-11-04 02:23:03','2023-11-04 02:28:03'),
(48,40,14,'2023-11-04 03:08:25','2023-11-04 03:11:25'),
(49,14,29,'2023-11-04 03:24:18','2023-11-04 03:25:18'),
(50,23,24,'2023-11-04 07:46:04','2023-11-04 07:50:04'),
(51,27,6,'2023-11-04 08:38:02','2023-11-04 08:41:02'),
(52,37,22,'2023-11-04 09:49:45','2023-11-04 09:54:45'),
(53,23,31,'2023-11-04 10:07:36','2023-11-04 10:10:36'),
(54,8,34,'2023-11-04 11:39:06','2023-11-04 11:40:06'),
(55,47,16,'2023-11-04 11:42:45','2023-11-04 11:43:45'),
(56,42,28,'2023-11-04 12:30:13','2023-11-04 12:32:13'),
(57,40,28,'2023-11-04 12:58:14','2023-11-04 13:00:14'),
(58,24,34,'2023-11-04 13:41:54','2023-11-04 13:43:54'),
(59,32,38,'2023-11-04 15:27:51','2023-11-04 15:31:51'),
(60,27,26,'2023-11-04 18:02:35','2023-11-04 18:04:35'),
(61,39,22,'2023-11-04 19:03:07','2023-11-04 19:07:07'),
(62,19,38,'2023-11-04 19:36:21','2023-11-04 19:39:21'),
(63,2,12,'2023-11-04 20:34:01','2023-11-04 20:38:01'),
(64,7,39,'2023-11-04 21:08:11','2023-11-04 21:11:11'),
(65,21,7,'2023-11-04 21:26:44','2023-11-04 21:29:44'),
(66,11,27,'2023-11-04 23:45:22','2023-11-04 23:48:22'),
(67,24,4,'2023-11-04 23:47:12','2023-11-04 23:49:12'),
(68,36,19,'2023-11-05 01:01:28','2023-11-05 01:02:28'),
(69,14,12,'2023-11-05 01:26:59','2023-11-05 01:29:59'),
(70,34,17,'2023-11-05 02:41:22','2023-11-05 02:43:22'),
(71,47,23,'2023-11-05 04:48:59','2023-11-05 04:49:59'),
(72,50,18,'2023-11-05 05:09:52','2023-11-05 05:12:52'),
(73,13,36,'2023-11-05 05:21:57','2023-11-05 05:26:57'),
(74,43,16,'2023-11-05 06:38:24','2023-11-05 06:41:24'),
(75,50,24,'2023-11-05 08:00:18','2023-11-05 08:01:18'),
(76,31,39,'2023-11-05 08:30:42','2023-11-05 08:32:42'),
(77,46,36,'2023-11-05 08:42:32','2023-11-05 08:43:32'),
(78,4,6,'2023-11-05 11:43:22','2023-11-05 11:48:22'),
(79,7,21,'2023-11-05 12:26:47','2023-11-05 12:30:47'),
(80,28,34,'2023-11-05 15:47:03','2023-11-05 15:48:03'),
(81,16,9,'2023-11-05 17:42:36','2023-11-05 17:44:36'),
(82,2,21,'2023-11-06 01:59:25','2023-11-06 02:04:25'),
(83,10,21,'2023-11-06 05:21:07','2023-11-06 05:25:07'),
(84,26,9,'2023-11-06 06:53:22','2023-11-06 06:56:22'),
(85,6,5,'2023-11-06 07:44:37','2023-11-06 07:49:37'),
(86,21,26,'2023-11-06 10:26:41','2023-11-06 10:31:41'),
(87,33,32,'2023-11-06 10:33:45','2023-11-06 10:38:45'),
(88,27,22,'2023-11-06 10:37:59','2023-11-06 10:38:59'),
(89,31,8,'2023-11-06 13:04:15','2023-11-06 13:08:15'),
(90,13,26,'2023-11-06 13:18:20','2023-11-06 13:23:20'),
(91,9,35,'2023-11-06 14:00:14','2023-11-06 14:04:14'),
(92,38,29,'2023-11-06 17:46:15','2023-11-06 17:50:15'),
(93,21,34,'2023-11-06 19:16:59','2023-11-06 19:21:59'),
(94,47,6,'2023-11-06 22:59:15','2023-11-06 23:00:15'),
(95,33,37,'2023-11-06 23:55:13','2023-11-06 23:57:13'),
(96,19,4,'2023-11-07 02:01:13','2023-11-07 02:03:13'),
(97,7,3,'2023-11-07 02:05:24','2023-11-07 02:07:24'),
(98,41,33,'2023-11-07 02:07:23','2023-11-07 02:12:23'),
(99,8,11,'2023-11-07 02:17:34','2023-11-07 02:22:34'),
(100,28,23,'2023-11-07 02:46:14','2023-11-07 02:48:14'),
(101,44,37,'2023-11-07 03:56:00','2023-11-07 03:57:00'),
(102,36,7,'2023-11-07 04:13:12','2023-11-07 04:17:12'),
(103,23,1,'2023-11-07 04:32:31','2023-11-07 04:36:31'),
(104,24,3,'2023-11-07 06:16:26','2023-11-07 06:19:26'),
(105,49,35,'2023-11-07 06:17:35','2023-11-07 06:21:35'),
(106,34,25,'2023-11-07 06:35:41','2023-11-07 06:40:41'),
(107,31,3,'2023-11-07 07:14:02','2023-11-07 07:16:02'),
(108,22,36,'2023-11-07 08:28:45','2023-11-07 08:32:45'),
(109,4,35,'2023-11-07 09:09:21','2023-11-07 09:14:21'),
(110,2,16,'2023-11-07 09:15:05','2023-11-07 09:17:05'),
(111,35,21,'2023-11-07 09:31:32','2023-11-07 09:35:32'),
(112,17,13,'2023-11-07 09:35:25','2023-11-07 09:38:25'),
(113,43,3,'2023-11-07 10:57:54','2023-11-07 10:58:54'),
(114,38,33,'2023-11-07 12:27:38','2023-11-07 12:29:38'),
(115,16,35,'2023-11-07 12:36:53','2023-11-07 12:40:53'),
(116,33,11,'2023-11-07 14:12:04','2023-11-07 14:15:04'),
(117,6,4,'2023-11-07 15:17:36','2023-11-07 15:21:36'),
(118,21,23,'2023-11-07 15:46:43','2023-11-07 15:47:43'),
(119,14,10,'2023-11-07 16:11:39','2023-11-07 16:12:39'),
(120,25,15,'2023-11-07 16:19:09','2023-11-07 16:20:09'),
(121,30,21,'2023-11-07 19:29:52','2023-11-07 19:33:52'),
(122,45,37,'2023-11-07 21:05:58','2023-11-07 21:10:58'),
(123,15,24,'2023-11-07 21:21:54','2023-11-07 21:25:54'),
(124,15,38,'2023-11-07 22:08:45','2023-11-07 22:10:45'),
(125,41,4,'2023-11-08 00:26:49','2023-11-08 00:30:49'),
(126,48,11,'2023-11-08 01:26:39','2023-11-08 01:29:39'),
(127,33,40,'2023-11-08 01:42:15','2023-11-08 01:47:15'),
(128,44,28,'2023-11-08 02:18:18','2023-11-08 02:21:18'),
(129,25,2,'2023-11-08 03:33:44','2023-11-08 03:36:44'),
(130,6,3,'2023-11-08 04:16:55','2023-11-08 04:19:55'),
(131,48,36,'2023-11-08 06:48:13','2023-11-08 06:49:13'),
(132,28,2,'2023-11-08 07:43:40','2023-11-08 07:48:40'),
(133,17,28,'2023-11-08 08:45:26','2023-11-08 08:47:26'),
(134,38,4,'2023-11-08 10:50:11','2023-11-08 10:55:11'),
(135,19,31,'2023-11-08 11:41:54','2023-11-08 11:46:54'),
(136,8,23,'2023-11-08 13:18:34','2023-11-08 13:21:34'),
(137,24,29,'2023-11-08 14:52:30','2023-11-08 14:55:30'),
(138,39,32,'2023-11-08 15:50:55','2023-11-08 15:54:55'),
(139,5,29,'2023-11-08 17:17:18','2023-11-08 17:22:18'),
(140,33,14,'2023-11-08 18:19:42','2023-11-08 18:23:42'),
(141,22,9,'2023-11-08 18:49:37','2023-11-08 18:54:37'),
(142,43,15,'2023-11-08 20:47:53','2023-11-08 20:51:53'),
(143,29,24,'2023-11-09 00:04:14','2023-11-09 00:06:14'),
(144,27,9,'2023-11-09 01:24:14','2023-11-09 01:27:14'),
(145,39,8,'2023-11-09 02:37:44','2023-11-09 02:42:44'),
(146,42,28,'2023-11-09 03:14:02','2023-11-09 03:16:02'),
(147,18,26,'2023-11-09 04:17:47','2023-11-09 04:18:47'),
(148,49,9,'2023-11-09 05:25:11','2023-11-09 05:28:11'),
(149,24,30,'2023-11-09 08:23:37','2023-11-09 08:24:37'),
(150,30,23,'2023-11-09 09:03:50','2023-11-09 09:05:50'),
(151,30,17,'2023-11-09 09:09:05','2023-11-09 09:12:05'),
(152,35,7,'2023-11-09 09:09:21','2023-11-09 09:14:21'),
(153,24,26,'2023-11-09 09:12:10','2023-11-09 09:15:10'),
(154,49,36,'2023-11-09 09:39:45','2023-11-09 09:43:45'),
(155,7,26,'2023-11-09 10:14:39','2023-11-09 10:19:39'),
(156,39,24,'2023-11-09 12:33:55','2023-11-09 12:34:55'),
(157,24,27,'2023-11-09 14:44:06','2023-11-09 14:49:06'),
(158,30,30,'2023-11-09 15:01:02','2023-11-09 15:06:02'),
(159,8,7,'2023-11-09 15:35:30','2023-11-09 15:37:30'),
(160,25,14,'2023-11-09 20:47:03','2023-11-09 20:52:03'),
(161,49,21,'2023-11-09 20:53:00','2023-11-09 20:55:00'),
(162,43,13,'2023-11-09 22:17:24','2023-11-09 22:20:24'),
(163,33,24,'2023-11-09 22:50:55','2023-11-09 22:54:55'),
(164,40,9,'2023-11-09 23:20:35','2023-11-09 23:23:35'),
(165,12,14,'2023-11-10 00:56:43','2023-11-10 00:57:43'),
(166,30,4,'2023-11-10 01:30:23','2023-11-10 01:32:23'),
(167,10,37,'2023-11-10 04:47:14','2023-11-10 04:49:14'),
(168,40,7,'2023-11-10 07:07:36','2023-11-10 07:09:36'),
(169,23,33,'2023-11-10 07:25:53','2023-11-10 07:28:53'),
(170,1,8,'2023-11-10 08:13:14','2023-11-10 08:16:14'),
(171,13,11,'2023-11-10 08:22:53','2023-11-10 08:24:53'),
(172,7,21,'2023-11-10 09:07:55','2023-11-10 09:08:55'),
(173,49,32,'2023-11-10 09:18:28','2023-11-10 09:20:28'),
(174,2,19,'2023-11-10 11:35:22','2023-11-10 11:40:22'),
(175,23,23,'2023-11-10 12:55:05','2023-11-10 13:00:05'),
(176,9,3,'2023-11-10 13:24:06','2023-11-10 13:29:06'),
(177,40,40,'2023-11-10 14:05:40','2023-11-10 14:08:40'),
(178,42,39,'2023-11-10 14:33:46','2023-11-10 14:35:46'),
(179,45,10,'2023-11-10 15:10:49','2023-11-10 15:15:49'),
(180,38,28,'2023-11-10 16:38:12','2023-11-10 16:40:12'),
(181,28,26,'2023-11-10 18:10:52','2023-11-10 18:11:52'),
(182,27,24,'2023-11-11 01:04:08','2023-11-11 01:07:08'),
(183,41,12,'2023-11-11 03:29:17','2023-11-11 03:30:17'),
(184,22,23,'2023-11-11 04:37:45','2023-11-11 04:38:45'),
(185,5,4,'2023-11-11 06:01:01','2023-11-11 06:03:01'),
(186,49,16,'2023-11-11 07:33:07','2023-11-11 07:34:07'),
(187,3,10,'2023-11-11 08:05:02','2023-11-11 08:08:02'),
(188,44,36,'2023-11-11 09:51:16','2023-11-11 09:55:16'),
(189,39,20,'2023-11-11 10:54:37','2023-11-11 10:59:37'),
(190,34,3,'2023-11-11 11:04:58','2023-11-11 11:06:58'),
(191,5,32,'2023-11-11 12:30:02','2023-11-11 12:35:02'),
(192,19,31,'2023-11-11 12:36:33','2023-11-11 12:40:33'),
(193,44,11,'2023-11-11 13:26:23','2023-11-11 13:30:23'),
(194,38,8,'2023-11-11 14:55:36','2023-11-11 14:56:36'),
(195,30,33,'2023-11-11 17:36:53','2023-11-11 17:39:53'),
(196,30,20,'2023-11-11 22:08:45','2023-11-11 22:09:45'),
(197,46,1,'2023-11-11 22:37:41','2023-11-11 22:38:41'),
(198,38,33,'2023-11-12 00:18:43','2023-11-12 00:19:43'),
(199,48,31,'2023-11-12 00:37:05','2023-11-12 00:42:05'),
(200,3,30,'2023-11-12 01:31:39','2023-11-12 01:36:39'),
(201,39,37,'2023-11-12 03:15:39','2023-11-12 03:20:39'),
(202,7,13,'2023-11-12 03:41:32','2023-11-12 03:42:32'),
(203,9,27,'2023-11-12 05:44:22','2023-11-12 05:45:22'),
(204,39,23,'2023-11-12 07:59:24','2023-11-12 08:04:24'),
(205,46,37,'2023-11-12 09:34:05','2023-11-12 09:36:05'),
(206,38,19,'2023-11-12 16:34:36','2023-11-12 16:36:36'),
(207,50,30,'2023-11-12 17:03:59','2023-11-12 17:06:59'),
(208,46,22,'2023-11-12 17:28:09','2023-11-12 17:31:09'),
(209,22,30,'2023-11-12 22:18:44','2023-11-12 22:20:44'),
(210,50,39,'2023-11-12 22:52:57','2023-11-12 22:54:57'),
(211,48,4,'2023-11-13 02:24:51','2023-11-13 02:26:51'),
(212,41,6,'2023-11-13 03:55:20','2023-11-13 03:59:20'),
(213,8,37,'2023-11-13 05:55:25','2023-11-13 05:58:25'),
(214,4,25,'2023-11-13 06:22:21','2023-11-13 06:24:21'),
(215,31,21,'2023-11-13 07:04:19','2023-11-13 07:06:19'),
(216,23,22,'2023-11-13 09:27:07','2023-11-13 09:31:07'),
(217,41,3,'2023-11-13 10:36:20','2023-11-13 10:38:20'),
(218,5,37,'2023-11-13 10:46:53','2023-11-13 10:47:53'),
(219,26,10,'2023-11-13 11:09:40','2023-11-13 11:12:40'),
(220,7,23,'2023-11-13 14:06:48','2023-11-13 14:10:48'),
(221,26,34,'2023-11-13 15:23:33','2023-11-13 15:24:33'),
(222,46,6,'2023-11-13 21:14:35','2023-11-13 21:15:35'),
(223,25,13,'2023-11-13 21:17:24','2023-11-13 21:20:24'),
(224,21,13,'2023-11-13 23:21:43','2023-11-13 23:26:43'),
(225,29,18,'2023-11-13 23:25:35','2023-11-13 23:28:35'),
(226,46,5,'2023-11-14 00:57:15','2023-11-14 01:02:15'),
(227,47,38,'2023-11-14 01:02:52','2023-11-14 01:07:52'),
(228,29,23,'2023-11-14 03:15:38','2023-11-14 03:17:38'),
(229,36,34,'2023-11-14 03:22:43','2023-11-14 03:23:43'),
(230,31,36,'2023-11-14 03:36:21','2023-11-14 03:40:21'),
(231,3,35,'2023-11-14 03:54:25','2023-11-14 03:56:25'),
(232,42,4,'2023-11-14 03:59:19','2023-11-14 04:02:19'),
(233,24,7,'2023-11-14 04:25:47','2023-11-14 04:27:47'),
(234,39,11,'2023-11-14 07:34:43','2023-11-14 07:35:43'),
(235,32,29,'2023-11-14 09:03:57','2023-11-14 09:05:57'),
(236,33,25,'2023-11-14 10:01:43','2023-11-14 10:05:43'),
(237,47,30,'2023-11-14 10:52:15','2023-11-14 10:56:15'),
(238,35,34,'2023-11-14 12:35:49','2023-11-14 12:37:49'),
(239,42,38,'2023-11-14 14:23:22','2023-11-14 14:28:22'),
(240,29,29,'2023-11-14 16:28:28','2023-11-14 16:31:28'),
(241,28,17,'2023-11-14 16:35:20','2023-11-14 16:36:20'),
(242,20,18,'2023-11-14 18:12:32','2023-11-14 18:15:32'),
(243,21,16,'2023-11-14 21:01:01','2023-11-14 21:06:01'),
(244,3,19,'2023-11-14 23:59:17','2023-11-14 00:04:17'),
(245,16,13,'2023-11-15 01:24:38','2023-11-15 01:29:38'),
(246,38,26,'2023-11-15 01:35:11','2023-11-15 01:40:11'),
(247,22,10,'2023-11-15 01:43:07','2023-11-15 01:45:07'),
(248,28,20,'2023-11-15 02:04:01','2023-11-15 02:08:01'),
(249,37,9,'2023-11-15 04:54:46','2023-11-15 04:57:46'),
(250,23,35,'2023-11-15 05:52:52','2023-11-15 05:57:52'),
(251,45,15,'2023-11-15 07:38:03','2023-11-15 07:42:03'),
(252,45,25,'2023-11-15 09:16:23','2023-11-15 09:20:23'),
(253,31,23,'2023-11-15 14:15:28','2023-11-15 14:20:28'),
(254,29,7,'2023-11-15 14:59:32','2023-11-15 15:01:32'),
(255,6,29,'2023-11-15 17:26:07','2023-11-15 17:30:07'),
(256,40,17,'2023-11-15 17:57:46','2023-11-15 17:58:46'),
(257,19,29,'2023-11-15 18:10:49','2023-11-15 18:14:49'),
(258,7,14,'2023-11-15 20:16:09','2023-11-15 20:21:09'),
(259,30,3,'2023-11-15 21:10:16','2023-11-15 21:14:16'),
(260,33,28,'2023-11-15 21:48:16','2023-11-15 21:50:16'),
(261,7,36,'2023-11-15 23:58:57','2023-11-15 00:02:57'),
(262,44,27,'2023-11-16 00:24:52','2023-11-16 00:29:52'),
(263,10,10,'2023-11-16 01:14:59','2023-11-16 01:16:59'),
(264,39,23,'2023-11-16 02:18:31','2023-11-16 02:21:31'),
(265,37,20,'2023-11-16 03:23:17','2023-11-16 03:24:17'),
(266,22,8,'2023-11-16 04:20:28','2023-11-16 04:24:28'),
(267,3,22,'2023-11-16 07:48:02','2023-11-16 07:49:02'),
(268,15,16,'2023-11-16 10:38:30','2023-11-16 10:41:30'),
(269,38,20,'2023-11-16 12:09:18','2023-11-16 12:14:18'),
(270,13,38,'2023-11-16 18:38:20','2023-11-16 18:39:20'),
(271,11,28,'2023-11-16 20:33:13','2023-11-16 20:37:13'),
(272,21,31,'2023-11-16 21:14:32','2023-11-16 21:15:32'),
(273,36,4,'2023-11-17 00:07:26','2023-11-17 00:12:26'),
(274,29,30,'2023-11-17 00:54:41','2023-11-17 00:59:41'),
(275,30,12,'2023-11-17 04:48:57','2023-11-17 04:51:57'),
(276,7,6,'2023-11-17 05:12:05','2023-11-17 05:14:05'),
(277,37,40,'2023-11-17 08:18:47','2023-11-17 08:20:47'),
(278,26,5,'2023-11-17 09:36:17','2023-11-17 09:37:17'),
(279,19,24,'2023-11-17 10:51:57','2023-11-17 10:56:57'),
(280,25,12,'2023-11-17 11:04:03','2023-11-17 11:06:03'),
(281,10,12,'2023-11-17 11:32:03','2023-11-17 11:35:03'),
(282,20,33,'2023-11-17 12:53:45','2023-11-17 12:54:45'),
(283,17,18,'2023-11-17 15:20:34','2023-11-17 15:24:34'),
(284,21,12,'2023-11-17 17:12:47','2023-11-17 17:14:47'),
(285,48,5,'2023-11-17 17:45:15','2023-11-17 17:48:15'),
(286,37,2,'2023-11-17 18:47:01','2023-11-17 18:51:01'),
(287,32,40,'2023-11-18 00:26:24','2023-11-18 00:27:24'),
(288,42,15,'2023-11-18 01:16:50','2023-11-18 01:19:50'),
(289,32,26,'2023-11-18 03:33:04','2023-11-18 03:35:04'),
(290,31,23,'2023-11-18 05:15:08','2023-11-18 05:18:08'),
(291,13,15,'2023-11-18 08:16:53','2023-11-18 08:19:53'),
(292,40,16,'2023-11-18 09:03:35','2023-11-18 09:08:35'),
(293,37,21,'2023-11-18 09:44:20','2023-11-18 09:49:20'),
(294,29,34,'2023-11-18 09:52:03','2023-11-18 09:54:03'),
(295,21,9,'2023-11-18 10:35:30','2023-11-18 10:38:30'),
(296,30,34,'2023-11-18 10:36:37','2023-11-18 10:37:37'),
(297,49,3,'2023-11-18 10:38:03','2023-11-18 10:40:03'),
(298,34,14,'2023-11-18 12:17:13','2023-11-18 12:22:13'),
(299,30,29,'2023-11-18 15:14:00','2023-11-18 15:17:00'),
(300,26,24,'2023-11-18 16:11:23','2023-11-18 16:14:23'),
(301,43,34,'2023-11-18 16:53:57','2023-11-18 16:56:57'),
(302,38,31,'2023-11-18 19:52:36','2023-11-18 19:55:36'),
(303,39,38,'2023-11-19 03:30:13','2023-11-19 03:32:13'),
(304,31,4,'2023-11-19 04:37:13','2023-11-19 04:38:13'),
(305,36,15,'2023-11-19 07:34:39','2023-11-19 07:38:39'),
(306,6,26,'2023-11-19 07:53:31','2023-11-19 07:54:31'),
(307,28,35,'2023-11-19 09:15:36','2023-11-19 09:17:36'),
(308,38,38,'2023-11-19 09:35:01','2023-11-19 09:40:01'),
(309,50,37,'2023-11-19 10:16:45','2023-11-19 10:17:45'),
(310,31,27,'2023-11-19 10:23:54','2023-11-19 10:24:54'),
(311,32,11,'2023-11-19 10:24:06','2023-11-19 10:25:06'),
(312,24,29,'2023-11-19 10:36:00','2023-11-19 10:37:00'),
(313,48,22,'2023-11-19 11:57:11','2023-11-19 12:01:11'),
(314,12,5,'2023-11-19 13:20:38','2023-11-19 13:23:38'),
(315,50,18,'2023-11-19 14:40:54','2023-11-19 14:41:54'),
(316,12,33,'2023-11-19 14:41:54','2023-11-19 14:43:54'),
(317,9,38,'2023-11-19 15:57:23','2023-11-19 16:01:23'),
(318,12,5,'2023-11-19 17:07:14','2023-11-19 17:11:14'),
(319,49,16,'2023-11-19 17:21:39','2023-11-19 17:23:39'),
(320,15,36,'2023-11-19 18:02:14','2023-11-19 18:03:14'),
(321,50,34,'2023-11-19 18:16:36','2023-11-19 18:18:36'),
(322,20,34,'2023-11-19 22:41:04','2023-11-19 22:46:04'),
(323,47,26,'2023-11-20 00:01:37','2023-11-20 00:05:37'),
(324,30,18,'2023-11-20 02:34:54','2023-11-20 02:38:54'),
(325,18,2,'2023-11-20 05:16:49','2023-11-20 05:17:49'),
(326,6,25,'2023-11-20 07:04:08','2023-11-20 07:06:08'),
(327,7,31,'2023-11-20 08:19:39','2023-11-20 08:23:39'),
(328,33,32,'2023-11-20 10:20:03','2023-11-20 10:24:03'),
(329,23,29,'2023-11-20 11:13:49','2023-11-20 11:16:49'),
(330,28,28,'2023-11-20 12:08:35','2023-11-20 12:13:35'),
(331,22,18,'2023-11-20 12:23:49','2023-11-20 12:24:49'),
(332,22,32,'2023-11-20 13:06:40','2023-11-20 13:11:40'),
(333,13,12,'2023-11-20 13:38:38','2023-11-20 13:39:38'),
(334,40,11,'2023-11-20 14:28:11','2023-11-20 14:29:11'),
(335,19,23,'2023-11-20 14:28:54','2023-11-20 14:33:54'),
(336,46,30,'2023-11-20 15:37:33','2023-11-20 15:41:33'),
(337,49,35,'2023-11-20 17:40:11','2023-11-20 17:41:11'),
(338,7,20,'2023-11-20 19:04:44','2023-11-20 19:09:44'),
(339,15,15,'2023-11-20 20:01:00','2023-11-20 20:04:00'),
(340,36,24,'2023-11-21 00:38:31','2023-11-21 00:43:31'),
(341,39,23,'2023-11-21 00:46:31','2023-11-21 00:51:31'),
(342,33,15,'2023-11-21 00:47:01','2023-11-21 00:50:01'),
(343,22,34,'2023-11-21 05:23:11','2023-11-21 05:27:11'),
(344,7,27,'2023-11-21 06:24:20','2023-11-21 06:29:20'),
(345,43,33,'2023-11-21 10:16:18','2023-11-21 10:17:18'),
(346,47,33,'2023-11-21 10:40:16','2023-11-21 10:45:16'),
(347,34,13,'2023-11-21 10:47:53','2023-11-21 10:50:53'),
(348,21,26,'2023-11-21 16:03:01','2023-11-21 16:05:01'),
(349,14,25,'2023-11-21 16:25:16','2023-11-21 16:30:16'),
(350,31,7,'2023-11-21 17:24:09','2023-11-21 17:28:09'),
(351,25,24,'2023-11-21 17:50:00','2023-11-21 17:54:00'),
(352,6,35,'2023-11-21 19:47:42','2023-11-21 19:51:42'),
(353,24,31,'2023-11-21 21:43:17','2023-11-21 21:45:17'),
(354,43,19,'2023-11-21 23:59:25','2023-11-21 00:03:25'),
(355,44,14,'2023-11-22 00:13:05','2023-11-22 00:15:05'),
(356,23,30,'2023-11-22 00:33:57','2023-11-22 00:36:57'),
(357,42,28,'2023-11-22 04:11:10','2023-11-22 04:12:10'),
(358,46,34,'2023-11-22 05:20:52','2023-11-22 05:23:52'),
(359,24,8,'2023-11-22 06:01:39','2023-11-22 06:04:39'),
(360,21,33,'2023-11-22 06:32:52','2023-11-22 06:34:52'),
(361,15,29,'2023-11-22 06:47:19','2023-11-22 06:50:19'),
(362,11,12,'2023-11-22 07:58:32','2023-11-22 08:01:32'),
(363,35,2,'2023-11-22 10:06:48','2023-11-22 10:10:48'),
(364,18,28,'2023-11-22 11:11:50','2023-11-22 11:12:50'),
(365,8,13,'2023-11-22 12:18:02','2023-11-22 12:20:02'),
(366,34,4,'2023-11-22 12:46:22','2023-11-22 12:49:22'),
(367,30,24,'2023-11-22 14:18:50','2023-11-22 14:20:50'),
(368,46,2,'2023-11-22 17:06:48','2023-11-22 17:07:48'),
(369,30,24,'2023-11-22 17:32:37','2023-11-22 17:34:37'),
(370,44,35,'2023-11-22 20:41:49','2023-11-22 20:46:49'),
(371,19,30,'2023-11-22 22:55:36','2023-11-22 23:00:36'),
(372,46,5,'2023-11-22 23:28:06','2023-11-22 23:29:06'),
(373,43,11,'2023-11-23 00:02:00','2023-11-23 00:04:00'),
(374,34,27,'2023-11-23 00:19:26','2023-11-23 00:20:26'),
(375,31,29,'2023-11-23 00:20:46','2023-11-23 00:24:46'),
(376,4,38,'2023-11-23 01:57:48','2023-11-23 01:59:48'),
(377,16,12,'2023-11-23 03:07:41','2023-11-23 03:12:41'),
(378,40,26,'2023-11-23 05:47:31','2023-11-23 05:52:31'),
(379,5,40,'2023-11-23 09:16:31','2023-11-23 09:17:31'),
(380,3,3,'2023-11-23 09:22:32','2023-11-23 09:25:32'),
(381,17,1,'2023-11-23 10:50:47','2023-11-23 10:53:47'),
(382,15,15,'2023-11-23 11:18:15','2023-11-23 11:23:15'),
(383,38,6,'2023-11-23 11:34:16','2023-11-23 11:35:16'),
(384,32,19,'2023-11-23 12:22:31','2023-11-23 12:25:31'),
(385,22,21,'2023-11-23 16:53:57','2023-11-23 16:56:57'),
(386,24,32,'2023-11-23 18:31:35','2023-11-23 18:32:35'),
(387,6,38,'2023-11-23 20:48:17','2023-11-23 20:51:17'),
(388,19,20,'2023-11-23 21:12:03','2023-11-23 21:17:03'),
(389,12,24,'2023-11-23 23:16:44','2023-11-23 23:17:44'),
(390,22,1,'2023-11-23 23:54:46','2023-11-23 23:59:46'),
(391,10,26,'2023-11-24 03:20:42','2023-11-24 03:22:42'),
(392,38,28,'2023-11-24 04:22:39','2023-11-24 04:27:39'),
(393,21,19,'2023-11-24 05:02:18','2023-11-24 05:05:18'),
(394,18,6,'2023-11-24 05:17:59','2023-11-24 05:18:59'),
(395,50,28,'2023-11-24 11:06:18','2023-11-24 11:08:18'),
(396,36,35,'2023-11-24 13:46:15','2023-11-24 13:50:15'),
(397,14,15,'2023-11-24 14:37:03','2023-11-24 14:42:03'),
(398,42,7,'2023-11-24 17:14:43','2023-11-24 17:18:43'),
(399,8,34,'2023-11-24 17:39:34','2023-11-24 17:42:34'),
(400,14,22,'2023-11-24 17:54:15','2023-11-24 17:56:15'),
(401,1,20,'2023-11-24 19:21:41','2023-11-24 19:26:41'),
(402,48,36,'2023-11-24 19:58:50','2023-11-24 20:02:50'),
(403,16,30,'2023-11-24 20:12:50','2023-11-24 20:17:50'),
(404,16,34,'2023-11-24 21:40:45','2023-11-24 21:44:45'),
(405,17,18,'2023-11-24 23:26:49','2023-11-24 23:27:49'),
(406,26,28,'2023-11-25 00:38:04','2023-11-25 00:40:04'),
(407,7,20,'2023-11-25 00:50:20','2023-11-25 00:52:20'),
(408,21,30,'2023-11-25 04:57:10','2023-11-25 05:02:10'),
(409,15,25,'2023-11-25 05:11:14','2023-11-25 05:15:14'),
(410,20,21,'2023-11-25 08:30:43','2023-11-25 08:31:43'),
(411,35,2,'2023-11-25 08:49:38','2023-11-25 08:51:38'),
(412,39,7,'2023-11-25 09:57:07','2023-11-25 09:58:07'),
(413,46,7,'2023-11-25 10:41:55','2023-11-25 10:46:55'),
(414,12,39,'2023-11-25 11:08:54','2023-11-25 11:09:54'),
(415,20,7,'2023-11-25 15:36:43','2023-11-25 15:41:43'),
(416,32,18,'2023-11-25 16:45:09','2023-11-25 16:50:09'),
(417,32,28,'2023-11-25 18:56:06','2023-11-25 18:58:06'),
(418,22,19,'2023-11-25 18:58:02','2023-11-25 18:59:02'),
(419,14,21,'2023-11-25 19:22:49','2023-11-25 19:25:49'),
(420,31,35,'2023-11-25 19:43:04','2023-11-25 19:45:04'),
(421,7,19,'2023-11-25 20:57:08','2023-11-25 21:00:08'),
(422,28,10,'2023-11-25 22:12:12','2023-11-25 22:14:12'),
(423,13,15,'2023-11-25 22:15:32','2023-11-25 22:20:32'),
(424,5,5,'2023-11-26 01:04:31','2023-11-26 01:05:31'),
(425,49,32,'2023-11-26 04:23:37','2023-11-26 04:27:37'),
(426,47,14,'2023-11-26 06:11:24','2023-11-26 06:14:24'),
(427,19,39,'2023-11-26 06:40:39','2023-11-26 06:41:39'),
(428,6,13,'2023-11-26 09:00:52','2023-11-26 09:04:52'),
(429,18,18,'2023-11-26 09:46:20','2023-11-26 09:50:20'),
(430,5,11,'2023-11-26 11:29:39','2023-11-26 11:34:39'),
(431,12,33,'2023-11-26 11:57:44','2023-11-26 12:00:44'),
(432,38,4,'2023-11-26 12:11:21','2023-11-26 12:14:21'),
(433,21,23,'2023-11-26 15:23:05','2023-11-26 15:28:05'),
(434,36,21,'2023-11-26 16:53:12','2023-11-26 16:57:12'),
(435,4,7,'2023-11-26 19:40:46','2023-11-26 19:42:46'),
(436,41,37,'2023-11-26 21:34:59','2023-11-26 21:35:59'),
(437,30,8,'2023-11-26 23:35:03','2023-11-26 23:39:03'),
(438,34,2,'2023-11-27 03:30:52','2023-11-27 03:35:52'),
(439,26,31,'2023-11-27 03:39:17','2023-11-27 03:43:17'),
(440,35,5,'2023-11-27 03:43:42','2023-11-27 03:47:42'),
(441,3,8,'2023-11-27 03:45:35','2023-11-27 03:50:35'),
(442,40,2,'2023-11-27 04:52:04','2023-11-27 04:57:04'),
(443,41,33,'2023-11-27 08:40:27','2023-11-27 08:42:27'),
(444,46,14,'2023-11-27 09:43:22','2023-11-27 09:44:22'),
(445,45,27,'2023-11-27 12:21:51','2023-11-27 12:22:51'),
(446,48,18,'2023-11-27 13:14:23','2023-11-27 13:16:23'),
(447,9,34,'2023-11-27 21:09:32','2023-11-27 21:12:32'),
(448,26,40,'2023-11-27 21:44:33','2023-11-27 21:48:33'),
(449,9,4,'2023-11-27 22:11:36','2023-11-27 22:12:36'),
(450,35,26,'2023-11-28 04:46:49','2023-11-28 04:50:49'),
(451,25,6,'2023-11-28 05:31:27','2023-11-28 05:33:27'),
(452,28,28,'2023-11-28 06:02:59','2023-11-28 06:03:59'),
(453,37,18,'2023-11-28 08:11:19','2023-11-28 08:13:19'),
(454,8,22,'2023-11-28 08:52:16','2023-11-28 08:57:16'),
(455,33,12,'2023-11-28 10:40:56','2023-11-28 10:45:56'),
(456,41,18,'2023-11-28 11:44:51','2023-11-28 11:46:51'),
(457,22,36,'2023-11-28 14:15:32','2023-11-28 14:20:32'),
(458,41,8,'2023-11-28 15:38:19','2023-11-28 15:40:19'),
(459,23,14,'2023-11-28 16:42:36','2023-11-28 16:44:36'),
(460,33,3,'2023-11-28 18:56:17','2023-11-28 18:59:17'),
(461,3,7,'2023-11-28 19:30:43','2023-11-28 19:35:43'),
(462,16,17,'2023-11-28 21:04:58','2023-11-28 21:06:58'),
(463,42,39,'2023-11-28 21:50:08','2023-11-28 21:51:08'),
(464,33,8,'2023-11-28 22:27:40','2023-11-28 22:29:40'),
(465,26,9,'2023-11-28 23:09:30','2023-11-28 23:14:30'),
(466,16,30,'2023-11-29 03:02:33','2023-11-29 03:07:33'),
(467,16,40,'2023-11-29 03:48:31','2023-11-29 03:50:31'),
(468,23,36,'2023-11-29 03:49:08','2023-11-29 03:50:08'),
(469,21,4,'2023-11-29 04:18:44','2023-11-29 04:20:44'),
(470,15,26,'2023-11-29 04:41:47','2023-11-29 04:43:47'),
(471,41,13,'2023-11-29 08:29:54','2023-11-29 08:30:54'),
(472,2,18,'2023-11-29 13:03:48','2023-11-29 13:06:48'),
(473,49,15,'2023-11-29 14:28:05','2023-11-29 14:31:05'),
(474,11,30,'2023-11-29 14:57:53','2023-11-29 14:59:53'),
(475,31,18,'2023-11-29 18:34:18','2023-11-29 18:36:18'),
(476,14,4,'2023-11-29 19:52:11','2023-11-29 19:53:11'),
(477,14,7,'2023-11-29 19:55:06','2023-11-29 19:57:06'),
(478,10,13,'2023-11-29 23:05:33','2023-11-29 23:06:33'),
(479,10,29,'2023-11-30 01:16:00','2023-11-30 01:20:00'),
(480,8,18,'2023-11-30 05:04:18','2023-11-30 05:07:18'),
(481,5,18,'2023-11-30 05:52:53','2023-11-30 05:56:53'),
(482,19,17,'2023-11-30 06:04:07','2023-11-30 06:05:07'),
(483,43,12,'2023-11-30 07:06:15','2023-11-30 07:08:15'),
(484,15,25,'2023-11-30 07:52:47','2023-11-30 07:54:47'),
(485,23,36,'2023-11-30 08:05:55','2023-11-30 08:08:55'),
(486,21,14,'2023-11-30 09:11:07','2023-11-30 09:16:07'),
(487,19,3,'2023-11-30 10:43:31','2023-11-30 10:44:31'),
(488,29,34,'2023-11-30 10:44:28','2023-11-30 10:45:28'),
(489,10,25,'2023-11-30 10:50:51','2023-11-30 10:53:51'),
(490,6,33,'2023-11-30 10:59:07','2023-11-30 11:00:07'),
(491,26,18,'2023-11-30 11:21:04','2023-11-30 11:23:04'),
(492,12,2,'2023-11-30 12:29:33','2023-11-30 12:32:33'),
(493,40,24,'2023-11-30 13:48:53','2023-11-30 13:52:53'),
(494,47,28,'2023-11-30 15:18:19','2023-11-30 15:23:19'),
(495,14,3,'2023-11-30 17:51:08','2023-11-30 17:54:08'),
(496,40,9,'2023-11-30 18:36:56','2023-11-30 18:39:56'),
(497,13,9,'2023-11-30 20:20:26','2023-11-30 20:24:26'),
(498,16,34,'2023-11-30 20:47:53','2023-11-30 20:50:53'),
(499,34,3,'2023-11-30 22:48:30','2023-11-30 22:51:30');

--Querying all the tables
SELECT * FROM tracks
SELECT * FROM artists
SELECT * FROM albums
SELECT * FROM users
SELECT * FROM subscriptions
SELECT * FROM users_subscriptions
SELECT * FROM sessions
SELECT * FROM tracks_genres
SELECT * FROM genres

-- Analysis
-- Query 1: Top 3 popular genres per State. 
WITH ranked_genres AS (
    SELECT
        users.users_state,
        genres.genres_genre_name AS genre,
        COUNT(*) AS playback_count,
        SUM(DATEDIFF(minute, sessions.sessions_start_timestamp, sessions.sessions_end_timestamp)) AS total_listening_minutes,
        ROW_NUMBER() OVER (PARTITION BY users.users_state ORDER BY SUM(DATEDIFF(minute, sessions.sessions_start_timestamp, sessions.sessions_end_timestamp)) DESC) 
        AS genre_rank
    FROM sessions
    JOIN users ON sessions.sessions_user_id = users.user_id
    JOIN tracks ON sessions.sessions_track_id = tracks.track_id
    JOIN tracks_genres ON tracks.track_id = tracks_genres.tracks_genres_track_id
    JOIN genres ON tracks_genres.tracks_genres_genre_id = genres.genre_id
    GROUP BY users.users_state, genres.genres_genre_name
)
SELECT users_state, genre, playback_count, total_listening_minutes
FROM ranked_genres
WHERE genre_rank <= 3
ORDER BY users_state, genre_rank;

-- Query 2: User Engagement by Genre and Subscription Type
SELECT  
    genres.genres_genre_name as genre, 
    users.users_subscription_type, 
    COUNT(*) AS playback_count, 
    SUM(DATEDIFF(minute, sessions.sessions_start_timestamp, sessions.sessions_end_timestamp)) AS total_listening_minutes 
FROM sessions 
JOIN users ON sessions.sessions_user_id = users.user_id 
JOIN tracks ON sessions.sessions_track_id = tracks.track_id 
JOIN tracks_genres ON tracks.track_id = tracks_genres.tracks_genres_track_id 
JOIN genres ON tracks_genres.tracks_genres_genre_id = genres.genre_id 
GROUP BY genres.genres_genre_name, users.users_subscription_type 
ORDER BY genres.genres_genre_name, total_listening_minutes DESC; 

-- Query 3: Artist Popularity Across Different Age Groups
SELECT  
    artists.artists_artist_name, 
    CASE  
        WHEN DATEDIFF(year, users.users_date_of_birth, GETDATE()) < 18 THEN 'Under 18' 
        WHEN DATEDIFF(year, users.users_date_of_birth, GETDATE()) BETWEEN 18 AND 25 THEN '18-25' 
        WHEN DATEDIFF(year, users.users_date_of_birth, GETDATE()) BETWEEN 26 AND 35 THEN '26-35' 
        WHEN DATEDIFF(year, users.users_date_of_birth, GETDATE()) BETWEEN 36 AND 50 THEN '36-50' 
        ELSE 'Above 50' 
    END AS age_group, 
    COUNT(*) AS session_count 
FROM sessions 
JOIN users ON sessions.sessions_user_id = users.user_id 
JOIN tracks ON sessions.sessions_track_id = tracks.track_id 
JOIN artists ON tracks.tracks_artist_id = artists.artist_id 
GROUP BY artists.artists_artist_name,  
    CASE  
        WHEN DATEDIFF(year, users.users_date_of_birth, GETDATE()) < 18 THEN 'Under 18' 
        WHEN DATEDIFF(year, users.users_date_of_birth, GETDATE()) BETWEEN 18 AND 25 THEN '18-25' 
        WHEN DATEDIFF(year, users.users_date_of_birth, GETDATE()) BETWEEN 26 AND 35 THEN '26-35' 
        WHEN DATEDIFF(year, users.users_date_of_birth, GETDATE()) BETWEEN 36 AND 50 THEN '36-50' 
        ELSE 'Above 50' 
    END 
ORDER BY artists.artists_artist_name, session_count DESC; 

-- Query 4:Track Popularity and Session Duration by Time of Day
WITH ranked_tracks AS (
    SELECT
        DATEPART(hour, sessions.sessions_start_timestamp) AS hour_of_day,
        tracks.tracks_title,
        COUNT(*) AS session_count,
        SUM(DATEDIFF(minute, sessions.sessions_start_timestamp, sessions.sessions_end_timestamp)) AS total_listening_minutes,
        ROW_NUMBER() OVER (PARTITION BY DATEPART(hour, sessions.sessions_start_timestamp) ORDER BY SUM(DATEDIFF(minute, sessions.sessions_start_timestamp, 
        sessions.sessions_end_timestamp)) DESC) AS track_rank
    FROM sessions
    JOIN tracks ON sessions.sessions_track_id = tracks.track_id
    GROUP BY tracks.tracks_title, DATEPART(hour, sessions.sessions_start_timestamp)
)
SELECT hour_of_day, tracks_title, session_count, total_listening_minutes
FROM ranked_tracks
WHERE track_rank <= 3
ORDER BY hour_of_day, track_rank; 

-- Query 5: Genre Diversity Amongst Users
SELECT  
    users.user_id,
    users.users_first_name + ' ' + users.users_last_name as user_fullname,
    COUNT(DISTINCT genres.genres_genre_name) AS distinct_genre_count 
FROM sessions 
JOIN users ON sessions.sessions_user_id = users.user_id
JOIN tracks ON sessions.sessions_track_id = tracks.track_id 
JOIN tracks_genres ON tracks.track_id = tracks_genres.tracks_genres_track_id 
JOIN genres ON tracks_genres.tracks_genres_genre_id = genres.genre_id 
GROUP BY users.user_id, users.users_first_name + ' ' + users.users_last_name
ORDER BY distinct_genre_count DESC; 

-- Query 6: Correlation Between Subscription Type and Genre Preference
SELECT  
    users.users_subscription_type, 
    genres.genres_genre_name, 
    COUNT(*) AS session_count, 
    SUM(DATEDIFF(minute, sessions.sessions_start_timestamp, sessions.sessions_end_timestamp)) AS total_listening_minutes 
FROM sessions 
JOIN users ON sessions.sessions_user_id = users.user_id 
JOIN tracks ON sessions.sessions_track_id = tracks.track_id 
JOIN tracks_genres ON tracks.track_id = tracks_genres.tracks_genres_track_id 
JOIN genres ON tracks_genres.tracks_genres_genre_id = genres.genre_id 
GROUP BY users.users_subscription_type, genres.genres_genre_name 
ORDER BY users.users_subscription_type, total_listening_minutes DESC; 


-- Query 7: Procedure to add a new track into the tracks table
GO
CREATE PROCEDURE AddNewTrack
    @track_id INT,
    @tracks_album_id INT,
    @tracks_genre_id INT,
    @tracks_artist_id INT,
    @tracks_title VARCHAR(255),
    @tracks_duration INT,
    @tracks_release_date DATE,
    @tracks_genre VARCHAR(50),
    @tracks_language VARCHAR(50)
AS
BEGIN
    INSERT INTO dbo.tracks (track_id, tracks_album_id, tracks_genre_id, tracks_artist_id, tracks_title, tracks_duration, tracks_release_date, tracks_genre, 
    tracks_language)
    VALUES (@track_id, @tracks_album_id, @tracks_genre_id, @tracks_artist_id, @tracks_title, @tracks_duration, @tracks_release_date, @tracks_genre, @tracks_language);
END;

EXEC AddNewTrack 101, 51, 2, 52, 'New Track Title', 240, '2023-01-01', 'Pop', 'English';

SELECT * from tracks WHERE track_id = 101

-- Query 8: Procedure to delete a track from the tracks table 
GO
CREATE PROCEDURE DeleteTrack
    @track_id INT
AS
BEGIN
    DELETE FROM dbo.tracks
    WHERE track_id = @track_id;
END;

EXEC DeleteTrack 101;

SELECT * FROM tracks WHERE track_id = 101


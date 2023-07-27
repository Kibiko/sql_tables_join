DROP TABLE IF EXISTS castings;
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS directors; -- in this case, we have to drop the tables in the reverse order

CREATE TABLE directors( -- order matters, since directors is primary this table should come first
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE movies ( -- since movies references directors, this table comes second
    id SERIAL PRIMARY KEY, 
    title VARCHAR(255),
    duration INT,
    rating VARCHAR(255),
    director_id INT REFERENCES directors(id) -- foreign key which links to directors primary
);

CREATE TABLE actors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE castings ( -- join table that has two foreign keys to maintain many to many
    id SERIAL PRIMARY KEY, -- films have many actors and actors have many films
    movie_id INT REFERENCES movies(id),
    actor_id INT REFERENCES actors(id),
    character_name VARCHAR(255)
);

INSERT INTO directors(name) VALUES ('Ridley Scott');
INSERT INTO directors(name) VALUES ('Morten Tyldum');
INSERT INTO directors(name) VALUES ('Jon Favreau');
INSERT INTO directors(name) VALUES ('Steven Spielberg');
INSERT INTO directors (name) VALUES ('Anthony Russo');

INSERT INTO movies (title, duration, rating, director_id) VALUES ('Alien', 117, '18', 1);
INSERT INTO movies (title, duration, rating, director_id) VALUES ('The Imitation Game', 114, '12A', 2);
INSERT INTO movies (title, duration, rating, director_id) VALUES ('Iron Man', 126, '12A', 3);
INSERT INTO movies (title, duration, rating, director_id) VALUES ('The Martian', 144, '12A', 1);
INSERT INTO movies (title, duration, rating, director_id) VALUES ('Avengers: Endgame', 181, '12A', 5);
INSERT INTO movies (title, duration, rating, director_id) VALUES ('Interstellar', 169, '12A', null);

INSERT INTO actors (name) VALUES ('Sigourney Weaver');
INSERT INTO actors (name) VALUES ('Benedict Cumberbatch');
INSERT INTO actors (name) VALUES ('Robert Downey Jr');
INSERT INTO actors (name) VALUES ('Gwyneth Paltrow');
INSERT INTO actors (name) VALUES ('John Boyega');

INSERT INTO castings (movie_id, actor_id, character_name) VALUES (1, 1, 'Ripley');
INSERT INTO castings (movie_id, actor_id, character_name) VALUES (2, 2, 'Alan Turing');
INSERT INTO castings (movie_id, actor_id, character_name) VALUES (3, 3, 'Tony Stark');
INSERT INTO castings (movie_id, actor_id, character_name) VALUES (3, 4, 'Pepper Potts');
INSERT INTO castings (movie_id, actor_id, character_name) VALUES (5, 2, 'Dr Strange');
INSERT INTO castings (movie_id, actor_id, character_name) VALUES (5, 3, 'Tony Stark');
INSERT INTO castings (movie_id, actor_id, character_name) VALUES (5, 4, 'Pepper Potts');


SELECT a.name, c.character_name, m.title 
FROM actors AS a
INNER JOIN castings AS c
ON a.id = c.actor_id
INNER JOIN movies AS m
ON c.movie_id = m.id;
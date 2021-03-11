--#1
/*
List the films where the yr is 1962 [Show id, title]
*/
SELECT id, title
FROM movie
WHERE yr = 1962

--#2
/*
Give year of 'Citizen Kane'.
*/
SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

--#3
/*
List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
*/
SELECT id,title,yr
FROM movie
WHERE title LIKE 'Star Trek%'

--#4
/*
What id number does the actor 'Glenn Close' have?
*/
SELECT id
FROM actor
WHERE name = 'Glenn Close'


--#5
/*
What is the id of the film 'Casablanca'
*/
SELECT id
FROM movie
WHERE title = 'Casablanca'

--#6
/*
Obtain the cast list for 'Casablanca'.
what is a cast list?
Use movieid=11768 this is the value that you obtained in the previous question.
*/
SELECT name
FROM actor,casting
WHERE actor.id = casting.actorid AND movieid = (
SELECT id
FROM movie
WHERE title = 'Casablanca')


--#7
/*
Obtain the cast list for the film 'Alien'
*/
SELECT name
FROM actor,casting
WHERE actor.id = casting.actorid AND movieid = (
SELECT id
FROM movie
WHERE title = 'Alien')


--#8
/*
List the films in which 'Harrison Ford' has appeared
*/
SELECT title
FROM movie,casting
WHERE movie.id = casting.movieid AND casting.actorid = (
SELECT id
FROM actor
WHERE name = 'Harrison Ford')

--#9
/*
List the films where 'Harrison Ford' has appeared - but not in the star role.
[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
*/
SELECT title
FROM movie,casting
WHERE movie.id = casting.movieid AND casting.actorid = (
SELECT id
FROM actor
WHERE name = 'Harrison Ford') AND ord <>1

--#10
/*
List the films together with the leading star for all 1962 films.
*/
SELECT title,name
FROM actor,casting,movie
WHERE actor.id = casting.actorid AND movie.id=casting.movieid AND yr =1962 AND ord = 1


--#11
/*
Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.*/
SELECT yr,COUNT(title) 
FROM movie, casting,actor 
WHERE movie.id=movieid AND actorid=actor.id AND name='John Travolta'
GROUP BY yr
HAVING COUNT(title) > 1

--#12
/*
List the film title and the leading actor for all of the films 'Julie Andrews' played in.
*/
SELECT title , name
FROM casting,movie,actor
WHERE movie.id = casting.movieid AND 
      actor.id = casting.actorid AND
      ord = 1 AND movie.id IN (
SELECT movieid
FROM actor,casting
WHERE actor.name = 'Julie Andrews' AND
      actor.id = casting.actorid
)

--#13
/*
Obtain a list in alphabetical order of actors who've had at least 15 starring roles.
*/
SELECT name
FROM actor,casting
WHERE actor.id = casting.actorid AND 15<= (
SELECT COUNT(ord)
FROM casting
WHERE ord = 1 AND casting.actorid = id)
GROUP BY name
ORDER BY name

--#14
/*
List the films released in the year 1978 ordered by the number of actors in the cast.
*/
SELECT title,COUNT(name)
FROM movie,actor,casting
WHERE movie.id = casting.movieid AND
      actor.id = casting.actorid AND
      yr = 1978
GROUP BY title
ORDER BY COUNT(name) DESC,title

--#15
/*
List all the people who have worked with 'Art Garfunkel'.
*/
SELECT DISTINCT name
FROM movie,actor,casting
WHERE actor.name <> 'Art Garfunkel' AND
      movie.id = casting.movieid AND
      actor.id = casting.actorid AND
      movie.id IN (
SELECT movieid
FROM movie,actor,casting
WHERE movie.id = casting.movieid AND
      actor.id = casting.actorid AND
      actor.name = 'Art Garfunkel')
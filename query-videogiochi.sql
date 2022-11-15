--QUERY SELECT

--1- Selezionare tutte le software house americane (3)

--SELECT *
--FROM software_houses
--WHERE country = 'United States'

--2- Selezionare tutti i giocatori della città di 'Rogahnland' (2)

--SELECT *
--FROM players
--WHERE city = 'Rogahnland'

--3- Selezionare tutti i giocatori il cui nome finisce per "a" (220)

--SELECT *
--FROM players
--WHERE [name] LIKE '%a'

--4- Selezionare tutte le recensioni scritte dal giocatore con ID = 800 (11)

--SELECT *
--FROM reviews
--WHERE player_id = 800


--5- Contare quanti tornei ci sono stati nell'anno 2015 (9)

--SELECT count(*)
--FROM tournaments
--WHERE [year] = 2015

--6- Selezionare tutti i premi che contengono nella descrizione la parola 'facere' (2)

--SELECT *
--FROM awards
--WHERE [description] LIKE '%facere%'

--7- Selezionare tutti i videogame che hanno la categoria 2 (FPS) o 6 (RPG), mostrandoli una sola volta (del videogioco vogliamo solo l'ID) (287)

SELECT DISTINCT videogame_id
FROM category_videogame
WHERE category_id = 2 OR category_id = 6


--8- Selezionare tutte le recensioni con voto compreso tra 2 e 4 (2947)

--SELECT *
--FROM reviews
--WHERE rating >= 2 AND rating <= 4


--9- Selezionare tutti i dati dei videogiochi rilasciati nell'anno 2020 (46)

--SELECT *
--FROM videogames
--WHERE release_date LIKE '%2020%'

--10- Selezionare gli id dei videogame che hanno ricevuto almeno una recensione da 5 stelle, mostrandoli una sola volta (443)

--SELECT videogame_id
--FROM reviews
--WHERE rating = 5
--GROUP BY videogame_id

--*********** BONUS ***********

--11- Selezionare il numero e la media delle recensioni per il videogioco con ID = 412 (review number = 12, avg_rating = 3)

--SELECT Count(id), avg(rating)
--FROM reviews
--WHERE videogame_id = 412

--12- Selezionare il numero di videogame che la software house con ID = 1 ha rilasciato nel 2018 (13)

--SELECT COUNT(id)
--FROM videogames
--WHERE software_house_id = 1 
--AND DATEPART(year, release_date) = 2018


--QUERY CON GROUPBY

--1- Contare quante software house ci sono per ogni paese (3)

--SELECT count(*) as Qty_software_houses, country
--FROM software_houses
--GROUP BY country;

--2- Contare quante recensioni ha ricevuto ogni videogioco (del videogioco vogliamo solo l'ID) (500)

--SELECT videogame_id, count(id) as Qty_reviews
--FROM reviews
--GROUP BY videogame_id

--3- Contare quanti videogiochi hanno ciascuna classificazione PEGI (della classificazione PEGI vogliamo solo l'ID) (13)

--SELECT count(videogame_id) as Qty_videogame, pegi_label_id
--FROM pegi_label_videogame
--GROUP BY pegi_label_id

--4- Mostrare il numero di videogiochi rilasciati ogni anno (11)

--SELECT count(id) as Qty_videogame, datepart(year, release_date)
--FROM videogames
--GROUP BY datepart(year,release_date);

--5- Contare quanti videogiochi sono disponbiili per ciascun device (del device vogliamo solo l'ID) (7)

--SELECT COUNT(videogame_id), device_id
--FROM device_videogame
--GROUP BY device_id

--6- Ordinare i videogame in base alla media delle recensioni (del videogioco vogliamo solo l'ID) (500)

--SELECT videogame_id, avg(rating) as media_recensioni
--FROM reviews
--GROUP BY videogame_id
--ORDER BY media_recensioni ASC

--QUERY CON JOIN

--1- Selezionare i dati di tutti giocatori che hanno scritto almeno una recensione, mostrandoli una sola volta (996)

--SELECT players.id, players.[name]
--FROM players
--INNER JOIN reviews
--on players.id = reviews.player_id
--GROUP BY players.id, players.[name]


--2- Sezionare tutti i videogame dei tornei tenuti nel 2016, mostrandoli una sola volta (226)

--SELECT tournament_videogame.videogame_id, videogames.[name]
--FROM videogames
--INNER JOIN tournament_videogame
--on tournament_videogame.videogame_id = videogames.id
--INNER JOIN tournaments
--on tournaments.id = tournament_videogame.tournament_id
--WHERE tournaments.[year] LIKE '2016'
--GROUP BY tournament_videogame.videogame_id, videogames.[name]


--3- Mostrare le categorie di ogni videogioco (1718)

--SELECT categories.[name] as category_name, videogames.id as id_videogame
--FROM categories
--INNER JOIN category_videogame
--on category_videogame.category_id = categories.id
--INNER JOIN videogames
--on videogames.id = category_videogame.videogame_id

--4- Selezionare i dati di tutte le software house che hanno rilasciato almeno un gioco dopo il 2020, mostrandoli una sola volta (6)

--SELECT DISTINCT software_houses.id as sh_name
--FROM software_houses
--INNER JOIN videogames
--on videogames.software_house_id = software_houses.id
--WHERE DATEPART(year, release_date) = 2020


--5- Selezionare i premi ricevuti da ogni software house per i videogiochi che ha prodotto (55)

--SELECT awards.[name], software_houses.[name], videogames.[name]
--FROM software_houses
--INNER JOIN videogames
--on videogames.software_house_id = software_houses.id
--INNER JOIN award_videogame
--on award_videogame.videogame_id = videogames.id
--INNER JOIN awards
--on awards.id = award_videogame.award_id

--6- Selezionare categorie e classificazioni PEGI dei videogiochi che hanno ricevuto recensioni da 4 e 5 stelle, mostrandole una sola volta (3363)

--SELECT DISTINCT categories.[name], pegi_labels.[name], videogames.[name]
--FROM videogames
--INNER JOIN category_videogame
--on category_videogame.videogame_id = videogames.id
--INNER JOIN pegi_label_videogame
--on pegi_label_videogame.videogame_id = videogames.id
--INNER JOIN categories
--on categories.id = category_videogame.category_id
--INNER JOIN pegi_labels
--on pegi_labels.id = pegi_label_videogame.pegi_label_id
--INNER JOIN reviews
--on reviews.videogame_id = videogames.id

--WHERE reviews.rating >= 4 


--7- Selezionare quali giochi erano presenti nei tornei nei quali hanno partecipato i giocatori il cui nome inizia per 'S' (474)


--SELECT DISTINCT videogames.id, videogames.[name]
--FROM videogames

---- tournament_videogame
--INNER JOIN tournament_videogame
--on tournament_videogame.videogame_id = videogames.id

---- tournament
--INNER JOIN tournaments
--on tournaments.id = tournament_videogame.tournament_id

----player_tournament
--INNER JOIN player_tournament
--on player_tournament.tournament_id = tournaments.id

----player
--INNER JOIN players
--on players.id = player_tournament.player_id

--WHERE players.[name] LIKE 's%'


--8- Selezionare le città in cui è stato giocato il gioco dell'anno del 2018 (36)

--SELECT DISTINCT tournaments.city
--FROM tournaments

----tournament_videogame
--INNER JOIN tournament_videogame
--on tournament_videogame.tournament_id = tournaments.id

----videogames
--INNER JOIN videogames
--on videogames.id = tournament_videogame.videogame_id

----award_videogame
--INNER JOIN award_videogame
--on award_videogame.videogame_id = videogames.id

----awards
--INNER JOIN awards
--on awards.id = award_videogame.award_id

--WHERE award_videogame.[year] = '2018'
--AND awards.id = 1



--9- Selezionare i giocatori che hanno giocato al gioco più atteso del 2018 in un torneo del 2019 (3306)

--SELECT players.*, tournaments.[name]
--FROM tournaments

----players_videogame
--INNER JOIN player_tournament
--on player_tournament.tournament_id = tournaments.id

----players
--INNER JOIN players
--on players.id = player_tournament.player_id

----tournament_videogame
--INNER JOIN tournament_videogame
--on tournament_videogame.tournament_id = tournaments.id

----videogames
--INNER JOIN videogames
--on videogames.id = tournament_videogame.videogame_id

----award_videogame
--INNER JOIN award_videogame
--on award_videogame.videogame_id = videogames.id

----awards
--INNER JOIN awards
--on award_videogame.award_id = awards.id

--WHERE awards.id = 5 
--AND award_videogame.[year] = '2018'
--AND tournaments.[year] = '2019'



--*********** BONUS ***********

--10- Selezionare i dati della prima software house che ha rilasciato un gioco, assieme ai dati del gioco stesso (software house id : 5)

--SELECT TOP 1 software_houses.*, videogames.[name]
--FROM videogames

--INNER JOIN software_houses
--on software_houses.id = videogames.software_house_id

--ORDER BY videogames.release_date 


--11- Selezionare i dati del videogame (id, name, release_date, totale recensioni) con più recensioni (videogame id : 398)

--SELECT TOP 1 videogames.id, videogames.[name], videogames.release_date, count(reviews.id) as Qty_reviews
--FROM videogames

--INNER JOIN reviews
--on reviews.videogame_id = videogames.id


--GROUP BY videogames.id, videogames.[name], videogames.release_date

--ORDER BY Qty_reviews DESC



--12- Selezionare la software house che ha vinto più premi tra il 2015 e il 2016 (software house id : 1)


--SELECT TOP 1 software_houses.id, software_houses.[name], count(*) as Qty_awards 

--FROM software_houses

----videogames
--INNER JOIN videogames
--on software_houses.id = videogames.software_house_id

----award_videogame
--INNER JOIN award_videogame
--on videogames.id = award_videogame.videogame_id

----awards
--INNER JOIN awards
--on award_videogame.award_id = awards.id

--WHERE award_videogame.[year] <= 2015 AND award_videogame.[year] <= 2016

--GROUP BY software_houses.id, software_houses.[name]

--ORDER BY Qty_awards DESC



--13- Selezionare le categorie dei videogame i quali hanno una media recensioni inferiore a 1.5 (10)

SELECT categories.[name], avg(reviews.rating) as avg_reviews
FROM categories

--category_videogame
INNER JOIN category_videogame
on category_videogame.category_id = categories.id

--videogames
INNER JOIN videogames
on videogames.id = category_videogame.videogame_id

--reviews
INNER JOIN reviews
on reviews.videogame_id = videogames.id

GROUP BY categories.[name]

ORDER BY avg_reviews
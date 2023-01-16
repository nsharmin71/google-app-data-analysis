SELECT * FROM my_new_work.lets_see;
-- Q1
-- Which apps have the highest rating in the given available dataset?

SELECT DISTINCT App, 
       Rating
FROM my_new_work.lets_see
WHERE Rating >= 5.0;

-- Q2
-- What are the number of installs and reviews for the above apps? 
-- Return the apps with the highest reviews to the top.
SELECT DISTINCT App, 
       Installs,
       Reviews
FROM my_new_work.lets_see
WHERE Rating >= 5.0
ORDER BY Reviews DESC;

-- Q3
-- Which app has the highest number of reviews? Also,
-- mention the number of reviews and category of the app
SELECT DISTINCT App, 
       Category, 
       Reviews
FROM my_new_work.lets_see
ORDER BY Reviews desc
LIMIT 1;

-- Q4
-- What is the total amount of revenue generated by the google play store 
-- by hosting apps? (Whenever a user buys apps from the google play store,
-- the amount is considered in the revenue)


SELECT SUM(Price*Installs) as total_rev
FROM my_new_work.lets_see
WHERE Price != 0 AND Type = 'Paid';

-- Q5
-- Which Category of google play store apps has the highest number of installs?
--  also, find out the total number of installs for that particular category.

SELECT DISTINCT Category,
	   SUM(Installs) OVER(PARTITION BY Category)  AS high_cat_install
FROM my_new_work.lets_see
ORDER BY high_cat_install DESC
;

-- Q6
-- Which Genre has the most number of published apps?

SELECT DISTINCT Genres,
	   COUNT(App) OVER(PARTITION BY Genres) AS app_by_genre
FROM my_new_work.lets_see
ORDER BY app_by_genre DESC
;

-- Q7
-- Provide the list of all games ordered in such a way that the game that has
-- the highest number of installs is displayed on the top 
-- (to avoid duplicate results, use distinct)

SELECT DISTINCT App, 
       Category, 
       Installs, 
       DENSE_RANK() OVER(ORDER BY Installs DESC) AS ranking
FROM my_new_work.lets_see
WHERE Category = 'GAME'
;

-- Q8
-- Provide the list of apps that can work on android version 4.0.3 and UP.
SELECT App, 
       Android_Ver
FROM my_new_work.lets_see
WHERE Android_Ver like '%4 0 3 and up%'
;

-- Q9
-- How many apps from the given data set are free? Also, provide the number of paid apps.

SELECT 
	   SUM(CASE WHEN Type = 'Free' THEN 1 ELSE 0 END) AS number_of_free,
       SUM(CASE WHEN Type = 'Paid' THEN 1 ELSE 0 END) AS number_of_paid
FROM my_new_work.lets_see;


-- Q10
-- Which is the best dating app? (Best dating app is the one having the highest number of Reviews)

SELECT DISTINCT App, 
       DENSE_RANK() OVER(ORDER BY Reviews DESC) AS ranking,
       Reviews
FROM my_new_work.lets_see
WHERE Category = 'DATING'
GROUP BY App, Category, Reviews;

-- Q11
-- 11.	Get the number of reviews having positive sentiment and the number of reviews having 
-- negative sentiment for the app 10 best foods for you and compare them.

SELECT App,
       SUM(CASE WHEN Sentiment = 'Positive' THEN 1 ELSE 0 END) AS pos_review,
       SUM(CASE WHEN Sentiment = 'Negative' THEN 1 ELSE 0 END) AS neg_review
FROM my_new_work.lets_review
WHERE App = '10 Best Foods for you';

-- Q12
-- 12.	Which comments of ASUS SuperNote have sentiment polarity
--  and sentiment subjectivity both as 1?

SELECT Translated_Review, 
	   App,
       Sentiment_Polarity,
       Sentiment_Subjectivity
FROM my_new_work.lets_review
WHERE App = 'ASUS SuperNote'
AND Sentiment_Polarity = 1
AND Sentiment_Subjectivity = 1;

-- Q13
-- Get all the neutral sentiment reviews for the app Abs Training-Burn belly fat 

SELECT App,
	   Translated_Review,
	   Sentiment
FROM my_new_work.lets_review
WHERE App = 'Abs Training Burn belly fat' AND Sentiment = 'Neutral';

-- Q14
-- Extract all negative sentiment reviews for Adobe Acrobat Reader 
-- with their sentiment polarity and sentiment subjectivity

SELECT 
	   ROW_NUMBER() OVER(ORDER BY App ASC) AS indx,
	   App,
	   Translated_Review,
	   Sentiment_Polarity,
       Sentiment_Subjectivity,
       Sentiment
FROM my_new_work.lets_review
WHERE App = 'Adobe Acrobat Reader' AND Sentiment = 'Negative';






-- App, Translated_Review, Sentiment, Sentiment_Polarity, Sentiment_Subjectivity


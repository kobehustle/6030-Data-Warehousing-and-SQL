use njfinal_game;

-- checking whole dataset
SELECT * FROM game;
SELECT * FROM critic_review;
SELECT * FROM platform;
SELECT * FROM sales;
SELECT * FROM user_review;

-- check the dataset for Developer table which is not 1NF
SELECT Developer_name 
FROM developer
WHERE developer_name LIKE '%Budcat%';

-- check the dataset for Developer table which is not 1NF
SELECT Developer_name 
FROM developer
WHERE developer_name LIKE '%Neversoft%';

SELECT * FROM game;

-- making primary key for game
ALTER TABLE `njfinal_game`.`game` 
CHANGE COLUMN `Game_id` `Game_id` INT(11) NOT NULL ,
ADD PRIMARY KEY (`Game_id`);
;

-- making primary key for sales table
ALTER TABLE sales
ADD COLUMN sales_id INT NOT NULL auto_increment Primary Key;

-- chaning the order in sales table
ALTER TABLE sales
MODIFY COLUMN sales_id INT FIRST;

-- making primary key for user_review table
ALTER TABLE user_review
ADD COLUMN user_review_id INT NOT NULL auto_increment Primary Key;

-- chaning the order in user_review table
ALTER TABLE user_review
MODIFY COLUMN user_review_id INT FIRST;

-- making primary key for critic_review
ALTER TABLE critic_review
ADD COLUMN critic_review_id INT NOT NULL auto_increment Primary Key;

-- chaning the order in user_review table
ALTER TABLE critic_review
MODIFY COLUMN critic_review_id INT FIRST;

SELECT * FROM platform;

-- making primary key for platform table
ALTER TABLE platform
ADD COLUMN platform_id INT NOT NULL auto_increment Primary Key;

-- chaning the order in platform table
ALTER TABLE platform
MODIFY COLUMN platform_id INT FIRST;

-- making developer_id as primary key 
ALTER TABLE `njfinal_game`.`developer` 
CHANGE COLUMN `Developer_id` `Developer_id` INT(11) NOT NULL ,
ADD PRIMARY KEY (`Developer_id`);

-- add sales_id as foreign key
ALTER TABLE game
ADD sales_id INT;

SET SQL_SAFE_UPDATES = 0;

-- set game_id = sales_id 
UPDATE game
SET sales_id = game_id
WHERE game_id IS NOT NULL;

-- change the order of sales_id in game table
ALTER TABLE game
MODIFY COLUMN sales_id INT AFTER game_id;

-- assign sales_id as foreign key in game table
ALTER TABLE game
ADD FOREIGN KEY (sales_id) REFERENCES sales(sales_id);

-- add critic_review_id as foreign key
ALTER TABLE game
ADD critic_review_id INT;

SET SQL_SAFE_UPDATES = 0;

-- SET game_id = critic_review_id
UPDATE game
SET critic_review_id = game_id
WHERE game_id IS NOT NULL;

-- change the order of sales_id in game table
ALTER TABLE game
MODIFY COLUMN critic_review_id INT AFTER sales_id;

-- critic_review_id as Foreign Key
ALTER TABLE game
ADD FOREIGN KEY (critic_review_id) REFERENCES critic_review(critic_review_id);

-- add user_review_id as foreign key
ALTER TABLE game
ADD user_review_id INT;

SET SQL_SAFE_UPDATES = 0;

UPDATE game
SET user_review_id = game_id
WHERE game_id IS NOT NULL;

ALTER TABLE game
MODIFY COLUMN user_review_id INT AFTER critic_review_id;

ALTER TABLE game
ADD FOREIGN KEY (user_review_id) REFERENCES user_review(user_review_id);

-- add game table foreign key developer_id 
ALTER TABLE game ADD COLUMN developer_id INT;

-- change the location
ALTER TABLE game
MODIFY COLUMN developer_id INT AFTER user_review_id;

-- update developer_id in game table assigned by developer_name in developer table
UPDATE game g
INNER JOIN developer d ON g.developer = d.developer_name
SET g.developer_id = d.developer_id;

-- developer_id as foreign key in game table
ALTER TABLE game
ADD CONSTRAINT developer_id
FOREIGN KEY (developer_id) REFERENCES developer(developer_id);

-- add game table foreign key platform_id
ALTER TABLE game ADD COLUMN platform_id INT;

-- change the position of platform_id in game table
ALTER TABLE game
MODIFY COLUMN platform_id INT AFTER developer_id;

-- ALTER platform into platform_name in platform table
ALTER TABLE platform
CHANGE COLUMN platform platform_name VARCHAR(100) NOT NULL;

-- Assign platform_id in game table matching with platform_name in platform table
UPDATE game g
INNER JOIN platform p ON g.platform = p.platform_name
SET g.platform_id = p.platform_id;

-- Platform_id as foreign Key for game table
ALTER TABLE game
ADD CONSTRAINT platform_id
FOREIGN KEY (platform_id) REFERENCES platform(platform_id);

-- check critic_review table with null value
SELECT * FROM critic_review
WHERE critic_score IS NULL; 

-- check user_review table with null value
SELECT COUNT(*) FROM user_review;
SELECT COUNT(*) FROM game;

SELECT * FROM user_review
WHERE user_score IS NULL; 

-- alter type as int in user_review
ALTER TABLE user_review
MODIFY COLUMN user_score INT;

-- alter type as int
ALTER TABLE user_review
MODIFY COLUMN user_count INT;

-- alter type as int in critic_review
ALTER TABLE critic_review
MODIFY COLUMN critic_score INT;

-- alter type as int
ALTER TABLE critic_review
MODIFY COLUMN critic_count INT;

-- ALTER developer table
SELECT * FROM developer;

-- had to delete
-- had to delete
ALTER TABLE game
DROP FOREIGN KEY developer_id;

ALTER TABLE game
DROP COLUMN developer_id;
-- had to delete
-- had to delete

-- checking the number of comma
SELECT 
    developer_id, 
    developer_name, 
    LENGTH(developer_name) - LENGTH(REPLACE(developer_name, ',', '')) AS comma_count
FROM 
    developer
ORDER BY 3 DESC;

-- ADD COLUMN as developer1, developer2, developer3
ALTER TABLE developer
ADD COLUMN developer1 VARCHAR(255),
ADD COLUMN developer2 VARCHAR(255),
ADD COLUMN developer3 VARCHAR(255),
ADD COLUMN developer4 VARCHAR(255);

-- Diasable safe update mode
SET SQL_SAFE_UPDATES = 0;

UPDATE developer
SET 
    developer1 = SUBSTRING_INDEX(developer_name, ',', 1),
    developer2 = CASE 
        WHEN LENGTH(developer_name) - LENGTH(REPLACE(developer_name, ',', '')) >= 1 THEN 
            SUBSTRING_INDEX(SUBSTRING_INDEX(developer_name, ',', 2), ',', -1)
        ELSE NULL 
    END,
    developer3 = CASE 
        WHEN LENGTH(developer_name) - LENGTH(REPLACE(developer_name, ',', '')) >= 2 THEN 
            SUBSTRING_INDEX(SUBSTRING_INDEX(developer_name, ',', 3), ',', -1)
        ELSE NULL 
    END,
    developer4 = CASE 
        WHEN LENGTH(developer_name) - LENGTH(REPLACE(developer_name, ',', '')) = 3 THEN 
            SUBSTRING_INDEX(developer_name, ',', -1)
        ELSE NULL 
    END;
    
-- disable safe update mode
SET SQL_SAFE_UPDATES = 0;
    
-- checking the Developer4
SELECT * FROM developer
WHERE developer3 IS NOT NULL;
    
-- about developer 3 
-- delete the Inc. in developer3
UPDATE developer
SET developer3 = CASE
    WHEN developer3 = ' Inc.' THEN NULL
    WHEN developer3 = ' Inc' THEN NULL
    WHEN developer3 = ' Ltd.' THEN NULL
    WHEN developer3 = ' LDA' THEN NULL
    WHEN developer3 = ' LLC' THEN NULL
    ELSE developer3
END;

-- delete the Inc. in developer2
UPDATE developer
SET developer2 = CASE
    WHEN developer2 = ' Inc.' THEN NULL
    WHEN developer2 = ' Inc' THEN NULL
    WHEN developer2 = ' Ltd.' THEN NULL
    WHEN developer2 = ' LDA' THEN NULL
    WHEN developer2 = ' LLC' THEN NULL
    ELSE developer2
END;

-- update table which is in developer2 is NULL but developer3 is not NULL, move developer3 to developer2
UPDATE developer
SET developer2 = CASE
    WHEN developer2 IS NULL AND developer3 IS NOT NULL THEN developer3
    ELSE developer2
END;

-- finally drop developer_name table 
ALTER TABLE developer
DROP COLUMN developer_name;
    
SELECT * FROM game;

-- dropping developer column in game 
ALTER TABLE game 
DROP COLUMN developer;

-- dropping developer column in game 
ALTER TABLE game 
DROP COLUMN platform;

-- Which gaming platform has the largest number of games available?
WITH CTE AS 
(
SELECT p.platform_name, COUNT(g.platform_id) AS cnt
FROM game g
INNER JOIN platform p USING (platform_id)
GROUP BY platform_id)

SELECT 
	p.released_year as platform_released_year,
	c.platform_name, 
    cnt AS number_of_games
FROM CTE c
INNER JOIN platform p USING (platform_name)
ORDER BY cnt DESC;

-- MAX and MIN Year_of_Release 
SELECT 
	MAX(Year_of_Release) AS latest,
    MIN(Year_of_Release) AS oldest
FROM game;

-- platform year 
SELECT * FROM platform;

-- Which gaming platform has the largest number of games available after 2012?
WITH CTE AS 
(
SELECT p.platform_name, COUNT(g.platform_id) AS cnt
FROM game g
INNER JOIN platform p USING (platform_id)
WHERE g.Year_of_Release > 2012
GROUP BY platform_id)

SELECT 
	p.released_year as platform_released_year,
	c.platform_name, 
    cnt AS number_of_games
FROM CTE c
INNER JOIN platform p USING (platform_name)
ORDER BY cnt DESC;

-- Which gaming platform has the highest total sales?
-- checking sales columns 
SELECT * FROM sales;

-- WITH CTE for platform and final results
WITH CTE AS 
(
SELECT  
	b.platform_name,
    ROUND(SUM(c.global_sales), 2) as total_sales
FROM game a
INNER JOIN platform b USING (platform_id)
INNER JOIN sales c USING (sales_id)
GROUP BY b.platform_name
)

SELECT 
	p.released_year as platform_released_year,
    c.platform_name, 
    c.total_sales
FROM CTE c
INNER JOIN platform p USING (platform_name)
ORDER BY 3 DESC;

-- What are the average sales figures for each gaming platform?
WITH CTE AS 
(
SELECT  
	b.platform_name,
    ROUND(AVG(c.global_sales), 2) as average_sales
FROM game a
INNER JOIN platform b USING (platform_id)
INNER JOIN sales c USING (sales_id)
GROUP BY b.platform_name
)

SELECT 
    platform_name, 
    average_sales
FROM CTE
ORDER BY 2 DESC;

-- Which game genre has the highest total sales average?
WITH CTE AS 
(
SELECT  
	g.genre,
    ROUND(AVG(s.global_sales), 2) as genre_avg_sales
FROM game g
INNER JOIN sales s USING (sales_id)
GROUP BY g.genre
)

SELECT * 
FROM CTE
ORDER BY genre_avg_sales DESC;

-- Comparison of the top 10 games by critic score and the top 10 games by user score, along with their sales figures.
-- Top 10 game by critic score 
WITH CTE AS (
    SELECT     
        g.name,
        u.user_score,
        ROW_NUMBER() OVER (ORDER BY u.user_score DESC) AS rn
    FROM game g
    INNER JOIN user_review u USING (user_review_id)
    LIMIT 10
),
CTE2 AS (
    SELECT 
        g.name,
        c.critic_score,
        ROW_NUMBER() OVER (ORDER BY c.critic_score DESC) AS rn
    FROM game g
    INNER JOIN critic_review c USING (critic_review_id)
    LIMIT 10
)
SELECT
    c1.name AS game,
    c1.user_score AS u_score,
    c2.name AS game,
    c2.critic_score AS c_score
FROM CTE c1
INNER JOIN CTE2 c2 ON c1.rn = c2.rn;


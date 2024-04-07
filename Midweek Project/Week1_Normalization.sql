
DROP DATABASE IF EXISTS `recipes`;
CREATE DATABASE  IF NOT EXISTS `recipes`;
USE `recipes`;


--
-- Table structure for table `recipe_main`
--

DROP TABLE IF EXISTS `recipe_main`;
CREATE TABLE `recipe_main` (
  `recipe_id` int(11) NOT NULL AUTO_INCREMENT,
  `rec_title` varchar(255) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `recipe_desc` varchar(1024) DEFAULT NULL,
  `prep_time` int(11) DEFAULT NULL,
  `cook_time` int(11) DEFAULT NULL,
  `servings` int(11) DEFAULT NULL,
  `difficulty` int(11) DEFAULT NULL,
  `directions` varchar(4096) DEFAULT NULL,
  PRIMARY KEY (`recipe_id`),
  KEY `recipe_title_idx` (`rec_title`),
  KEY `prep_time_idx` (`prep_time`),
  KEY `cook_time_idx` (`cook_time`),
  KEY `difficulty_idx` (`difficulty`),
  KEY `FK_category_id_idx` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `recipe_main`
--

LOCK TABLES `recipe_main` WRITE;
INSERT INTO `recipe_main` VALUES (1,'Chicken Marsala',1,'Chicken and mushrooms',20,20,4,2,'Flatten chicken breats to 1/4 inch. Place flour in a resealable plastic bag with two pieces of chicken at a time and shake to coat.Cook chicken in olive oil in a large skillet over medium heat for 3-5 minutes on each side or until the meat reaches a temparature of 170°. Remove chicken from skillet and keep warm.Use the same skillet to saute the mushrooms in butter until tender. Add the wine, parsley and rosemary. Bring mixture to a boil and cook until liquid is reduced by half. Serve chicken with mushroom sauce; sprinkle with cheese if desired.'),(2,'Absolute Brownies',2,'Rich, chcolate brownies',25,35,16,2,'Preheat oven to 350 degrees F (175 degrees C). Grease and flour an 8 inch square pan.In a large saucepan, melt 1/2 cup butter. Remove from heat, and stir in sugar, eggs, and 1 teaspoon vanilla. Beat in 1/3 cup cocoa, 1/2 cup flour, salt, and baking powder. Spread batter into prepared pan.Bake in preheated oven for 25 to 30 minutes. Do not overcook.To Make Frosting: Combine 3 tablespoons butter, 3 tablespoons cocoa, 1 tablespoon honey, 1 teaspoon vanilla, and 1 cup confectioners sugar. Frost brownies while they are still warm.');
UNLOCK TABLES;

--
-- Table structure for table `rec_ingredients`
--

DROP TABLE IF EXISTS `rec_ingredients`;
CREATE TABLE `rec_ingredients` (
  `rec_ingredient_id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(11) NOT NULL,
  `amount` decimal(6,2) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  PRIMARY KEY (`rec_ingredient_id`),
  KEY `FK_ingredient_recipe_id_idx` (`recipe_id`),
  KEY `FK_recipe_ingredient_id_idx` (`ingredient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;


LOCK TABLES `rec_ingredients` WRITE;
INSERT INTO `rec_ingredients` VALUES (1,1,4.00,1),(2,1,2.00,2),(3,1,2.00,3),(4,1,2.00,4),(5,1,2.00,5),(6,1,0.75,6),(7,1,0.25,8),(8,1,2.00,9),(9,1,2.00,10),(10,2,0.50,3),(11,2,1.00,11),(12,2,2.00,12),(13,2,1.00,13),(14,2,0.33,14),(15,2,0.50,2),(16,2,0.25,15);
UNLOCK TABLES;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
CREATE TABLE `ingredients` (
  `ingredient_id` int(11) NOT NULL AUTO_INCREMENT,
  `ingred_name` varchar(75) NOT NULL,
  PRIMARY KEY (`ingredient_id`),
  KEY `ingredient_name_idx` (`ingred_name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
INSERT INTO `ingredients` VALUES (1,'Chicken breast halves, boneless'),(2,'Flour'),(3,'Olive oil'),(4,'Sliced mushrooms'),(5,'Butter'),(6,'Marsala wine'),(7,'Chicken broth'),(8,'Rosemary, dried and crushed'),(9,'Parsley, minced'),(10,'Parmesan cheese, grated'),(11,'White sugar'),(12,'Egg(s)'),(13,'Vanilla extract'),(14,'Unsweetened cocoa powder'),(15,'Salt'),(16,'Baking powder'),(17,'Butter, softened'),(18,'Honey'),(19,'Sugar, confectioners');
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  KEY `category_name_idx` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
INSERT INTO `categories` VALUES (1,'Entree'),(2,'Desserts');
UNLOCK TABLES;

SELECT * 
FROM recipe_main;

SELECT * 
FROM rec_ingredients;

SELECT * 
FROM ingredients;

-- Lasagna and Korean short ribs are added in 'recipe_main' column  
INSERT INTO `recipe_main` VALUES (3,'Easy Lasagna',3,'Cheese and meat sauce',10,30,8,1,'poon meat sauce on the bottom of a lightly greased casserole dish. Add 4 boiled lasagna noodles (or use no-boil or fresh noodles). Spread 1/3 of the ricotta cheese mixture on top. Add 1.5 cups of meat sauce. Top with mozzarella cheese. Cover and bake at 375° for 30 minutes. Remove cover and bake for 15 more minutes. Broil at the end if desired. Let it rest for 15 minutes prior to serving with Garlic Bread With Cheese.');
INSERT INTO `recipe_main` VALUES (4,'Korean short ribs',4,'Beef short ribs and soy sauce',5,10,4,1,'Before cooking your short ribs in the air fryer, make sure to defrost them. This is easy to do in a bowl of cold water for 10 – 15 minutes (do not open the plastic bag if using the water to defrost). The time you cook your short ribs in the air fryer will depend on your air fryer model and how thick the meat is. Cooked at 400 degrees F, they should be ready in 15 minutes. Korean short ribs cook very quickly, so keep an eye on them so they don’t overcook.');

-- Add ingredients for Lasagna 
INSERT INTO `ingredients` 
VALUES 
(20, 'Ricotta Cheese'), 
(21, 'Meat Sauce'), 
(22, 'Mozzarella Cheese');

-- Add rec_ingredients for Lasagna 
INSERT INTO `rec_ingredients` 
VALUES 
(20, 3, 4, 20),  
(21, 3, 3, 21),  
(22, 3, 4, 22);

-- Add ingredients for Korean short ribs 
INSERT INTO `ingredients` 
VALUES 
(23, 'Beef short ribs'), 
(24, 'Soy Sauce');

-- Add rec_ingredients for Korean short ribs 
INSERT INTO `rec_ingredients` 
VALUES 
(23, 4, 5, 23),  
(24, 4, 6, 24);

-- insert categories 
INSERT INTO `categories` VALUES (3,'Entree'),(4,'Main');

-- all the information on only the two new recipes
SELECT *

FROM recipes.recipe_main AS m
INNER JOIN  recipes.categories AS c
ON m.category_id=c.category_id 
INNER JOIN recipes.rec_ingredients AS r
ON m.recipe_id=r.recipe_id 
INNER JOIN recipes.ingredients AS i
ON r.ingredient_id=i.ingredient_id 
WHERE m.recipe_id=3 OR m.recipe_id=4;

-- specific columns in our table
SELECT m.rec_title, c.category_name, i.ingred_name, r.amount
FROM recipes.recipe_main AS m
INNER JOIN  recipes.categories AS c
ON m.category_id=c.category_id 
INNER JOIN recipes.rec_ingredients AS r
ON m.recipe_id=r.recipe_id 
INNER JOIN recipes.ingredients AS i
ON r.ingredient_id=i.ingredient_id 
ORDER BY 2 DESC, 1 ASC, 3 DESC;


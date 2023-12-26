/* Business model Customer to Customer (C2C) allows customers to do business with each other.
This model is growing fast with e-commerce platforms where sellers may be required to pay some amount and
buyer can buy it without paying anything. E-Commerce website brings the seller and buyer to the same platform. 

Analyzing the user's database will lead to understanding the business perspective.
Behaviour of the users can be traced in terms of business with exploration of the user’s database. 

Dataset: One .csv file with name users_data with 98913 rows and 27 columns

Tasks to be performed

Create new schema as ecommerce
Import .csv file users_data into MySQL
(right click on ecommerce schema -> Table Data import Wizard -> Give path of the file -> Next -> choose options : Create a new table , select delete if exist -> next -> next)
Run SQL command to see the structure of table
Run SQL command to select first 100 rows of the database
How many distinct values exist in table for field country and language
Check whether male users are having maximum followers or female users.
Calculate the total users those
	Uses Profile Picture in their Profile
	Uses Application for Ecommerce platform
	Uses Android app
	Uses ios app
Calculate the total number of buyers for each country and sort the result in descending order of total number of buyers. (Hint: consider only those users having at least 1 product bought.)
Calculate the total number of sellers for each country and sort the result in ascending order of total number of sellers. (Hint: consider only those users having at least 1 product sold.)
Display name of top 10 countries having maximum products pass rate.
Calculate the number of users on an ecommerce platform for different language choices.
Check the choice of female users about putting the product in a wishlist or to like socially on an ecommerce platform. (Hint: use UNION to answer this question.)
Check the choice of male users about being seller or buyer. (Hint: use UNION to solve this question.)
Which country is having maximum number of buyers?
List the name of 10 countries having zero number of sellers.
Display record of top 110 users who have used ecommerce platform recently.
Calculate the number of female users those who have not logged in since last 100 days.
Display the number of female users of each country at ecommerce platform.
Display the number of male users of each country at ecommerce platform.
Calculate the average number of products sold and bought on ecommerce platform by male users for each country
*/

-- Ques1
CREATE DATABASE ecommerce;
USE ecommerce;

-- Ques2
-- data imported
SELECT * FROM users_data;

-- Ques3
DESC users_data;

-- Ques4 
SELECT * FROM users_data LIMIT 100;

-- Ques5 
SELECT COUNT(DISTINCT country) Distinct_country, COUNT(DISTINCT language) Distinct_language FROM users_data;

-- Ques6
SELECT SUM(socialNbFollowers) Total_Followers, gender FROM users_data GROUP BY gender;

-- Ques7
-- a. 
	SELECT COUNT(*) Has_ProfilePic FROM users_data WHERE hasProfilePicture = 'TRUE';
-- b.
	SELECT COUNT(*) Uses_Application FROM users_data WHERE hasAnyApp = 'TRUE';
-- c.
	SELECT COUNT(*) Has_AndroidApp FROM users_data WHERE hasAndroidApp = 'TRUE';
-- d.
	SELECT COUNT(*) Has_IosApp FROM users_data WHERE hasIosApp = 'TRUE';
    
-- Ques8
SELECT country, COUNT(country) Total_buyers FROM users_data WHERE productsBought >= 1 GROUP BY country ORDER BY Total_buyers DESC;

-- Ques9
SELECT country, COUNT(country) Total_seller FROM users_data WHERE productsSold >= 1 GROUP BY country ORDER BY Total_seller ASC;

-- Ques10
SELECT country, MAX(productsPassRate) PassRate FROM users_data GROUP BY country ORDER BY PassRate DESC LIMIT 10;

-- Ques11
SELECT language, COUNT(language) Total_Users FROM users_data GROUP BY language;

-- Ques12
SELECT 'Products_liked', COUNT(socialProductsLiked) FROM users_data WHERE gender='F' AND socialProductsLiked > 0
UNION
SELECT 'Products_wished', COUNT(productsWished) FROM users_data WHERE gender='F' AND productsWished > 0 ;

-- Ques13
SELECT 'Seller', COUNT(productsSold) FROM users_data WHERE gender='M' AND productsSold > 0
UNION 
SELECT 'Buyer', COUNT(productsBought) FROM users_data WHERE gender='M' AND productsBought > 0 ;

-- Ques14
SELECT country, COUNT(productsBought) Total_users FROM users_data WHERE productsBought>=1 GROUP BY country ORDER BY Total_users DESC LIMIT 1;

-- Ques15
SELECT country, productsSold FROM users_data WHERE productsSold=0 GROUP BY country LIMIT 10;

-- Ques16
SELECT identifierHash FROM users_data ORDER BY daysSinceLastLogin LIMIT 110;

-- Ques17
SELECT identifierHash FROM users_data WHERE gender = 'F' AND daysSinceLastLogin >= 100 ORDER BY daysSinceLastLogin;

-- Ques18
SELECT country, COUNT(gender) Female_Users FROM users_data WHERE gender='F' GROUP BY country;

-- Ques19
SELECT country, COUNT(gender) Male_Users FROM users_data WHERE gender='M' GROUP BY country;

-- Ques20
SELECT country, AVG(productsSold), AVG(productsBought) FROM users_data WHERE gender='M' GROUP BY country;
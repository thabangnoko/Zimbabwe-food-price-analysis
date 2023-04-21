/* Zimbabwe Food Prices
  
  A SQL analysis about the food prices in Zimbabwe and how they have varied over the years. */
  
  Author: Thabang Noko
  Email: thabangnoko13@gmail.com
  LinkedIn: https://www.linkedin.com/in/thabang-noko-a1b203234?lipi=urn%3Ali%3Apage%3Ad_flagship3_profile_view_base_contact_details%3BP%2BEelzqpSXiYB983%2Bcg0UA%3D%3D

-- Showing a preview of the original dataset

SELECT *
FROM `global-food-prices.food_prices.global_food_prices` LIMIT 1000

-- Creating a new table only considering Zimbabwe

CREATE TABLE `global-food-prices.food_prices.zim_prices` AS
SELECT *
FROM `global-food-prices.food_prices.global_food_prices`
WHERE adm0_name = 'Zimbabwe'

-- What are the different cities considered in the dataset?

SELECT DISTINCT adm1_name
FROM `global-food-prices.food_prices.zim_prices` 

--Results

adm1_name           |
--------------------+
Masvingo            |
Harare              |
Bulawayo            |
Matabeleland North  |
Midlands            |
Manicaland          |
Matabeleland South  |
Mashonaland Central |
Mashonaland East    |
Mashonaland West    |
--------------------

-- What are the different foods considered in the dataset?

SELECT DISTINCT cm_name
FROM `global-food-prices.food_prices.zim_prices`

--Results

cm_name                       |
------------------------------+
Beans                         | 
Maize                         |
Wheat                         |
Millet                        |
Cowpeas                       |
Sorghum                       |
Oil (vegetable)               |
Groundnuts (shelled)          |
"Maize meal (white, roller)"  |
------------------------------

-- What currency is used in Zimbabwe?

SELECT DISTINCT cur_name
FROM `global-food-prices.food_prices.zim_prices`

--Results

cur_name |
---------+
USD      |
---------

-- What years does the dataset consider?

SELECT DISTINCT mp_year
FROM `global-food-prices.food_prices.zim_prices`
ORDER BY mp_year

--Results

mp_year |
--------+
2010    |
2011    |
2012    |
2013    |
2014    |
2015    |
2016    |
2017    |
--------

-- How has the average food price changed over the years in Zimbabwe?

SELECT AVG(mp_price) as average, mp_year
FROM `global-food-prices.food_prices.zim_prices`
GROUP BY mp_year
ORDER BY mp_year

-- Results

average	             |mp_year |
---------------------+---------
0.27113636363636351	 |2010    |
0.32298816326530605	 |2011    |
0.3398455598455597	 |2012    |
0.39187022900763346	 |2013    |
0.7375090252707579	 |2014    |
1.0123809523809526	 |2015    |
1.0496231155778895	 |2016    |
1.0322651933701645	 |2017    |
-------------------------------

-- Average food prices faced a slow increase between 2010-2013 but saw a large increase between 2013-2015 before returning to relatively stable between 2015-17. 

-- Next I did some validation to determine if each food appeared the same amount of times throughout the years

SELECT mp_year, COUNT(cm_name), cm_name FROM `global-food-prices.food_prices.zim_prices`
GROUP BY mp_year, cm_name
ORDER BY mp_year

--Results
  First 10 rows
  
mp_year |	f0_  |cm_name |
--------+------+---------
2010	  |209	 |Maize   |
2011	  |245	 |Maize   |
2012	  |259	 |Maize   |
2013	  |262	 |Maize   |
2014	  |17	   |Sorghum |
2014	  |23    |Beans   |
2014	  |3	   |Wheat   |
2014	  |4	   |Millet  |
2014	  |6	   |Cowpeas |
2014	  |158	 |Maize   |
....... |..... |....... |
------------------------

-- From 2010-13 only Maize seems to have been produced. This could indicate that 
-- maize was the only food being produced at the time or, more likely, the data is 
-- not completely accurate. Therefore, it must be noted that results obtained from 
-- these earlier recorded date may not be reliable.

-- What food is produced most each year?

SELECT sum (um_id) as total_weight, cm_name, mp_year
 FROM `global-food-prices.food_prices.zim_prices`
 GROUP BY cm_name, mp_year
 ORDER BY mp_year, total_weight DESC
 
--Results
  First 10 rows
  
total_weight |cm_name	                     |mp_year |
-------------+-----------------------------+---------
1045	       |Maize	                       |2010    |
1225	       |Maize	                       |2011    |
1295	       |Maize	                       |2012    |
1310	       |Maize	                       |2013    |
790	         |Maize	                       |2014    |
420	         |Oil (vegetable)              |2014    |
140	         |"Maize meal (white, roller)" |2014    |
115  	       |Beans	                       |2014    |
85	         |Sorghum	                     |2014    |
50	         |Groundnuts (shelled)	       |2014    |
............ |............................ |....... |
-----------------------------------------------------

-- The food that was produced most from the query above is as follows 

total_weight |cm_name	                     |mp_year |
-------------+-----------------------------+---------
1045	       |Maize	                       |2010    |
1225	       |Maize	                       |2011    |
1295	       |Maize	                       |2012    |
1310	       |Maize	                       |2013    |
790	         |Maize	                       |2014    |
510	         |Oil (vegetable)              |2015    |
1230	       |Oil (vegetable)              |2016    |
1020         |Oil (vegetable)              |2017    |
----------------------------------------------------

 --What city has had the highest/lowest average food prices over the years?
 
SELECT AVG(mp_price) as average, adm1_name, mp_year
FROM `global-food-prices.food_prices.zim_prices`
GROUP BY adm1_name, mp_year
ORDER BY mp_year, average DESC

--Results
  First 10 rows

average             |adm1_name            |mp_year |
--------------------+---------------------+---------
0.36667500000000003	|Matabeleland South   |2010    |
0.3095375	          |Manicaland	          |2010    |
0.30476666666666669	|Masvingo           	|2010    |
0.29879999999999995	|Midlands	            |2010    |
0.261925	          |Harare	              |2010    |
0.25455454545454542	|Bulawayo	            |2010    |
0.24111578947368423	|Matabeleland North	  |2010    |
0.23478260869565218	|Mashonaland East	    |2010    |
0.234525	          |Mashonaland Central	|2010    |
0.21427916666666669	|Mashonaland West   	|2010    |
................... |.................... |....... |
----------------------------------------------------

-- The city with the most expensive food produced each year from the query above is as follows 

average             |adm1_name            |mp_year |
--------------------+---------------------+---------
0.36667500000000003	|Matabeleland South   |2010    |
0.40607           	|Matabeleland South  	|2011    |
0.44105263157894736 |Matabeleland South   |2012    |
0.45588235294117652	|Matabeleland South 	|2013    |
0.96585714285714286	|Matabeleland North   |2014    |
1.4316666666666669  |Matabeleland North   |2015    |
1.6752941176470588	|Matabeleland South   |2016    |
1.2964999999999998	|Midlands         	  |2017    |
----------------------------------------------------

-- The city with the cheapest produced each year from the query above is as follows 

average             |adm1_name            |mp_year |
--------------------+---------------------+---------
0.21427916666666669	|Mashonaland West     |2010    |
0.24766470588235295	|Mashonaland West   	|2011    |
0.24894736842105267 |Mashonaland West     |2012    |
0.29666666666666669	|Mashonaland West   	|2013    |
0.3690625	          |Mashonaland East     |2014    |
0.81481481481481466 |Harare               |2015    |
0.81454545454545435	|Harare               |2016    |
0.886904761904762 	|Matabeleland North   |2017    |
----------------------------------------------------

 -- What food has been the most/least expensive over the years?
 
SELECT AVG(mp_price) as average, cm_name, mp_year
FROM `global-food-prices.food_prices.zim_prices`
GROUP BY cm_name, mp_year
ORDER BY mp_year, average DESC

--Results
  First 10 Rows
  
average	            |cm_name	             |mp_year |
--------------------+----------------------+---------
0.27113636363636351	|Maize	               |2010    |
0.32298816326530605	|Maize	               |2011    |
0.3398455598455597	|Maize	               |2012    |
0.39187022900763346	|Maize	               |2013    |
2.0034782608695654	|Beans	               |2014    |
1.8748214285714282	|Oil (vegetable)	     |2014    |
1.0933333333333333	|Cowpeas	             |2014    |
0.9	                |Groundnuts (shelled)	 |2014    |
0.7	                |Millet	               |2014    |
0.61	              |Wheat	               |2014    |
................... |..................... |....... |
----------------------------------------------------

-- The most expensive food that was produced each year from the query above is as follows 

average	            |cm_name	             |mp_year |
--------------------+----------------------+---------
0.27113636363636351	|Maize	               |2010    |
0.32298816326530605	|Maize	               |2011    |
0.3398455598455597	|Maize	               |2012    |
0.39187022900763346	|Maize	               |2013    |
2.0034782608695654	|Beans	               |2014    |
1.9841176470588233	|Beans          	     |2015    |
1.8982608695652177	|Beans  	             |2016    |
1.8181249999999995  |Beans              	 |2017    |
-----------------------------------------------------

-- The cheapest food that was produced each year from the query above is as follows 

average	            |cm_name	             |mp_year |
--------------------+----------------------+---------
0.27113636363636351	|Maize	               |2010    |
0.32298816326530605	|Maize	               |2011    |
0.3398455598455597	|Maize	               |2012    |
0.39187022900763346	|Maize	               |2013    |
0.37920886075949384	|Maize	               |2014    |
0.3911764705882354	|Maize          	     |2015    |
0.35666666666666674	|Millet  	             |2016    |
0.38204081632653059 |Sorgum              	 |2017    |
-----------------------------------------------------

-- With the limited data from the years 2010-13 it is difficult to determine if Maize really 
-- was the most expensive/cheapest during those years. However, from the years 2014-17 it is 
-- clear that beans were the most expensive food. On the other hand, during these specified years, 
-- the cheapest food did vary slightly between maize, millet and Sorgum. However, when the query 
-- result is analysed fully it is observed that in the years where maize was not the cheapest it 
-- still was listed as second cheapest therefore it should not be ommitted from the analysis.


-- Lastly average GDP data was taken and compared to the average increase in food prices
-- This was first uploaded to BigQuery and placed in a table.

--  The columns did not have titles therefore they needed to be added

ALTER TABLE `global-food-prices.food_prices.Zimbabwe_GDP`
  RENAME COLUMN string_field_0 TO date;
  
ALTER TABLE `global-food-prices.food_prices.Zimbabwe_GDP`
  RENAME COLUMN string_field_1 TO GDP;
  
-- There were also null values which needed to be removed
  
CREATE TABLE `global-food-prices.food_prices.Zimbabwe_GDP_Corrected` AS
SELECT LEFT(date, 4) AS YEAR, GDP FROM `global-food-prices.food_prices.Zimbabwe_GDP`
WHERE GDP IS NOT NULL

-- The dates chosen were those that corresponded to those on the food price dataset

SELECT * 
FROM `global-food-prices.food_prices.Zimbabwe_GDP_Corrected`
WHERE YEAR = '2010' OR
      YEAR = '2011' OR
      YEAR = '2012' OR
      YEAR = '2013' OR
      YEAR = '2014' OR
      YEAR = '2015' OR
      YEAR = '2016' OR
      YEAR = '2017'
      
-- Result

YEAR	|GDP       |
------+-----------
2012	|1290.194  |
2015	|1410.3292 |
2013	|1408.3678 |
2010	|937.8403  |
2016	|1421.7878 |
2011	|1082.6158 |
2017	|1192.107  |
2014	|1407.0343 |
------------------

--  Both columns in the dataset were in the form of strings therefore they were
--  extracted to a csv and sorted on excel.

--  Result

YEAR	|GDP       |
------+----------
2010	|937.8403  |
2011	|1082.6158 | 
2012	|1290.194  |
2013	|1408.3678 |
2014	|1407.0343 |
2015	|1410.3292 |
2016	|1421.7878 |
2017	|1192.107  |
------------------

-- Next the % change in GDP and average price was investigated

--  Results
GDP % change |Avg price % change |
-------------+-------------------
15.43711653	 |19.12388251        |
19.17376414	 |5.219199493        |
9.159382232	 |15.30832687        |
-0.094684073 |88.20236157        |
0.234173396	 |37.27031368        |
0.812476973	 |3.678670871        |
-16.15436565 |	-1.653729034     |
----------------------------------

--  Not much correlation can be seen however, from 2013-14, the biggest increase in price
--  can be seen after the GDP faced its first decrease. This really emphasises the 
--  difficult situation Zimbabwe must have been facing during that time.
--  A csv file will be attached illustrating the percentage changes. 

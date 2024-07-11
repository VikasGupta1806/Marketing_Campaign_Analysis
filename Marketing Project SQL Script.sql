/* Customer Demographic Analysis
Objective: Understand the distribution of customer demographics*/

-- 1. Age Distribution

SELECT (YEAR(CURDATE()) - Year_Birth) AS Age, COUNT(customer_ID) AS Num_Customers
FROM marketing_data
GROUP BY Age;

-- Arranging in different age groups

SELECT 
    CASE
        WHEN (YEAR(CURDATE()) - Year_Birth) < 20 THEN 'Under 20'
        WHEN (YEAR(CURDATE()) - Year_Birth) BETWEEN 20 AND 29 THEN '20-29'
        WHEN (YEAR(CURDATE()) - Year_Birth) BETWEEN 30 AND 39 THEN '30-39'
        WHEN (YEAR(CURDATE()) - Year_Birth) BETWEEN 40 AND 49 THEN '40-49'
        WHEN (YEAR(CURDATE()) - Year_Birth) BETWEEN 50 AND 59 THEN '50-59'
        WHEN (YEAR(CURDATE()) - Year_Birth) BETWEEN 60 AND 69 THEN '60-69'
        WHEN (YEAR(CURDATE()) - Year_Birth) BETWEEN 70 AND 79 THEN '70-79'
        ELSE '80 and above'
    END AS Age_Group,
    COUNT(customer_ID) AS Num_Customers
FROM 
    marketing_data
GROUP BY 
    Age_Group
ORDER BY 
    Age_Group;

-- 2. Income Distribution

SELECT Income, COUNT(customer_ID) AS Num_Customers
FROM marketing_data
GROUP BY Income;

-- Arranging as per income group

SELECT 
    CASE
        WHEN Income < 20000 THEN 'Under 20K'
        WHEN Income BETWEEN 20000 AND 39999 THEN '20K-39K'
        WHEN Income BETWEEN 40000 AND 59999 THEN '40K-59K'
        WHEN Income BETWEEN 60000 AND 79999 THEN '60K-79K'
        WHEN Income BETWEEN 80000 AND 99999 THEN '80K-99K'
        ELSE '100K and above'
    END AS Income_Group,
    COUNT(customer_ID) AS Num_Customers
FROM 
    marketing_data
GROUP BY 
    Income_Group
ORDER BY 
    Income_Group;

-- 3. Marital Status Distribution

SELECT Marital_Status, COUNT(customer_ID) AS Num_Customers
FROM marketing_data
GROUP BY Marital_Status;

/*Customer Segmentataion
Objective: Segment customers based on purchasing behavior.*/

-- 1.Total Spending

SELECT 
    CASE
        WHEN (MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) < 100 THEN 'Under 100'
        WHEN (MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) BETWEEN 100 AND 499 THEN '100-499'
        WHEN (MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) BETWEEN 500 AND 999 THEN '500-999'
        WHEN (MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) BETWEEN 1000 AND 1999 THEN '1000-1999'
        ELSE '2000 and above'
    END AS Spending_Group,
    COUNT(customer_ID) AS Num_Customers
FROM 
    marketing_data
GROUP BY 
    Spending_Group
ORDER BY 
    Spending_Group;

-- 2. Product Preference

SELECT 
    CASE 
        WHEN MntWines >= MntFruits AND MntWines >= MntMeatProducts AND MntWines >= MntFishProducts AND MntWines >= MntSweetProducts AND MntWines >= MntGoldProds THEN 'Wines'
        WHEN MntFruits >= MntWines AND MntFruits >= MntMeatProducts AND MntFruits >= MntFishProducts AND MntFruits >= MntSweetProducts AND MntFruits >= MntGoldProds THEN 'Fruits'
        WHEN MntMeatProducts >= MntWines AND MntMeatProducts >= MntFruits AND MntMeatProducts >= MntFishProducts AND MntMeatProducts >= MntSweetProducts AND MntMeatProducts >= MntGoldProds THEN 'Meat Products'
        WHEN MntFishProducts >= MntWines AND MntFishProducts >= MntFruits AND MntFishProducts >= MntMeatProducts AND MntFishProducts >= MntSweetProducts AND MntFishProducts >= MntGoldProds THEN 'Fish Products'
        WHEN MntSweetProducts >= MntWines AND MntSweetProducts >= MntFruits AND MntSweetProducts >= MntMeatProducts AND MntSweetProducts >= MntFishProducts AND MntSweetProducts >= MntGoldProds THEN 'Sweets'
        ELSE 'Gold Products'
    END AS Preferred_Product,
    COUNT(customer_ID) AS Num_Customers
FROM 
    marketing_data
GROUP BY 
    Preferred_Product
ORDER BY 
    Preferred_Product;

/* Campaign Effectiveness Analysis
Objective: Analyze the effectiveness of each marketing campaign.*/

-- 1.Overall Campaign Response

SELECT (AcceptedCmp1 + AcceptedCmp2 + AcceptedCmp3 + AcceptedCmp4 + AcceptedCmp5 + Response) AS Total_Accepted_Campaigns, 
       COUNT(customer_ID) AS Num_Customers
FROM marketing_data
GROUP BY Total_Accepted_Campaigns;

-- 2.Campaign-wise Response Rate

SELECT 
    AVG(AcceptedCmp1) AS Cmp1_Response_Rate, 
    AVG(AcceptedCmp2) AS Cmp2_Response_Rate,
    AVG(AcceptedCmp3) AS Cmp3_Response_Rate,
    AVG(AcceptedCmp4) AS Cmp4_Response_Rate,
    AVG(AcceptedCmp5) AS Cmp5_Response_Rate,
    AVG(Response) AS Last_Cmp_Response_Rate
FROM marketing_data;

/* Recency and Frequency Analysis
Objective: Analyze how recent and frequent purchases affect campaign */

-- 1. Recency vs. Campaign Response

SELECT Recency, AVG(Response) AS Response_Rate
FROM marketing_data
GROUP BY Recency;

-- 2.Purchase Frequency vs. Campaign Response

SELECT 
    (NumWebPurchases + NumCatalogPurchases + NumStorePurchases) AS Total_Purchases, 
    AVG(Response) AS Response_Rate
FROM marketing_data
GROUP BY Total_Purchases;

/* Customer Complaints Analysis
Objective: Analyze the relationship between customer complaints and campaign responses */

-- 1. Complaints and Campaign Response

SELECT Complain, AVG(Response) AS Response_Rate
FROM marketing_data
GROUP BY Complain;

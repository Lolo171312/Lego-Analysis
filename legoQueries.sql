SELECT * FROM setstable;
SELECT * FROM final_view;

SELECT Set_Index, (Price / CAST(Pieces AS FLOAT)) AS Price_Per_Piece
FROM setstable
WHERE Pieces IS NOT NULL AND Pieces > 0;

SELECT *, (Price / CAST(Pieces AS FLOAT)) AS Avg_PiecePrice, 
	ROW_NUMBER() OVER(ORDER BY Price DESC) AS General_Price_Rank, 
    ROW_NUMBER() OVER(PARTITION BY Theme ORDER BY Price DESC) AS Theme_Price_Rank 
FROM setstable;

#Average price per piece group by Theme
WITH Price_Pice_Table AS
(
	SELECT Set_Index, (Price / CAST(Pieces AS FLOAT)) AS Price_Per_Piece, Age
	FROM setstable
	WHERE Pieces IS NOT NULL AND Pieces > 30 #With this filter I discarted expensive pieces like plates or batteries. I also discarted sets like DUPLO
)
SELECT setstable.Theme, AVG(Price_Pice_Table.Price_Per_Piece) AS Pice_Price_Avg FROM setstable
	JOIN Price_Pice_Table
		ON setstable.Set_Index = Price_Pice_Table.Set_Index
WHERE Theme = "StarÂ Wars" OR Theme = "City" OR Theme = "Icons" OR Theme = "Batman" OR Theme = "Ninjago"
GROUP BY setstable.Theme
ORDER BY Pice_Price_Avg DESC;

#More used Themes
SELECT Theme, COUNT(Set_Index) AS Number_Of_Sets FROM setstable
GROUP BY Theme
ORDER BY Number_Of_Sets DESC;

#Themes with the most expensive avarage set price
SELECT Theme, AVG(Price) AS Avg_Sets_Price FROM setstable
GROUP BY Theme
ORDER BY Avg_Sets_Price DESC;

#Get the most expensive Set from every Theme
WITH Most_Expensive_Table AS
(
	SELECT Theme, Set_Name, Price, ROW_NUMBER() OVER(PARTITION BY Theme ORDER BY Price DESC) AS Most_Expensives FROM setstable
    WHERE Price IS NOT NULL AND Price > 0
)
SELECT Theme, Set_Name, Price FROM Most_Expensive_Table
WHERE Most_Expensives = 1
ORDER BY Price DESC;

#Themes with the highest Age avarage
SELECT Theme, AVG(Age) AS Avg_Age FROM setstable
GROUP BY Theme
ORDER BY Avg_Age DESC;

#Themes with the highest Rate avarage
SELECT Theme, AVG(Rating) AS Avg_Rating, AVG(Age) AS Avg_Age, ROW_NUMBER() OVER(ORDER BY AVG(Rating) DESC) FROM setstable
WHERE Rating IS NOT NULL
GROUP BY Theme
ORDER BY Avg_Rating DESC;

#Correlation between rating and number of pieces (Using Pearson correlation formula)
WITH CorrelationData AS (
    SELECT Rating AS X, (Price * 1.0) / Pieces AS Y FROM setstable
    WHERE Price IS NOT NULL AND Pieces > 0 AND Rating IS NOT NULL
)
SELECT
    SUM((T.X - T_AVG.Avg_X) * (T.Y - T_AVG.Avg_Y)) /
    (
        COUNT(T.X) * STDDEV_POP(T.X) * STDDEV_POP(T.Y)
    ) AS Coefficient_Correlation_R
FROM CorrelationData T
CROSS JOIN (SELECT AVG(X) AS Avg_X, AVG(Y) AS Avg_Y FROM CorrelationData) AS T_AVG; #Coefficient = -0.3 -> There is no particular correlation

#Avarage Size of Set group by Theme
SELECT Theme, AVG(Pieces) AS Avg_SetSize FROM setstable
GROUP BY Theme
ORDER BY Avg_SetSize DESC;

#Themes with the most standard deviation
SELECT Theme, STDDEV_POP(Price) AS Price_Standart_Deviation, AVG(Price) AS Avg_Price, (STDDEV_POP(Price)/AVG(Price)) AS Coefficient, MIN(Price) AS Theme_MinPrice, MAX(Price) AS Theme_MaxPrice FROM setstable
GROUP BY Theme
ORDER BY Coefficient DESC;

SELECT * FROM deviation_view;
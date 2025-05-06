-- Query 4 -- 


--EXPLAIN FORMAT=JSON
SELECT
    a.name AS Performer_Name,
    AVG(r.interpretation_rating) AS Avg_Interpretation_Rating,
    AVG(r.overall_impression) AS Avg_Overall_Impression
FROM Rating r
JOIN Performance p ON r.performance_id = p.performance_id
JOIN Performs pf ON p.performs_id = pf.performs_id
JOIN Artist a ON pf.artist_id = a.artist_id
WHERE a.artist_id = 1
GROUP BY a.name;


-- ALTERNATIVE QUERY PLANNING USING FORCE INDEXES -- 

--CREATE INDEX idx_rating_performance_id ON Rating(performance_id);
--EXPLAIN FORMAT = JSON
SELECT
    a.name AS Performer_Name,
    AVG(r.interpretation_rating) AS Avg_Interpretation_Rating,
    AVG(r.overall_impression) AS Avg_Overall_Impression
FROM Rating r FORCE INDEX(idx_rating_performance_id)
JOIN Performance p FORCE INDEX(PRIMARY) ON r.performance_id = p.performance_id
JOIN Performs pf FORCE INDEX(PRIMARY) ON p.performs_id = pf.performs_id
JOIN Artist a FORCE INDEX (PRIMARY) ON pf.artist_id = a.artist_id
WHERE a.artist_id = 1
GROUP BY a.name;
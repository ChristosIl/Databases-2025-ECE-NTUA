-- Query 4 -- 
--EXPLAIN FORMAT=JSON

SELECT
    COALESCE(a.name, b.name) AS Performer_Name, 
    CASE WHEN a.artist_id IS NOT NULL THEN 'Artist' ELSE 'Band' END AS Performer_Type, 
    AVG(r.interpretation_rating) AS Avg_Interpretation_Rating,
    AVG(r.overall_impression) AS Avg_Overall_Impression
FROM Rating r
JOIN Performance p ON r.performance_id = p.performance_id
JOIN Performs pf ON p.performs_id = pf.performs_id
LEFT JOIN Artist a ON pf.artist_id = a.artist_id
LEFT JOIN Band b ON pf.band_id = b.band_id   
WHERE
    -- We choose which ever artist we want
    a.artist_id = 1 
    OR
    -- We choose which ever band we want
    b.band_id = 1 
GROUP BY COALESCE(a.name, b.name), CASE WHEN a.artist_id IS NOT NULL THEN 'Artist' ELSE 'Band' END;

-- Query 4 / FORCE INDEXES /Filtering is happening inside the JOINS to take advantage of--
-- Force Indexes --
--EXPLAIN FORMAT=JSON

SELECT
    COALESCE(a.name, b.name) AS Performer_Name, 
    CASE WHEN a.artist_id IS NOT NULL THEN 'Artist' ELSE 'Band' END AS Performer_Type, 
    AVG(r.interpretation_rating) AS Avg_Interpretation_Rating,
    AVG(r.overall_impression) AS Avg_Overall_Impression
FROM Rating r
JOIN Performance p FORCE INDEX (idx_performance_performs_id) 
    ON r.performance_id = p.performance_id
JOIN Performs pf 
    ON p.performs_id = pf.performs_id
LEFT JOIN Artist a 
    ON pf.artist_id = a.artist_id
LEFT JOIN Band b 
    ON pf.band_id = b.band_id
WHERE a.artist_id = 1 OR b.band_id = 5
GROUP BY Performer_Name, Performer_Type;



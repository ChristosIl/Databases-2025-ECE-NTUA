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

CREATE INDEX idx_rating_performance_id ON Rating(performance_id);
CREATE INDEX idx_performance_on_performs_and_id ON Performance(performs_id, performance_id);
CREATE INDEX idx_performs_ids ON Performs(performs_id, artist_id, band_id);
CREATE INDEX idx_artist_id_name ON Artist(artist_id, name);
CREATE INDEX idx_band_id_name ON Band(band_id, name);



EXPLAIN FORMAT=JSON
SELECT
    COALESCE(a.name, b.name) AS Performer_Name, 
    CASE 
        WHEN a.artist_id IS NOT NULL THEN 'Artist' 
        ELSE 'Band' 
    END AS Performer_Type, 
    AVG(r.interpretation_rating) AS Avg_Interpretation_Rating,
    AVG(r.overall_impression) AS Avg_Overall_Impression
FROM Rating r 
FORCE INDEX (idx_rating_performance_id)
JOIN Performance p 
    FORCE INDEX (idx_performance_on_performs_and_id)
    ON r.performance_id = p.performance_id
JOIN Performs pf 
    FORCE INDEX (idx_performs_ids)
    ON p.performs_id = pf.performs_id
LEFT JOIN Artist a 
    FORCE INDEX (idx_artist_id_name)
    ON pf.artist_id = a.artist_id
LEFT JOIN Band b 
    FORCE INDEX (idx_band_id_name)
    ON pf.band_id = b.band_id
WHERE
    a.artist_id = 1 
    OR
    b.band_id = 1 
GROUP BY 
    COALESCE(a.name, b.name), 
    CASE 
        WHEN a.artist_id IS NOT NULL THEN 'Artist' 
        ELSE 'Band' 
    END



-- Αλλο query plan

SELECT
    a.name AS Performer_Name, 
    'Artist' AS Performer_Type, 
    AVG(r.interpretation_rating) AS Avg_Interpretation_Rating,
    AVG(r.overall_impression) AS Avg_Overall_Impression
FROM Rating r 
JOIN Performance p ON r.performance_id = p.performance_id
JOIN Performs pf ON p.performs_id = pf.performs_id
JOIN Artist a ON pf.artist_id = a.artist_id
WHERE a.artist_id = 1
GROUP BY a.name

UNION ALL

SELECT
    b.name AS Performer_Name, 
    'Band' AS Performer_Type, 
    AVG(r.interpretation_rating),
    AVG(r.overall_impression)
FROM Rating r 
JOIN Performance p ON r.performance_id = p.performance_id
JOIN Performs pf ON p.performs_id = pf.performs_id
JOIN Band b ON pf.band_id = b.band_id
WHERE b.band_id = 1
GROUP BY b.name;


{
  "query_block": {
    "union_result": {
      "query_specifications": [
        {
          "query_block": {
            "select_id": 1,
            "cost": 0.03938652,
            "nested_loop": [
              {
                "table": {
                  "table_name": "a",
                  "access_type": "const",
                  "possible_keys": [
                    "PRIMARY",
                    "idx_artist_id",
                    "idx_artist_id_name"
                  ],
                  "key": "PRIMARY",
                  "key_length": "4",
                  "used_key_parts": ["artist_id"],
                  "ref": ["const"],
                  "rows": 1,
                  "filtered": 100
                }
              },
              {
                "table": {
                  "table_name": "pf",
                  "access_type": "ref",
                  "possible_keys": [
                    "PRIMARY",
                    "idx_performs_artist_id",
                    "idx_performs_ids"
                  ],
                  "key": "idx_performs_artist_id",
                  "key_length": "5",
                  "used_key_parts": ["artist_id"],
                  "ref": ["const"],
                  "loops": 1,
                  "rows": 12,
                  "cost": 0.00340614,
                  "filtered": 100,
                  "using_index": true
                }
              },
              {
                "table": {
                  "table_name": "p",
                  "access_type": "ref",
                  "possible_keys": [
                    "PRIMARY",
                    "idx_performance_performs_id",
                    "idx_performance_on_performs_and_id"
                  ],
                  "key": "idx_performance_performs_id",
                  "key_length": "4",
                  "used_key_parts": ["performs_id"],
                  "ref": ["festival_database.pf.performs_id"],
                  "loops": 12,
                  "rows": 1,
                  "cost": 0.01250006,
                  "filtered": 100,
                  "using_index": true
                }
              },
              {
                "table": {
                  "table_name": "r",
                  "access_type": "ref",
                  "possible_keys": ["idx_rating_performance_id"],
                  "key": "idx_rating_performance_id",
                  "key_length": "4",
                  "used_key_parts": ["performance_id"],
                  "ref": ["festival_database.p.performance_id"],
                  "loops": 12,
                  "rows": 1,
                  "cost": 0.02348032,
                  "filtered": 100
                }
              }
            ]
          }
        },
        {
          "query_block": {
            "select_id": 2,
            "operation": "UNION",
            "cost": 0.00704377,
            "nested_loop": [
              {
                "table": {
                  "table_name": "b",
                  "access_type": "const",
                  "possible_keys": ["PRIMARY", "idx_band_id", "idx_band_id_name"],
                  "key": "PRIMARY",
                  "key_length": "4",
                  "used_key_parts": ["band_id"],
                  "ref": ["const"],
                  "rows": 1,
                  "filtered": 100
                }
              },
              {
                "table": {
                  "table_name": "pf",
                  "access_type": "ref",
                  "possible_keys": [
                    "PRIMARY",
                    "idx_performs_band_id",
                    "idx_performs_ids"
                  ],
                  "key": "idx_performs_band_id",
                  "key_length": "5",
                  "used_key_parts": ["band_id"],
                  "ref": ["const"],
                  "loops": 1,
                  "rows": 1,
                  "cost": 0.001792605,
                  "filtered": 100,
                  "using_index": true
                }
              },
              {
                "table": {
                  "table_name": "p",
                  "access_type": "ref",
                  "possible_keys": [
                    "PRIMARY",
                    "idx_performance_performs_id",
                    "idx_performance_on_performs_and_id"
                  ],
                  "key": "idx_performance_performs_id",
                  "key_length": "4",
                  "used_key_parts": ["performs_id"],
                  "ref": ["festival_database.pf.performs_id"],
                  "loops": 1,
                  "rows": 1,
                  "cost": 0.001792605,
                  "filtered": 100,
                  "using_index": true
                }
              },
              {
                "table": {
                  "table_name": "r",
                  "access_type": "ref",
                  "possible_keys": ["idx_rating_performance_id"],
                  "key": "idx_rating_performance_id",
                  "key_length": "4",
                  "used_key_parts": ["performance_id"],
                  "ref": ["festival_database.p.performance_id"],
                  "loops": 1,
                  "rows": 1,
                  "cost": 0.00345856,
                  "filtered": 100
                }
              }
            ]
          }
        }
      ]
    }
  }
}
-- Query 6 -- 

SELECT
    v.name AS Visitor_Name,
    v.surname AS Visitor_Surname,
    e.event_name AS Event_Name,
    p.performance_id,
    p.type_of_performance,
    AVG((r.interpretation_rating + r.sound_and_lighting_rating + r.stage_presence_rating + r.organization_rating + r.overall_impression) / 5.0)
        AS Avg_Visitor_Total_Rating_Per_Performance
FROM Rating r
JOIN Ticket t ON r.ticket_id = t.ticket_id
JOIN Visitor v ON t.visitor_id = v.visitor_id
JOIN Performance p ON r.performance_id = p.performance_id
JOIN Event e ON p.event_id = e.event_id
/* Define visitor */
WHERE v.visitor_id = 1 
  AND t.used = TRUE
GROUP BY
    v.visitor_id, v.name, v.surname,
    e.event_id, e.event_name,
    p.performance_id, p.type_of_performance, p.start_time 
ORDER BY e.event_name, p.start_time;

{
  "query_block": {
    "select_id": 1,
    "cost": 0.01994562,
    "filesort": {
      "sort_key": "e.event_name, p.start_time",
      "temporary_table": {
        "nested_loop": [
          {
            "table": {
              "table_name": "v",
              "access_type": "const",
              "possible_keys": ["PRIMARY"],
              "key": "PRIMARY",
              "key_length": "4",
              "used_key_parts": ["visitor_id"],
              "ref": ["const"],
              "rows": 1,
              "filtered": 100
            }
          },
          {
            "table": {
              "table_name": "t",
              "access_type": "ref",
              "possible_keys": ["PRIMARY", "idx_ticket_visitor_used"],
              "key": "idx_ticket_visitor_used",
              "key_length": "5",
              "used_key_parts": ["visitor_id", "used"],
              "ref": ["const", "const"],
              "loops": 1,
              "rows": 4,
              "cost": 0.00223266,
              "filtered": 100,
              "using_index": true
            }
          },
          {
            "table": {
              "table_name": "r",
              "access_type": "ref",
              "possible_keys": [
                "idx_rating_performance_id",
                "idx_rating_ticket_id"
              ],
              "key": "idx_rating_ticket_id",
              "key_length": "4",
              "used_key_parts": ["ticket_id"],
              "ref": ["festival_database.t.ticket_id"],
              "loops": 4,
              "rows": 1,
              "cost": 0.00891904,
              "filtered": 100
            }
          },
          {
            "table": {
              "table_name": "p",
              "access_type": "eq_ref",
              "possible_keys": [
                "PRIMARY",
                "idx_performance_event_id",
                "idx_perf_event_start"
              ],
              "key": "PRIMARY",
              "key_length": "4",
              "used_key_parts": ["performance_id"],
              "ref": ["festival_database.r.performance_id"],
              "loops": 4,
              "rows": 1,
              "cost": 0.00439696,
              "filtered": 100
            }
          },
          {
            "table": {
              "table_name": "e",
              "access_type": "eq_ref",
              "possible_keys": ["PRIMARY", "idx_event_id_name"],
              "key": "PRIMARY",
              "key_length": "4",
              "used_key_parts": ["event_id"],
              "ref": ["festival_database.p.event_id"],
              "loops": 4,
              "rows": 1,
              "cost": 0.00439696,
              "filtered": 100
            }
          }
        ]
      }
    }
  }
}




SELECT
    v.name AS Visitor_Name,
    v.surname AS Visitor_Surname,
    e.event_name AS Event_Name,
    p.performance_id,
    p.type_of_performance,
    AVG((r.interpretation_rating + r.sound_and_lighting_rating + r.stage_presence_rating + r.organization_rating + r.overall_impression) / 5.0)
        AS Avg_Visitor_Total_Rating_Per_Performance
FROM Rating r FORCE INDEX (idx_rating_ticket_id)
JOIN Ticket t FORCE INDEX (idx_ticket_visitor_used)
    ON r.ticket_id = t.ticket_id
JOIN Visitor v  -- δεν χρειάζεται force, είναι const lookup
    ON t.visitor_id = v.visitor_id
JOIN Performance p FORCE INDEX (idx_performance_event_id)
    ON r.performance_id = p.performance_id
JOIN Event e FORCE INDEX (idx_event_id_name)
    ON p.event_id = e.event_id
WHERE v.visitor_id = 1 
  AND t.used = TRUE
GROUP BY
    v.visitor_id, v.name, v.surname,
    e.event_id, e.event_name,
    p.performance_id, p.type_of_performance, p.start_time 
ORDER BY e.event_name, p.start_time;


{
  "query_block": {
    "select_id": 1,
    "cost": 0.073203255,
    "filesort": {
      "sort_key": "e.event_name, p.start_time",
      "temporary_table": {
        "nested_loop": [
          {
            "table": {
              "table_name": "v",
              "access_type": "const",
              "possible_keys": ["PRIMARY"],
              "key": "PRIMARY",
              "key_length": "4",
              "used_key_parts": ["visitor_id"],
              "ref": ["const"],
              "rows": 1,
              "filtered": 100
            }
          },
          {
            "table": {
              "table_name": "t",
              "access_type": "ref",
              "possible_keys": ["idx_ticket_visitor_used"],
              "key": "idx_ticket_visitor_used",
              "key_length": "5",
              "used_key_parts": ["visitor_id", "used"],
              "ref": ["const", "const"],
              "loops": 1,
              "rows": 4,
              "cost": 0.00223266,
              "filtered": 100,
              "using_index": true
            }
          },
          {
            "table": {
              "table_name": "r",
              "access_type": "ref",
              "possible_keys": ["idx_rating_ticket_id"],
              "key": "idx_rating_ticket_id",
              "key_length": "4",
              "used_key_parts": ["ticket_id"],
              "ref": ["festival_database.t.ticket_id"],
              "loops": 4,
              "rows": 1,
              "cost": 0.00891904,
              "filtered": 100
            }
          },
          {
            "block-nl-join": {
              "table": {
                "table_name": "e",
                "access_type": "index",
                "possible_keys": ["idx_event_id_name"],
                "key": "idx_event_id_name",
                "key_length": "1026",
                "used_key_parts": ["event_id", "event_name"],
                "loops": 4,
                "rows": 7,
                "cost": 0.012220675,
                "filtered": 100,
                "using_index": true
              },
              "buffer_type": "flat",
              "buffer_size": "561",
              "join_type": "BNL"
            }
          },
          {
            "table": {
              "table_name": "p",
              "access_type": "eq_ref",
              "possible_keys": ["idx_performance_event_id"],
              "key": "idx_performance_event_id",
              "key_length": "8",
              "used_key_parts": ["event_id", "performance_id"],
              "ref": [
                "festival_database.e.event_id",
                "festival_database.r.performance_id"
              ],
              "loops": 28,
              "rows": 1,
              "cost": 0.04983088,
              "filtered": 100
            }
          }
        ]
      }
    }
  }
}



SELECT
    v.name AS Visitor_Name,
    v.surname AS Visitor_Surname,
    e.event_name AS Event_Name,
    p.performance_id,
    p.type_of_performance,
    AVG((r.interpretation_rating + r.sound_and_lighting_rating + r.stage_presence_rating + r.organization_rating + r.overall_impression) / 5.0)
        AS Avg_Visitor_Total_Rating_Per_Performance
FROM Rating r
JOIN Performance p ON r.performance_id = p.performance_id
JOIN Event e ON p.event_id = e.event_id
JOIN Ticket t ON r.ticket_id = t.ticket_id
JOIN Visitor v ON t.visitor_id = v.visitor_id
WHERE v.visitor_id = 1 
  AND t.used = TRUE
GROUP BY
    v.visitor_id, v.name, v.surname,
    e.event_id, e.event_name,
    p.performance_id, p.type_of_performance, p.start_time 
ORDER BY e.event_name, p.start_time;



{
  "query_block": {
    "select_id": 1,
    "cost": 0.01994562,
    "filesort": {
      "sort_key": "e.event_name, p.start_time",
      "temporary_table": {
        "nested_loop": [
          {
            "table": {
              "table_name": "v",
              "access_type": "const",
              "possible_keys": ["PRIMARY"],
              "key": "PRIMARY",
              "key_length": "4",
              "used_key_parts": ["visitor_id"],
              "ref": ["const"],
              "rows": 1,
              "filtered": 100
            }
          },
          {
            "table": {
              "table_name": "t",
              "access_type": "ref",
              "possible_keys": ["PRIMARY", "idx_ticket_visitor_used"],
              "key": "idx_ticket_visitor_used",
              "key_length": "5",
              "used_key_parts": ["visitor_id", "used"],
              "ref": ["const", "const"],
              "loops": 1,
              "rows": 4,
              "cost": 0.00223266,
              "filtered": 100,
              "using_index": true
            }
          },
          {
            "table": {
              "table_name": "r",
              "access_type": "ref",
              "possible_keys": [
                "idx_rating_performance_id",
                "idx_rating_ticket_id"
              ],
              "key": "idx_rating_ticket_id",
              "key_length": "4",
              "used_key_parts": ["ticket_id"],
              "ref": ["festival_database.t.ticket_id"],
              "loops": 4,
              "rows": 1,
              "cost": 0.00891904,
              "filtered": 100
            }
          },
          {
            "table": {
              "table_name": "p",
              "access_type": "eq_ref",
              "possible_keys": [
                "PRIMARY",
                "idx_performance_event_id",
                "idx_perf_event_start"
              ],
              "key": "PRIMARY",
              "key_length": "4",
              "used_key_parts": ["performance_id"],
              "ref": ["festival_database.r.performance_id"],
              "loops": 4,
              "rows": 1,
              "cost": 0.00439696,
              "filtered": 100
            }
          },
          {
            "table": {
              "table_name": "e",
              "access_type": "eq_ref",
              "possible_keys": ["PRIMARY", "idx_event_id_name"],
              "key": "PRIMARY",
              "key_length": "4",
              "used_key_parts": ["event_id"],
              "ref": ["festival_database.p.event_id"],
              "loops": 4,
              "rows": 1,
              "cost": 0.00439696,
              "filtered": 100
            }
          }
        ]
      }
    }
  }
}
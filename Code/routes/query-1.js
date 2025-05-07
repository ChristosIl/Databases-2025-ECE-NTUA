const express = require('express');
const router = express.Router();
const pool = require('../db');


router.get('/', async (req, res)=>{
    let conn; 

    try{
        console.log("Connecting to DB...");
        conn = await pool.getConnection();
        console.log("Connected.");    
        
        const  query1 = await conn.query(
            `
            SELECT 
                f.name AS festival_name,
                f.year AS festival_year,
                pm.name AS Payment_method,
                tt.name AS Ticket_type,
                SUM(t.price) AS Total_revenue
            FROM Ticket t 
            JOIN Event e ON t.event_id = e.event_id
            JOIN Festival f ON e.festival_id = f.festival_id
            LEFT JOIN Payment_method pm ON pm.payment_method_id = t.payment_method_id
            LEFT JOIN Ticket_type tt ON tt.ticket_type_id = t.ticket_type_id
            GROUP BY f.festival_id, f.name, f.year, pm.name, tt.name
            ORDER BY f.year, f.name, pm.name, tt.name
            `
        );
        console.log("Query result:", query1);
        res.render('query-1', { query1 });
        
    }
    catch(err)
    {
        console.log(err);
        res.status(500).send('Database error connection');
    }
    finally{
        if (conn) conn.release();
    }
})

module.exports = router;
    -- Disable foreign key checks
    SET foreign_key_checks = 0;

    TRUNCATE TABLE Continent;
    TRUNCATE TABLE Staff_role;
    TRUNCATE TABLE Experience_level;
    TRUNCATE TABLE Ticket_type;
    TRUNCATE TABLE Payment_method;
    TRUNCATE TABLE Stage;
    TRUNCATE TABLE Location;
    TRUNCATE TABLE Festival;
    TRUNCATE TABLE Event;
    TRUNCATE TABLE Performer;
    TRUNCATE TABLE Performance;
    TRUNCATE TABLE Visitor;
    TRUNCATE TABLE Ticket;
    TRUNCATE TABLE Resale_Buyer;
    TRUNCATE TABLE Resale_Queue;

    -- Reenable foreign key checks
    SET foreign_key_checks = 1;


    -- Populate Continent Table
    INSERT INTO Continent (continent_id, name)
    VALUES 
    (1, 'Africa'),
    (2, 'Antarctica'),
    (3, 'Asia'),
    (4, 'Europe'),
    (5, 'North America'),
    (6, 'Australia'),
    (7, 'South America');

    -- Populate Staff role Table
    INSERT INTO Staff_role (staff_role_id, name)
    VALUES
    (1, 'Technical_staff'),
    (2, 'Security Staff'),
    (3, 'Helping Staff');

    -- Populate Experience level Table
    INSERT INTO Experience_level (experience_id, name)
    VALUES
    (1, 'Trainee'),
    (2, 'Beginner'),
    (3, 'Intermediate'),
    (4, 'Experienced'),
    (5, 'Highly Experienced');

    -- Populate Ticket_type Table
    INSERT INTO Ticket_type (ticket_type_id, name)
    VALUES
    (1, 'VIP'),
    (2, 'General'),
    (3, 'Backstage');

    -- Populate Payment_method Table
    INSERT INTO Payment_method (payment_method_id, name)
    VALUES
    (1, 'Credit Card'),
    (2, 'Debit Card'),
    (3, 'Bank Transfer');


    /*Populate Stage Table (testing for question 2)*/
    INSERT INTO Stage (name, description, max_capacity, infos_technical_equipment, photo_url, photo_description)
    VALUES 
    ('Main Stage', 'Biggest stage of the fest', 5000, 'Lights, sound system, pyrotechnics', 'url', 'desc');

    -- Populate Location Table (15 values)
    INSERT INTO Location (address, city, longitude, latitude, country, continent_id, photo_url, photo_description)
    VALUES 
    ('79085 Ilene Pass', 'Malysheva', 61.3976419, 57.1101387, 'Russia', 3, 'http://dummyimage.com/187x100.png/dddddd/000000', 'Refreshing dessert bars made with pineapple and coconut.'),
    ('4305 Harbort Trail', 'Nyköping', 16.8555169, 58.7542973, 'Sweden', 4, 'http://dummyimage.com/172x100.png/5fa2dd/ffffff', 'Sweet and fruity peach preserves, perfect for spreading on toast.'),
    ('8906 Crownhardt Plaza', 'Balin', 104.964912, 24.541563, 'China', 3, 'http://dummyimage.com/233x100.png/dddddd/000000', 'Golden brown potato tots, crispy on the outside and fluffy inside.'),
    ('7 Atwood Place', 'Shiyuan', 116.2237499, 39.9542181, 'China', 3, 'http://dummyimage.com/151x100.png/cc0000/ffffff', 'Sleek wireless charging pad for smartphones.'),
    ('353 Summerview Court', 'Buenavista', -93.1569465, 16.7646627, 'Mexico', 5, 'http://dummyimage.com/144x100.png/dddddd/000000', 'Salty pretzels filled with creamy peanut butter.'),
    ('7 Lindbergh Lane', 'Orlando', -81.38, 28.54, 'United States', 5, 'http://dummyimage.com/170x100.png/ff4444/ffffff', 'GPS collar that monitors your pet''s location and activity level.'),
    ('1 New Castle Crossing', 'Guansheng', 113.668388, 23.104725, 'China', 3, 'http://dummyimage.com/216x100.png/5fa2dd/ffffff', 'Ready-to-eat salad with kale, lemon, and cheese.'),
    ('2438 Thierer Terrace', 'Zaprudnya', 37.4286044, 56.5637319, 'Russia', 3, 'http://dummyimage.com/217x100.png/ff4444/ffffff', 'A nutritious salad with quinoa and black beans'),
    ('41 Logan Center', 'Kanoya', 139.8816085, 36.6493964, 'Japan', 3, 'http://dummyimage.com/127x100.png/cc0000/ffffff', 'High-quality olive oil infused with fresh lemon zest.'),
    ('9573 South Crossing', 'Baxiangshan', 115.969501, 23.764143, 'China', 3, 'http://dummyimage.com/172x100.png/cc0000/ffffff', 'Durable and soft frisbee designed for dogs to play with.'),
    ('12 Rue de Rivoli', 'Paris', 2.352222, 48.856613, 'France', 4, 'http://dummyimage.com/200x100.png/007bff/ffffff', 'Elegant open-air location near the Seine River.'),
    ('121 Collins St', 'Melbourne', 144.963058, -37.813629, 'Australia', 6, 'http://dummyimage.com/200x100.png/28a745/ffffff', 'Downtown venue in the cultural heart of Melbourne.'),
    ('Plaza de Armas', 'Cusco', -71.968956, -13.53195, 'Peru', 7, 'http://dummyimage.com/200x100.png/ffc107/000000', 'Historic square surrounded by colonial architecture.'),
    ('1000 Burrard St', 'Vancouver', -123.1207, 49.2827, 'Canada', 5, 'http://dummyimage.com/200x100.png/6f42c1/ffffff', 'Modern riverside space ideal for outdoor concerts.'),
    ('Kenyatta Ave', 'Nairobi', 36.821946, -1.292066, 'Kenya', 1, 'http://dummyimage.com/200x100.png/dc3545/ffffff', 'Vibrant festival park in the heart of Nairobi.');

    -- Populate Festival Table (10 values, 2 for the future)
    INSERT INTO Festival (location_id, year, name, duration_days, photo_url, photo_description)
    VALUES
    (1, 2022, 'Global Beats Festival', 3, 'http://dummyimage.com/200x100.png/ff4444/ffffff', 'An eclectic music celebration in the heart of the city.'),
    (2, 2023, 'Sunset Soundscapes', 4, 'http://dummyimage.com/200x100.png/007bff/ffffff', 'Live electronic performances as the sun sets.'),
    (3, 2021, 'Jazz & Beyond', 2, 'http://dummyimage.com/200x100.png/5fa2dd/ffffff', 'A smooth experience filled with jazz and fusion.'),
    (4, 2024, 'Island Vibes Festival', 5, 'http://dummyimage.com/200x100.png/28a745/ffffff', 'Beachside music and culture fest.'),
    (5, 2025, 'Rhythm Nation', 3, 'http://dummyimage.com/200x100.png/ffc107/000000', 'A celebration of rhythms from across the globe.'),
    (6, 2023, 'Indie Rising', 2, 'http://dummyimage.com/200x100.png/6f42c1/ffffff', 'A showcase of upcoming indie talent.'),
    (7, 2022, 'Electro World', 3, 'http://dummyimage.com/200x100.png/cc0000/ffffff', 'Massive EDM stage experiences.'),
    (8, 2024, 'Folk Routes', 4, 'http://dummyimage.com/200x100.png/dc3545/ffffff', 'A journey through traditional and folk music.'),
    (9, 2026, 'Future Pulse', 5, 'http://dummyimage.com/200x100.png/dddddd/000000', 'Futuristic sound and immersive visual sets.'),
    (10, 2027, 'Unity Fest', 3, 'http://dummyimage.com/200x100.png/007bff/ffffff', 'A global unity celebration through music.'),
    (5, 2025, 'Unity Fest', 3, 'http://dummyimage.com/200x100.png/007bff/ffffff', 'A global unity celebration through music.');



    /*Populate Event Table (testing for question 2)*/
    INSERT INTO Event (event_id, festival_id, stage_id, event_name, event_date, duration, photo_url, photo_description)
    VALUES 
    (1, 1, 1, 'Rock Night', '2024-06-21', 5, 'url', 'desc');


    /*Populate Performance Table (testing for question 2)*/
    INSERT INTO Performer (performer_id, name, nickname, birth_date, is_solo, music_genres, sub_music_genres, website, instagram, photo_url, photo_description)
    VALUES
    (1, 'The Rockers', NULL, '1990-01-01', FALSE, 'Rock', 'Hard Rock', NULL, NULL, 'url', 'desc'),
    (2, 'Smooth Jazz Band', NULL, '1995-05-20', FALSE, 'Jazz', 'Smooth Jazz', NULL, NULL, 'url', 'desc'),
    (3, 'Electro Beat', NULL, '1992-03-10', TRUE, 'Electronic', 'Synthpop', NULL, NULL, 'url', 'desc'),
    (4, 'Another Rocker', NULL, '1994-09-15', TRUE, 'Rock', 'Alternative Rock', NULL, NULL, 'url', 'desc');


    /*Populate Performances Table (testing for question 2)*/
    INSERT INTO Performance (performance_id, event_id, performer_id, type_of_performance, duration, start_time, end_time, photo_url, photo_description)
    VALUES
    (1, 1, 1, 'Headline', 2, 18.00, 20.00, 'url', 'desc'),
    (2, 1, 4, 'Warm Up', 1.5, 16.00, 17.30, 'url', 'desc');


    /*Populate visitor*/
    INSERT INTO Visitor (visitor_id, name, surname, age, email, phone_number, photo_url, photo_description)
    VALUES
    (1, 'Christos', 'Iliak', 18, 'sad@gmail.com', '3245823598', NULL, NULL);


    INSERT INTO Ticket (ticket_id, event_id, visitor_id, ticket_type_id, purchase_date, price, payment_method_id, ean_code, used, photo_url, photo_description)
    VALUES
    (1, 1, 1, 1, '2025-06-02 14:30:00', 120.00, 1, '1234567890123', FALSE, NULL, NULL),
    (2, 1, 1, 1, '2025-06-03 14:00:00', 130.00, 1, '1234567890155', FALSE, NULL, NULL);
    
    INSERT INTO Resale_Buyer (buyer_id, name, surname, age, email, phone_number, photo_url, photo_description)
    VALUES (1, 'Alexandra', 'Papadopoulou', 28, 'alexandra.p@example.com', '+306912345678', 'http://dummyimage.com/200x100.png/5fa2dd/ffffff', 'Profile photo of Alexandra at a concert.');


    INSERT INTO Resale_Queue (resale_id, ticket_id, seller_id, buyer_id, request_date, listing_date, purchase_date, preferred_event_id, preferred_ticket_type, status) 
    VALUES (1, 1, 1, 1, '2025-04-01', NULL, NULL, 1, 'VIP', 'Pending');

    /*TODO: Correct the queries and the queue of insertion of them*/
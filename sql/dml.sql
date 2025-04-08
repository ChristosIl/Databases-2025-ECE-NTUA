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
    ('Main Stage', 'Biggest stage of the fest', 5000, 'Lights, sound system, pyrotechnics', 'http://dummyimage.com/400x100.png', 'desc'),
    ('Electric Grove', 'High-tech stage with panoramic LED screens.', 7302, 'Lights, lasers, subwoofers', 'http://dummyimage.com/206x100.png', 'Electric Grove setup with lights, lasers, subwoofers.'),
    ('Sunset Arena', 'Open air venue with stunning sunset views.', 5977, 'Surround sound, moving head lights', 'http://dummyimage.com/172x100.png', 'Sunset Arena setup with surround sound, moving head lights.'),
    ('Bassline Bay', 'Perfect for bass-heavy performances.', 6001, 'Basic setup with speakers and mics', 'http://dummyimage.com/169x100.png', 'Bassline Bay setup with basic setup with speakers and mics.'),
    ('Harmony Hill', 'Located on a hillside with great acoustics.', 6891, 'LED wall, fog machines, DJ booth', 'http://dummyimage.com/156x100.png', 'Harmony Hill setup with led wall, fog machines, dj booth.'),
    ('Echo Grounds', 'Circular stage surrounded by echo walls.', 2425, 'Dual projection, rotating stage', 'http://dummyimage.com/228x100.png', 'Echo Grounds setup with dual projection, rotating stage.'),
    ('Neon Nexus', 'Futuristic stage design with holograms.', 5693, 'Flame projectors, bass cannons', 'http://dummyimage.com/181x100.png', 'Neon Nexus setup with flame projectors, bass cannons.'),
    ('Funk Fortress', 'Great for funk and dance music sets.', 7949, 'RGB lighting, multi-mic system', 'http://dummyimage.com/212x100.png', 'Funk Fortress setup with rgb lighting, multi-mic system.'),
    ('Synth Summit', 'High-altitude stage with sweeping views.', 2766, 'Silent disco capabilities', 'http://dummyimage.com/159x100.png', 'Synth Summit setup with silent disco capabilities.'),
    ('Groove Garden', 'Laid-back environment for chill sets.', 2198, 'Digital mixing board, spotlights', 'http://dummyimage.com/220x100.png', 'Groove Garden setup with digital mixing board, spotlights.'),
    ('Vibe Valley', 'Surrounded by trees and natural acoustics.', 2231, '4K video wall, auto-tracking cameras', 'http://dummyimage.com/178x100.png', 'Vibe Valley setup with 4k video wall, auto-tracking cameras.'),
    ('Melody Meadows', 'Meadow-based setup with open seating.', 7024, 'Vinyl turntable ready, drum mics', 'http://dummyimage.com/189x100.png', 'Melody Meadows setup with vinyl turntable ready, drum mics.'),
    ('Pulse Pavilion', 'Large tent structure for central events.', 7745, 'Bluetooth sync system', 'http://dummyimage.com/165x100.png', 'Pulse Pavilion setup with bluetooth sync system.'),
    ('Rhythm Ring', 'Circular ring with 360° audience view.', 2205, '360° camera rig, surround audio', 'http://dummyimage.com/153x100.png', 'Rhythm Ring setup with 360° camera rig, surround audio.'),
    ('Tempo Tower', 'Tall structure with rotating lighting rig.', 7222, 'Live streaming setup, green screen', 'http://dummyimage.com/178x100.png', 'Tempo Tower setup with live streaming setup, green screen.'),
    ('Soundwave Square', 'Large plaza ideal for electro-pop shows.', 5997, 'Standard speaker grid', 'http://dummyimage.com/187x100.png', 'Soundwave Square setup with standard speaker grid.'),
    ('Treble Terrace', 'Tiered setup with excellent visibility.', 4791, 'Laser mapping, visual effects rig', 'http://dummyimage.com/187x100.png', 'Treble Terrace setup with laser mapping, visual effects rig.'),
    ('Beat Bastion', 'Enclosed space for heavy bass shows.', 2303, 'Full band setup with DI boxes', 'http://dummyimage.com/170x100.png', 'Beat Bastion setup with full band setup with di boxes.'),
    ('Chord Chamber', 'Minimalist layout for acoustic vibes.', 2233, 'DJ controller, smoke jets', 'http://dummyimage.com/182x100.png', 'Chord Chamber setup with dj controller, smoke jets.'),
    ('Acoustic Alcove', 'Low-key corner stage near the entrance.', 7122, 'Bass trap equipped structure', 'http://dummyimage.com/238x100.png', 'Acoustic Alcove setup with bass trap equipped structure.'),
    ('Resonance Ridge', 'Elevated ground surrounded by forest.', 2310, 'Lightweight mobile stage', 'http://dummyimage.com/240x100.png', 'Resonance Ridge setup with lightweight mobile stage.'),
    ('Amplify Atrium', 'Wide open setup with enhanced sound.', 5268, 'Hybrid acoustic-electric stage', 'http://dummyimage.com/198x100.png', 'Amplify Atrium setup with hybrid acoustic-electric stage.'),
    ('Frequency Field', 'Large field for massive audiences.', 5310, 'Wireless mic network', 'http://dummyimage.com/162x100.png', 'Frequency Field setup with wireless mic network.'),
    ('Noise Nest', 'Underground bunker-themed layout.', 7656, 'Reinforced flooring, moving lights', 'http://dummyimage.com/209x100.png', 'Noise Nest setup with reinforced flooring, moving lights.'),
    ('Stage Infinity', 'Hexagonal design with 6 exits.', 2715, 'Crowd-facing monitors', 'http://dummyimage.com/198x100.png', 'Stage Infinity setup with crowd-facing monitors.'),
    ('Harmony Horizon', 'Open skyline stage.', 1848, 'Rainproof roof, cable-free zone', 'http://dummyimage.com/167x100.png', 'Harmony Horizon setup with rainproof roof, cable-free zone.'),
    ('Pitch Plateau', 'Floating stage across lake.', 6111, 'Live VJ integration', 'http://dummyimage.com/224x100.png', 'Pitch Plateau setup with live vj integration.'),
    ('Reverb Ridge', 'Natural amphitheater with rock backdrop.', 6955, 'Looping FX modules', 'http://dummyimage.com/250x100.png', 'Reverb Ridge setup with looping fx modules.'),
    ('Drumline Dome', 'Dome covered in sound-absorbing panels.', 1679, 'Strobe grid system', 'http://dummyimage.com/234x100.png', 'Drumline Dome setup with strobe grid system.'),
    ('Festival Frontier', 'Edge-of-venue spot for indie acts.', 2041, 'Ambient light columns', 'http://dummyimage.com/245x100.png', 'Festival Frontier setup with ambient light columns.');


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
    (1, 1, 1, 'Rock Night', '2024-06-21', 5, 'http://dummyimage.com/200x100.png/ff4444/ffffff', 'An energetic rock music night.'),
    (2, 1, 2, 'Jazz Evening', '2024-06-21', 3, 'http://dummyimage.com/200x100.png/5fa2dd/ffffff', 'Smooth jazz with classic vibes.'),
    (3, 1, 3, 'Sunset Beats', '2024-06-22', 4, 'http://dummyimage.com/200x100.png/dddddd/000000', 'Chill EDM at sunset.'),
    (4, 2, 4, 'Electronic Dreams', '2023-08-15', 5, 'http://dummyimage.com/200x100.png/cc0000/ffffff', 'Futuristic electronic experience.'),
    (5, 2, 5, 'Acoustic Morning', '2023-08-16', 2, 'http://dummyimage.com/200x100.png/007bff/ffffff', 'Relaxing acoustic performance.'),
    (6, 3, 6, 'Indie Spirit', '2021-09-10', 3, 'http://dummyimage.com/200x100.png/28a745/ffffff', 'Rising indie bands showcase.'),
    (7, 3, 7, 'Night of Funk', '2021-09-11', 4, 'http://dummyimage.com/200x100.png/ffc107/000000', 'Funky grooves and moves.'),
    (8, 4, 8, 'Island Reggae', '2024-07-05', 5, 'http://dummyimage.com/200x100.png/6f42c1/ffffff', 'Reggae from the tropics.'),
    (9, 4, 9, 'Tropical Techno', '2024-07-06', 5, 'http://dummyimage.com/200x100.png/5fa2dd/ffffff', 'Techno by the beach.'),
    (10, 5, 10, 'Global Hip-Hop', '2025-05-01', 4, 'http://dummyimage.com/200x100.png/007bff/ffffff', 'Hip-hop from around the world.'),
    (11, 5, 11, 'Beat Cypher', '2025-05-02', 3, 'http://dummyimage.com/200x100.png/dddddd/000000', 'Rap battles and live beats.'),
    (12, 6, 12, 'Alternative Vibes', '2023-10-01', 3, 'http://dummyimage.com/200x100.png/ff4444/ffffff', 'Alternative rock performances.'),
    (13, 6, 13, 'Indie Chill', '2023-10-02', 3, 'http://dummyimage.com/200x100.png/28a745/ffffff', 'Relaxed indie sounds.'),
    (14, 7, 14, 'EDM Explosion', '2022-11-20', 5, 'http://dummyimage.com/200x100.png/6f42c1/ffffff', 'High-energy EDM night.'),
    (15, 7, 15, 'Trance Therapy', '2022-11-21', 4, 'http://dummyimage.com/200x100.png/5fa2dd/ffffff', 'Healing trance sets.'),
    (16, 8, 16, 'Folk Heritage', '2024-04-03', 3, 'http://dummyimage.com/200x100.png/ffc107/000000', 'Traditional folk music.'),
    (17, 8, 17, 'Cultural Fusion', '2024-04-04', 4, 'http://dummyimage.com/200x100.png/007bff/ffffff', 'Fusion of world music styles.'),
    (18, 9, 18, 'Future Beats', '2026-09-14', 5, 'http://dummyimage.com/200x100.png/dddddd/000000', 'Experimental future soundscapes.'),
    (19, 9, 19, 'VR DJ Set', '2026-09-15', 5, 'http://dummyimage.com/200x100.png/cc0000/ffffff', 'Virtual reality DJ experience.'),
    (20, 10, 20, 'Unity Sound', '2027-06-10', 4, 'http://dummyimage.com/200x100.png/5fa2dd/ffffff', 'A celebration of global harmony.'),
    (21, 1, 21, 'Punk Riot', '2024-06-22', 3, 'http://dummyimage.com/200x100.png/ff4444/ffffff', 'Loud and raw punk performances.'),
    (22, 1, 22, 'Symphony Sunset', '2024-06-23', 4, 'http://dummyimage.com/200x100.png/5fa2dd/ffffff', 'Classical music during golden hour.'),
    (23, 2, 23, 'Techno Tunnel', '2023-08-17', 5, 'http://dummyimage.com/200x100.png/dddddd/000000', 'Immersive techno tunnel rave.'),
    (24, 2, 24, 'Soul Sunday', '2023-08-18', 3, 'http://dummyimage.com/200x100.png/ffc107/000000', 'Soothing soul vocals and rhythm.'),
    (25, 3, 25, 'Hard Rock Heaven', '2021-09-12', 4, 'http://dummyimage.com/200x100.png/cc0000/ffffff', 'Heavy guitars and live pyros.'),
    (26, 3, 26, 'Urban Culture Jam', '2021-09-13', 5, 'http://dummyimage.com/200x100.png/007bff/ffffff', 'Street culture meets live beats.'),
    (27, 4, 27, 'Latin Fiesta', '2024-07-07', 5, 'http://dummyimage.com/200x100.png/28a745/ffffff', 'Latin music, salsa, and carnival vibes.'),
    (28, 4, 28, 'Tiki Tunes', '2024-07-08', 4, 'http://dummyimage.com/200x100.png/6f42c1/ffffff', 'Island-style acoustic and beats.'),
    (29, 5, 29, 'Trap Legends', '2025-05-03', 3, 'http://dummyimage.com/200x100.png/ff4444/ffffff', 'Best of trap and drill music.'),
    (30, 5, 30, 'Lyric Masters', '2025-05-04', 4, 'http://dummyimage.com/200x100.png/dddddd/000000', 'Focus on powerful lyrical delivery.'),
    (31, 6, 1, 'Neo-Soul Sessions', '2023-10-03', 3, 'http://dummyimage.com/200x100.png/007bff/ffffff', 'New soul artists perform live.'),
    (32, 6, 2, 'Indie Groove', '2023-10-04', 4, 'http://dummyimage.com/200x100.png/ffc107/000000', 'Indie pop and rock fusion night.'),
    (33, 7, 3, 'EDM Power Hour', '2022-11-22', 3, 'http://dummyimage.com/200x100.png/6f42c1/ffffff', 'Back-to-back DJ sets.'),
    (34, 7, 4, 'Digital Harmony', '2022-11-23', 4, 'http://dummyimage.com/200x100.png/cc0000/ffffff', 'AI-assisted music sessions.'),
    (35, 8, 5, 'Mountain Folk', '2024-04-05', 3, 'http://dummyimage.com/200x100.png/28a745/ffffff', 'Live folk from mountain regions.'),
    (36, 8, 6, 'Village Voices', '2024-04-06', 2, 'http://dummyimage.com/200x100.png/5fa2dd/ffffff', 'Traditional vocals and choirs.'),
    (37, 9, 7, 'Glitch Hop Madness', '2026-09-16', 5, 'http://dummyimage.com/200x100.png/dddddd/000000', 'Fast-paced glitch-hop night.'),
    (38, 9, 8, 'Sound Architects', '2026-09-17', 4, 'http://dummyimage.com/200x100.png/007bff/ffffff', 'Experimental music engineers.'),
    (39, 10, 9, 'Peace Parade', '2027-06-11', 4, 'http://dummyimage.com/200x100.png/ffc107/000000', 'Celebrating harmony and peace.'),
    (40, 10, 10, 'Voices of Unity', '2027-06-12', 3, 'http://dummyimage.com/200x100.png/6f42c1/ffffff', 'Diverse vocal groups unite.');


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
    (1, 'Christos', 'Iliak', 18, 'sad@gmail.com', '3245823598', NULL, NULL),
    (2, 'Jessica', 'Smith', 78, 'andreayang@lewis.biz', '349-205-1094', NULL, NULL),
    (3, 'Jennifer', 'Wright', 71, 'fortega@alexander.com', '525.695.7372', NULL, NULL),
    (4, 'Michele', 'George', 63, 'donna22@yahoo.com', '(642)984-3607x38539', NULL, NULL),
    (5, 'Samantha', 'Mahoney', 48, 'etyler@curry.biz', '(268)467-1120x433', NULL, NULL),
    (6, 'Tyler', 'Bowers', 23, 'amurray@hotmail.com', '+1-900-542-6104x199', NULL, NULL),
    (7, 'Morgan', 'Lopez', 77, 'jessicasandoval@yahoo.com', '+1-563-434-9639x3574', NULL, NULL),
    (8, 'Kendra', 'Malone', 18, 'megan74@hotmail.com', '346.331.4088x954', NULL, NULL),
    (9, 'Angela', 'Garcia', 32, 'bboyle@porter-hall.com', '+1-238-243-7780x3096', NULL, NULL),
    (10, 'Larry', 'Cook', 89, 'marcus59@johnson.com', '667-201-7080x1843', NULL, NULL),
    (11, 'William', 'Roberts', 51, 'poliver@valenzuela.com', '118-331-5852x751', NULL, NULL),
    (12, 'Joshua', 'Perry', 27, 'trevor66@zamora-houston.com', '+1-631-816-2550x3973', NULL, NULL),
    (13, 'Brandon', 'Jones', 33, 'tolson@hotmail.com', '(344)697-7043', NULL, NULL),
    (14, 'Ryan', 'Richards', 25, 'mary55@santos.com', '(623)196-1554', NULL, NULL),
    (15, 'Joshua', 'Pena', 55, 'ccabrera@hernandez.net', '+1-995-460-2271x8125', NULL, NULL),
    (16, 'Shelby', 'Brooks', 14, 'avelez@fuller.org', '+1-158-274-9086x7815', NULL, NULL),
    (17, 'Jessica', 'Williams', 90, 'uhall@yahoo.com', '+1-620-830-0149x010', NULL, NULL),
    (18, 'Ernest', 'Gill', 41, 'xkeith@yahoo.com', '001-345-578-5063x155', NULL, NULL),
    (19, 'Jennifer', 'Cohen', 62, 'denniswalker@yahoo.com', '6757328427', NULL, NULL),
    (20, 'Justin', 'Singh', 51, 'shenderson@barr.org', '001-576-383-0941x919', NULL, NULL),
    (21, 'Larry', 'Parker', 33, 'yescobar@hotmail.com', '693-973-1093', NULL, NULL),
    (22, 'Michael', 'White', 49, 'nicole58@doyle.info', '(270)643-5844', NULL, NULL),
    (23, 'Joseph', 'Oneill', 15, 'lauragreen@zimmerman.info', '001-530-815-5325x493', NULL, NULL),
    (24, 'Michael', 'Payne', 43, 'hoganlauren@yahoo.com', '719-616-7229x28726', NULL, NULL),
    (25, 'Stacy', 'Johnson', 26, 'barrerabryce@hotmail.com', '001-235-724-7363x247', NULL, NULL),
    (26, 'Kelly', 'Foster', 53, 'hardingsydney@hotmail.com', '+1-305-989-2424x462', NULL, NULL),
    (27, 'Tyler', 'Rice', 87, 'emitchell@yahoo.com', '001-731-726-1004x002', NULL, NULL),
    (28, 'John', 'Jennings', 76, 'lauren78@oliver-parsons.com', '758-874-6054x2311', NULL, NULL),
    (29, 'Daniel', 'Harris', 35, 'timothysmith@powers-kelly.com', '+1-862-712-0393x0845', NULL, NULL),
    (30, 'Lisa', 'Mccarthy', 87, 'nathan90@blackburn.info', '001-171-669-3925x669', NULL, NULL);


    INSERT INTO Ticket (ticket_id, event_id, visitor_id, ticket_type_id, purchase_date, price, payment_method_id, ean_code, used, photo_url, photo_description)
    VALUES
    (1, 1, 1, 1, '2025-06-02 14:30:00', 120.00, 1, '1234567890123', FALSE, NULL, NULL),
    (2, 1, 1, 1, '2025-06-03 14:00:00', 130.00, 1, '1234567890155', FALSE, NULL, NULL),
    (3, 21, 22, 1, '2025-05-15', 93.77, 3, '1000000000003', FALSE, NULL, NULL),
    (4, 6, 28, 1, '2025-05-22', 111.14, 1, '1000000000004', TRUE, NULL, NULL),
    (5, 13, 27, 1, '2025-06-25', 164.34, 1, '1000000000005', TRUE, NULL, NULL),
    (6, 4, 14, 3, '2025-05-22', 108.84, 1, '1000000000006', TRUE, NULL, NULL),
    (7, 35, 11, 3, '2025-05-19', 138.46, 1, '1000000000007', FALSE, NULL, NULL),
    (8, 39, 2, 3, '2025-06-05', 124.31, 3, '1000000000008', TRUE, NULL, NULL),
    (9, 22, 9, 2, '2025-06-21', 66.11, 3, '1000000000009', TRUE, NULL, NULL),
    (10, 2, 5, 1, '2025-06-18', 51.05, 2, '1000000000010', FALSE, NULL, NULL),
    (11, 34, 9, 2, '2025-05-21', 65.73, 3, '1000000000011', FALSE, NULL, NULL),
    (12, 8, 12, 1, '2025-06-11', 56.32, 3, '1000000000012', TRUE, NULL, NULL),
    (13, 11, 17, 3, '2025-06-01', 161.5, 1, '1000000000013', FALSE, NULL, NULL),
    (14, 7, 2, 3, '2025-05-24', 119.33, 3, '1000000000014', FALSE, NULL, NULL),
    (15, 39, 5, 2, '2025-05-28', 60.15, 1, '1000000000015', FALSE, NULL, NULL),
    (16, 25, 29, 2, '2025-05-10', 145.12, 1, '1000000000016', FALSE, NULL, NULL),
    (17, 32, 7, 3, '2025-06-24', 66.3, 1, '1000000000017', TRUE, NULL, NULL),
    (18, 19, 28, 2, '2025-05-06', 110.08, 2, '1000000000018', FALSE, NULL, NULL),
    (19, 3, 20, 1, '2025-05-03', 82.43, 1, '1000000000019', TRUE, NULL, NULL),
    (20, 35, 20, 3, '2025-05-17', 91.33, 3, '1000000000020', FALSE, NULL, NULL),
    (21, 31, 5, 1, '2025-06-18', 82.69, 1, '1000000000021', FALSE, NULL, NULL),
    (22, 40, 8, 3, '2025-05-28', 149.86, 3, '1000000000022', TRUE, NULL, NULL),
    (23, 37, 29, 2, '2025-05-06', 120.17, 2, '1000000000023', TRUE, NULL, NULL),
    (24, 30, 8, 2, '2025-05-09', 156.61, 2, '1000000000024', TRUE, NULL, NULL),
    (25, 7, 25, 3, '2025-06-27', 167.83, 1, '1000000000025', TRUE, NULL, NULL),
    (26, 32, 11, 2, '2025-05-16', 119.97, 3, '1000000000026', TRUE, NULL, NULL),
    (27, 4, 18, 1, '2025-05-22', 164.98, 1, '1000000000027', TRUE, NULL, NULL),
    (28, 30, 3, 2, '2025-06-18', 68.61, 2, '1000000000028', FALSE, NULL, NULL),
    (29, 22, 8, 2, '2025-06-29', 193.75, 1, '1000000000029', TRUE, NULL, NULL),
    (30, 40, 16, 1, '2025-06-11', 138.62, 1, '1000000000030', TRUE, NULL, NULL),
    (31, 33, 14, 1, '2025-05-23', 181.12, 2, '1000000000031', FALSE, NULL, NULL),
    (32, 40, 30, 3, '2025-05-20', 71.42, 1, '1000000000032', TRUE, NULL, NULL),
    (33, 20, 26, 3, '2025-05-13', 115.8, 2, '1000000000033', TRUE, NULL, NULL),
    (34, 14, 14, 3, '2025-06-16', 85.25, 2, '1000000000034', TRUE, NULL, NULL),
    (35, 27, 21, 3, '2025-05-30', 199.84, 1, '1000000000035', FALSE, NULL, NULL),
    (36, 29, 16, 3, '2025-06-11', 82.14, 2, '1000000000036', TRUE, NULL, NULL),
    (37, 37, 27, 2, '2025-06-13', 88.22, 1, '1000000000037', TRUE, NULL, NULL),
    (38, 14, 24, 3, '2025-06-06', 121.02, 2, '1000000000038', TRUE, NULL, NULL),
    (39, 7, 16, 2, '2025-06-15', 58.9, 2, '1000000000039', FALSE, NULL, NULL),
    (40, 40, 26, 2, '2025-06-06', 137.59, 1, '1000000000040', TRUE, NULL, NULL),
    (41, 9, 14, 2, '2025-06-28', 71.68, 2, '1000000000041', FALSE, NULL, NULL),
    (42, 10, 19, 2, '2025-06-28', 80.85, 3, '1000000000042', TRUE, NULL, NULL),
    (43, 7, 2, 2, '2025-05-15', 75.43, 2, '1000000000043', TRUE, NULL, NULL),
    (44, 28, 4, 3, '2025-05-14', 147.17, 3, '1000000000044', FALSE, NULL, NULL),
    (45, 16, 24, 1, '2025-05-27', 123.87, 1, '1000000000045', TRUE, NULL, NULL),
    (46, 5, 21, 1, '2025-05-10', 164.35, 2, '1000000000046', TRUE, NULL, NULL),
    (47, 35, 6, 1, '2025-06-09', 118.2, 1, '1000000000047', TRUE, NULL, NULL),
    (48, 26, 2, 3, '2025-05-14', 91.67, 1, '1000000000048', TRUE, NULL, NULL),
    (49, 18, 26, 3, '2025-06-19', 92.65, 3, '1000000000049', TRUE, NULL, NULL),
    (50, 10, 10, 3, '2025-06-04', 88.94, 1, '1000000000050', FALSE, NULL, NULL),
    (51, 8, 17, 2, '2025-06-14', 189.44, 3, '1000000000051', TRUE, NULL, NULL),
    (52, 26, 1, 1, '2025-05-02', 165.25, 1, '1000000000052', FALSE, NULL, NULL),
    (53, 14, 29, 2, '2025-05-19', 54.63, 2, '1000000000053', FALSE, NULL, NULL),
    (54, 4, 22, 2, '2025-05-16', 118.88, 3, '1000000000054', FALSE, NULL, NULL),
    (55, 32, 20, 1, '2025-06-14', 173.19, 2, '1000000000055', TRUE, NULL, NULL),
    (56, 32, 21, 1, '2025-05-09', 132.94, 1, '1000000000056', FALSE, NULL, NULL),
    (57, 34, 5, 3, '2025-05-18', 170.85, 1, '1000000000057', FALSE, NULL, NULL),
    (58, 33, 23, 1, '2025-05-19', 160.04, 3, '1000000000058', TRUE, NULL, NULL),
    (59, 4, 30, 3, '2025-05-20', 177.73, 3, '1000000000059', FALSE, NULL, NULL),
    (60, 7, 20, 3, '2025-06-18', 75.7, 2, '1000000000060', FALSE, NULL, NULL),
    (61, 5, 24, 1, '2025-06-17', 162.61, 1, '1000000000061', TRUE, NULL, NULL),
    (62, 34, 10, 2, '2025-05-15', 157.11, 1, '1000000000062', TRUE, NULL, NULL),
    (63, 16, 21, 1, '2025-06-14', 100.27, 2, '1000000000063', FALSE, NULL, NULL),
    (64, 37, 16, 2, '2025-05-28', 198.53, 1, '1000000000064', TRUE, NULL, NULL),
    (65, 35, 26, 3, '2025-06-02', 183.57, 1, '1000000000065', TRUE, NULL, NULL),
    (66, 26, 19, 3, '2025-06-09', 63.04, 1, '1000000000066', TRUE, NULL, NULL),
    (67, 30, 21, 3, '2025-05-14', 89.2, 2, '1000000000067', TRUE, NULL, NULL),
    (68, 22, 6, 1, '2025-06-15', 195.55, 1, '1000000000068', TRUE, NULL, NULL),
    (69, 24, 16, 2, '2025-05-31', 95.34, 2, '1000000000069', FALSE, NULL, NULL),
    (70, 13, 14, 1, '2025-05-19', 127.06, 2, '1000000000070', FALSE, NULL, NULL),
    (71, 10, 16, 2, '2025-05-25', 134.03, 2, '1000000000071', TRUE, NULL, NULL),
    (72, 38, 10, 1, '2025-05-21', 124.89, 1, '1000000000072', TRUE, NULL, NULL),
    (73, 36, 1, 2, '2025-05-04', 125.43, 2, '1000000000073', TRUE, NULL, NULL),
    (74, 27, 10, 3, '2025-06-18', 55.93, 2, '1000000000074', TRUE, NULL, NULL),
    (75, 18, 26, 3, '2025-05-01', 113.71, 3, '1000000000075', TRUE, NULL, NULL),
    (76, 27, 3, 1, '2025-06-02', 86.37, 3, '1000000000076', TRUE, NULL, NULL),
    (77, 14, 1, 2, '2025-06-12', 131.49, 1, '1000000000077', TRUE, NULL, NULL),
    (78, 10, 13, 3, '2025-06-02', 63.93, 2, '1000000000078', FALSE, NULL, NULL),
    (79, 8, 1, 3, '2025-05-13', 171.11, 1, '1000000000079', FALSE, NULL, NULL),
    (80, 27, 7, 2, '2025-05-25', 50.56, 3, '1000000000080', FALSE, NULL, NULL),
    (81, 20, 16, 3, '2025-06-03', 119.63, 1, '1000000000081', FALSE, NULL, NULL),
    (82, 17, 23, 3, '2025-06-16', 142.17, 3, '1000000000082', TRUE, NULL, NULL),
    (83, 23, 29, 1, '2025-06-28', 171.02, 3, '1000000000083', TRUE, NULL, NULL),
    (84, 33, 15, 1, '2025-06-22', 112.36, 3, '1000000000084', FALSE, NULL, NULL),
    (85, 34, 19, 3, '2025-05-30', 188.12, 2, '1000000000085', TRUE, NULL, NULL),
    (86, 32, 21, 1, '2025-05-03', 166.31, 3, '1000000000086', TRUE, NULL, NULL),
    (87, 35, 26, 2, '2025-05-29', 184.63, 3, '1000000000087', FALSE, NULL, NULL),
    (88, 37, 12, 1, '2025-06-19', 108.33, 1, '1000000000088', FALSE, NULL, NULL),
    (89, 36, 25, 2, '2025-06-23', 196.95, 3, '1000000000089', FALSE, NULL, NULL),
    (90, 29, 2, 3, '2025-06-06', 194.85, 2, '1000000000090', TRUE, NULL, NULL),
    (91, 7, 22, 3, '2025-05-10', 147.36, 3, '1000000000091', FALSE, NULL, NULL),
    (92, 17, 18, 1, '2025-06-09', 72.42, 1, '1000000000092', FALSE, NULL, NULL),
    (93, 23, 13, 1, '2025-05-09', 99.95, 2, '1000000000093', TRUE, NULL, NULL),
    (94, 38, 14, 1, '2025-05-11', 127.88, 3, '1000000000094', TRUE, NULL, NULL),
    (95, 35, 7, 3, '2025-06-01', 149.17, 1, '1000000000095', FALSE, NULL, NULL),
    (96, 23, 1, 1, '2025-05-02', 119.52, 3, '1000000000096', TRUE, NULL, NULL),
    (97, 18, 15, 1, '2025-05-24', 87.41, 3, '1000000000097', TRUE, NULL, NULL),
    (98, 15, 7, 1, '2025-06-25', 146.67, 1, '1000000000098', TRUE, NULL, NULL),
    (99, 16, 18, 2, '2025-06-10', 194.86, 2, '1000000000099', FALSE, NULL, NULL),
    (100, 33, 25, 3, '2025-05-02', 104.61, 2, '1000000000100', TRUE, NULL, NULL),
    (101, 12, 10, 3, '2025-06-06', 67.92, 1, '1000000000101', TRUE, NULL, NULL),
    (102, 8, 1, 2, '2025-05-25', 187.8, 2, '1000000000102', FALSE, NULL, NULL),
    (103, 15, 13, 1, '2025-05-20', 96.92, 1, '1000000000103', FALSE, NULL, NULL),
    (104, 29, 18, 1, '2025-05-09', 77.13, 1, '1000000000104', FALSE, NULL, NULL),
    (105, 2, 22, 3, '2025-05-25', 185.54, 2, '1000000000105', FALSE, NULL, NULL),
    (106, 31, 9, 2, '2025-06-09', 83.25, 3, '1000000000106', FALSE, NULL, NULL),
    (107, 33, 11, 2, '2025-06-14', 114.75, 3, '1000000000107', TRUE, NULL, NULL),
    (108, 39, 21, 1, '2025-05-27', 78.46, 1, '1000000000108', FALSE, NULL, NULL),
    (109, 25, 23, 1, '2025-06-25', 137.73, 3, '1000000000109', FALSE, NULL, NULL),
    (110, 24, 16, 2, '2025-05-13', 50.15, 2, '1000000000110', TRUE, NULL, NULL),
    (111, 4, 27, 1, '2025-05-13', 175.37, 2, '1000000000111', FALSE, NULL, NULL),
    (112, 20, 9, 2, '2025-06-08', 124.49, 2, '1000000000112', TRUE, NULL, NULL),
    (113, 35, 21, 1, '2025-05-26', 188.5, 1, '1000000000113', FALSE, NULL, NULL),
    (114, 24, 29, 1, '2025-05-29', 134.69, 1, '1000000000114', FALSE, NULL, NULL),
    (115, 19, 4, 3, '2025-06-04', 97.41, 2, '1000000000115', FALSE, NULL, NULL),
    (116, 5, 4, 2, '2025-05-23', 107.26, 3, '1000000000116', TRUE, NULL, NULL),
    (117, 32, 30, 2, '2025-05-16', 69.93, 3, '1000000000117', TRUE, NULL, NULL),
    (118, 6, 2, 2, '2025-05-25', 162.48, 1, '1000000000118', FALSE, NULL, NULL),
    (119, 18, 30, 1, '2025-06-14', 190.27, 3, '1000000000119', TRUE, NULL, NULL),
    (120, 9, 16, 2, '2025-06-30', 143.08, 2, '1000000000120', TRUE, NULL, NULL),
    (121, 8, 17, 1, '2025-05-06', 139.14, 3, '1000000000121', FALSE, NULL, NULL),
    (122, 15, 24, 3, '2025-05-12', 126.67, 1, '1000000000122', FALSE, NULL, NULL),
    (123, 1, 30, 3, '2025-06-03', 63.31, 1, '1000000000123', FALSE, NULL, NULL),
    (124, 6, 26, 2, '2025-05-16', 130.8, 3, '1000000000124', TRUE, NULL, NULL),
    (125, 10, 27, 1, '2025-05-09', 152.53, 3, '1000000000125', FALSE, NULL, NULL),
    (126, 9, 2, 3, '2025-05-18', 79.34, 1, '1000000000126', TRUE, NULL, NULL),
    (127, 40, 1, 3, '2025-06-19', 66.33, 1, '1000000000127', FALSE, NULL, NULL),
    (128, 7, 3, 1, '2025-05-08', 84.1, 3, '1000000000128', FALSE, NULL, NULL),
    (129, 36, 10, 2, '2025-06-28', 100.56, 2, '1000000000129', TRUE, NULL, NULL),
    (130, 38, 16, 2, '2025-06-05', 118.11, 1, '1000000000130', FALSE, NULL, NULL),
    (131, 27, 8, 3, '2025-05-09', 117.17, 1, '1000000000131', TRUE, NULL, NULL),
    (132, 8, 28, 3, '2025-06-02', 148.39, 3, '1000000000132', FALSE, NULL, NULL),
    (133, 16, 20, 2, '2025-05-02', 134.98, 2, '1000000000133', TRUE, NULL, NULL),
    (134, 26, 16, 1, '2025-05-02', 92.46, 1, '1000000000134', TRUE, NULL, NULL),
    (135, 3, 24, 3, '2025-06-15', 138.72, 3, '1000000000135', FALSE, NULL, NULL),
    (136, 30, 22, 1, '2025-05-22', 116.87, 2, '1000000000136', TRUE, NULL, NULL),
    (137, 2, 25, 1, '2025-06-23', 163.57, 1, '1000000000137', TRUE, NULL, NULL),
    (138, 21, 5, 3, '2025-05-30', 59.73, 1, '1000000000138', TRUE, NULL, NULL),
    (139, 5, 7, 2, '2025-05-26', 157.21, 2, '1000000000139', TRUE, NULL, NULL),
    (140, 26, 22, 1, '2025-06-23', 52.62, 1, '1000000000140', FALSE, NULL, NULL),
    (141, 27, 25, 2, '2025-05-28', 97.92, 3, '1000000000141', FALSE, NULL, NULL),
    (142, 11, 13, 3, '2025-06-08', 118.27, 3, '1000000000142', FALSE, NULL, NULL),
    (143, 1, 24, 1, '2025-06-23', 114.77, 2, '1000000000143', TRUE, NULL, NULL),
    (144, 38, 29, 1, '2025-05-08', 92.92, 1, '1000000000144', FALSE, NULL, NULL),
    (145, 22, 19, 2, '2025-06-20', 192.45, 3, '1000000000145', TRUE, NULL, NULL),
    (146, 16, 7, 1, '2025-06-01', 194.61, 2, '1000000000146', FALSE, NULL, NULL),
    (147, 30, 8, 1, '2025-06-14', 147.12, 3, '1000000000147', TRUE, NULL, NULL),
    (148, 29, 19, 3, '2025-05-20', 129.76, 2, '1000000000148', TRUE, NULL, NULL),
    (149, 27, 7, 3, '2025-05-26', 117.46, 3, '1000000000149', FALSE, NULL, NULL),
    (150, 8, 25, 3, '2025-05-07', 117.22, 1, '1000000000150', TRUE, NULL, NULL),
    (151, 27, 8, 2, '2025-06-13', 194.04, 1, '1000000000151', TRUE, NULL, NULL),
    (152, 18, 8, 2, '2025-05-29', 189.51, 1, '1000000000152', TRUE, NULL, NULL),
    (153, 19, 13, 3, '2025-05-29', 146.3, 3, '1000000000153', TRUE, NULL, NULL),
    (154, 11, 5, 1, '2025-06-27', 120.47, 2, '1000000000154', FALSE, NULL, NULL),
    (155, 34, 13, 1, '2025-06-17', 194.56, 3, '1000000000155', FALSE, NULL, NULL),
    (156, 9, 14, 1, '2025-05-27', 184.79, 1, '1000000000156', TRUE, NULL, NULL),
    (157, 31, 2, 1, '2025-06-30', 164.36, 2, '1000000000157', TRUE, NULL, NULL),
    (158, 9, 10, 3, '2025-05-26', 71.75, 3, '1000000000158', TRUE, NULL, NULL),
    (159, 31, 15, 2, '2025-05-12', 140.42, 1, '1000000000159', FALSE, NULL, NULL),
    (160, 39, 14, 1, '2025-05-01', 197.34, 3, '1000000000160', FALSE, NULL, NULL),
    (161, 4, 18, 2, '2025-05-11', 159.78, 1, '1000000000161', TRUE, NULL, NULL),
    (162, 34, 2, 3, '2025-06-11', 121.33, 2, '1000000000162', FALSE, NULL, NULL),
    (163, 22, 10, 3, '2025-06-10', 139.82, 3, '1000000000163', FALSE, NULL, NULL),
    (164, 27, 30, 1, '2025-06-02', 84.16, 2, '1000000000164', TRUE, NULL, NULL),
    (165, 25, 10, 1, '2025-06-29', 81.43, 2, '1000000000165', FALSE, NULL, NULL),
    (166, 30, 15, 3, '2025-05-02', 155.77, 3, '1000000000166', TRUE, NULL, NULL),
    (167, 28, 1, 1, '2025-06-08', 168.9, 3, '1000000000167', TRUE, NULL, NULL),
    (168, 14, 30, 1, '2025-06-02', 153.88, 2, '1000000000168', FALSE, NULL, NULL),
    (169, 24, 19, 2, '2025-05-28', 63.79, 1, '1000000000169', TRUE, NULL, NULL),
    (170, 22, 28, 3, '2025-05-12', 109.07, 2, '1000000000170', TRUE, NULL, NULL),
    (171, 20, 7, 3, '2025-06-18', 58.68, 1, '1000000000171', FALSE, NULL, NULL),
    (172, 32, 3, 1, '2025-05-16', 73.5, 3, '1000000000172', TRUE, NULL, NULL),
    (173, 38, 25, 2, '2025-05-26', 113.59, 2, '1000000000173', FALSE, NULL, NULL),
    (174, 1, 5, 1, '2025-06-16', 81.28, 1, '1000000000174', TRUE, NULL, NULL),
    (175, 40, 25, 3, '2025-06-09', 125.12, 3, '1000000000175', FALSE, NULL, NULL),
    (176, 39, 16, 2, '2025-06-23', 120.97, 3, '1000000000176', FALSE, NULL, NULL),
    (177, 15, 16, 1, '2025-06-30', 174.25, 2, '1000000000177', TRUE, NULL, NULL),
    (178, 3, 18, 2, '2025-06-29', 53.46, 2, '1000000000178', TRUE, NULL, NULL),
    (179, 29, 26, 1, '2025-06-14', 194.26, 1, '1000000000179', FALSE, NULL, NULL),
    (180, 5, 15, 3, '2025-06-11', 104.17, 3, '1000000000180', TRUE, NULL, NULL),
    (181, 19, 25, 1, '2025-06-04', 98.89, 3, '1000000000181', TRUE, NULL, NULL),
    (182, 27, 6, 3, '2025-05-30', 51.92, 3, '1000000000182', TRUE, NULL, NULL),
    (183, 23, 30, 2, '2025-06-04', 87.69, 1, '1000000000183', FALSE, NULL, NULL),
    (184, 36, 6, 1, '2025-05-07', 118.13, 2, '1000000000184', FALSE, NULL, NULL),
    (185, 28, 14, 2, '2025-05-26', 80.03, 1, '1000000000185', TRUE, NULL, NULL),
    (186, 26, 5, 2, '2025-06-18', 194.61, 2, '1000000000186', FALSE, NULL, NULL),
    (187, 20, 5, 1, '2025-06-13', 130.61, 2, '1000000000187', FALSE, NULL, NULL),
    (188, 37, 27, 3, '2025-05-25', 161.29, 3, '1000000000188', TRUE, NULL, NULL),
    (189, 21, 18, 3, '2025-06-27', 167.41, 3, '1000000000189', TRUE, NULL, NULL),
    (190, 31, 29, 3, '2025-05-28', 125.14, 1, '1000000000190', FALSE, NULL, NULL),
    (191, 31, 30, 3, '2025-05-05', 70.65, 2, '1000000000191', FALSE, NULL, NULL),
    (192, 16, 14, 1, '2025-05-21', 137.52, 2, '1000000000192', TRUE, NULL, NULL),
    (193, 36, 20, 3, '2025-05-11', 158.13, 3, '1000000000193', TRUE, NULL, NULL),
    (194, 18, 30, 3, '2025-06-27', 95.89, 1, '1000000000194', TRUE, NULL, NULL),
    (195, 13, 4, 3, '2025-05-12', 137.1, 3, '1000000000195', TRUE, NULL, NULL),
    (196, 28, 4, 3, '2025-05-16', 146.18, 3, '1000000000196', TRUE, NULL, NULL),
    (197, 15, 30, 1, '2025-05-10', 130.14, 2, '1000000000197', TRUE, NULL, NULL),
    (198, 12, 18, 1, '2025-05-22', 153.78, 2, '1000000000198', TRUE, NULL, NULL),
    (199, 19, 19, 2, '2025-05-19', 196.82, 3, '1000000000199', TRUE, NULL, NULL),
    (200, 35, 23, 3, '2025-06-03', 188.83, 2, '1000000000200', TRUE, NULL, NULL),
    (201, 38, 4, 3, '2025-05-27', 108.22, 2, '1000000000201', TRUE, NULL, NULL),
    (202, 3, 28, 1, '2025-05-21', 120.26, 3, '1000000000202', FALSE, NULL, NULL);


    INSERT INTO Resale_Buyer (buyer_id, name, surname, age, email, phone_number, photo_url, photo_description)
    VALUES (1, 'Alexandra', 'Papadopoulou', 28, 'alexandra.p@example.com', '+306912345678', 'http://dummyimage.com/200x100.png/5fa2dd/ffffff', 'Profile photo of Alexandra at a concert.');


    INSERT INTO Resale_Queue (resale_id, ticket_id, seller_id, listing_date, price, status) 
    VALUES (1, 1, 1, '2025-04-01', 120.00,FALSE);

    /*TODO: Correct the queries and the queue of insertion of them*/
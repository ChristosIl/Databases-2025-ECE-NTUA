-- Disable foreign key checks before dropping tables
SET FOREIGN_KEY_CHECKS=0; 

DROP TABLE IF EXISTS Continent;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS Festival;
DROP TABLE IF EXISTS Stage;
DROP TABLE IF EXISTS Event;
DROP TABLE IF EXISTS Staff_role;
DROP TABLE IF EXISTS Experience_level;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Artist;
DROP TABLE IF EXISTS Band;
DROP TABLE IF EXISTS Performs;
DROP TABLE IF EXISTS Performance;
DROP TABLE IF EXISTS Payment_method;
DROP TABLE IF EXISTS Visitor;
DROP TABLE IF EXISTS Ticket_type;
DROP TABLE IF EXISTS Ticket;
DROP TABLE IF EXISTS Rating;
DROP TABLE IF EXISTS Resale_Buyer;
DROP TABLE IF EXISTS Resale_Queue;
DROP TABLE IF EXISTS Works_on;
DROP TABLE IF EXISTS Demand_queue;
DROP TABLE IF EXISTS Buys_specific_ticket;
DROP TABLE IF EXISTS Belongs_to;
DROP TABLE IF EXISTS Resale_Log;
DROP TABLE IF EXISTS Music_genres;
DROP TABLE IF EXISTS Sub_music_genres;
-- Enables again foreign keys
SET FOREIGN_KEY_CHECKS = 1;

-- Continent Lookup Table
CREATE TABLE IF NOT EXISTS Continent (
    continent_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);
-- Location Table
CREATE TABLE IF NOT EXISTS Location (
    location_id INT AUTO_INCREMENT PRIMARY KEY ,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL,
    latitude DECIMAL(9,6) NOT NULL,
    country VARCHAR(255) NOT NULL,
    continent_id INT NOT NULL,
    photo_url TEXT NOT NULL, 
    photo_description TEXT NOT NULL,

    FOREIGN KEY (continent_id) REFERENCES Continent(continent_id)
);

-- Festival Table
CREATE TABLE IF NOT EXISTS Festival (
    festival_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    location_id INT NOT NULL,
    year INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    duration_days INT,
    photo_url TEXT NOT NULL, 
    photo_description TEXT NOT NULL,
    
    FOREIGN KEY (location_id) REFERENCES Location(location_id),
    UNIQUE (year, name) /* Constraint: only one specific festival per year*/
);
/*To Do: Trigger to check the location of the next year*/

-- Stage Table
CREATE TABLE IF NOT EXISTS Stage (
    stage_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,       
    description TEXT,                 
    max_capacity INT,                 
    infos_technical_equipment TEXT,  
    photo_url TEXT NOT NULL,          
    photo_description TEXT NOT NULL   
);

-- Event Table
CREATE TABLE IF NOT EXISTS Event (
    event_id INT NOT NULL PRIMARY KEY,
    festival_id INT NOT NULL,
    stage_id INT NOT NULL,
    event_name VARCHAR(255) NOT NULL,
    event_date DATE NOT NULL,
    duration INT NOT NULL,
    photo_url TEXT NOT NULL, 
    photo_description TEXT NOT NULL,
    FOREIGN KEY (festival_id) REFERENCES Festival(festival_id),
    FOREIGN KEY (stage_id) REFERENCES Stage(stage_id)
);

-- Staff Role Table 
CREATE TABLE IF NOT EXISTS Staff_role (
    staff_role_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Experience level Lookup Table
CREATE TABLE IF NOT EXISTS Experience_level (
    experience_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Staff Table
CREATE TABLE IF NOT EXISTS Staff (
    staff_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    staff_role_id INT NOT NULL,
    experience_id INT NOT NULL,
    photo_url TEXT NOT NULL, 
    photo_description TEXT NOT NULL,

    FOREIGN KEY (staff_role_id) REFERENCES Staff_role(staff_role_id),
    FOREIGN KEY (experience_id) REFERENCES Experience_level(experience_id)
);

-- Music genre Lookup Table -- 
CREATE TABLE IF NOT EXISTS Music_genres(
    music_genre_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Sub music genre Lookup Table --
CREATE TABLE IF NOT EXISTS Sub_music_genres(
    sub_music_genre_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    music_genre_id INT,

    FOREIGN KEY (music_genre_id) REFERENCES Music_genres(music_genre_id)
);
-- Artist Table
CREATE TABLE IF NOT EXISTS Artist (
    artist_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    nickname VARCHAR(255),
    birth_date DATE NOT NULL,
    is_solo BOOLEAN NOT NULL,
    website VARCHAR(255),
    instagram VARCHAR(255),
    photo_url TEXT NOT NULL, 
    photo_description TEXT NOT NULL

);

-- Artist Music genres many-to-many relationship Table --
CREATE TABLE IF NOT EXISTS Artist_music_genres (
    artist_id INT,
    music_genre_id INT,
    PRIMARY KEY (artist_id, music_genre_id),
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id),
    FOREIGN KEY (music_genre_id) REFERENCES Music_genres(music_genre_id)
);

-- Artist Sub Music genres many-to-many relationship Table --
CREATE TABLE IF NOT EXISTS Artist_sub_music_genres (
    artist_id INT,
    sub_music_genre_id INT,
    PRIMARY KEY (artist_id, sub_music_genre_id),
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id),
    FOREIGN KEY (sub_music_genre_id) REFERENCES Sub_music_genres(sub_music_genre_id)
);

-- Band Table
CREATE TABLE IF NOT EXISTS Band (
    band_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    formation_date DATE,
    member_list TEXT,
    instagram TEXT,
    website TEXT,
    photo_url TEXT,
    photo_description TEXT

);

-- Performs Table
CREATE TABLE IF NOT EXISTS Performs (
    performs_id INT NOT NULL PRIMARY KEY,
    artist_id INT,
    band_id INT,
   /* performance_id INT,*/

    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id),
    FOREIGN KEY (band_id) REFERENCES Band(band_id),
    /*FOREIGN KEY (performance_id) REFERENCES Performance(performance_id),*/

    CONSTRAINT chk_only_one_entity_of_performer
    CHECK(
        (artist_id IS NOT NULL AND band_id IS NULL) OR (artist_id IS NULL AND band_id IS NOT NULL) 
    )
);

-- Performance Table
CREATE TABLE IF NOT EXISTS Performance (
    performance_id INT NOT NULL PRIMARY KEY,
    event_id INT NOT NULL,
    performs_id INT NOT NULL,
    type_of_performance VARCHAR(255) NOT NULL,
    duration FLOAT NOT NULL, 
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    photo_url TEXT,
    photo_description TEXT,

    CONSTRAINT duration_of_performance
        CHECK (duration <= 3.0),

    FOREIGN KEY(event_id) REFERENCES Event(event_id),
    FOREIGN KEY(performs_id) REFERENCES Performs(performs_id) 
);

-- Visitor Table
CREATE TABLE IF NOT EXISTS Visitor (
    visitor_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(20) NOT NULL,
    photo_url TEXT,
    photo_description TEXT,

    CONSTRAINT check_age CHECK (age >= 12 AND age <= 99),
    CONSTRAINT check_email
        CHECK (
            email IS NULL OR
            email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
        )
);

-- Ticket Type Table
CREATE TABLE IF NOT EXISTS Ticket_type (
    ticket_type_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Payment_method Lookup Table
CREATE TABLE IF NOT EXISTS Payment_method ( 
    payment_method_id INT NOT NULL PRIMARY KEY, 
    name VARCHAR(50) NOT NULL UNIQUE,

    CONSTRAINT chk_payment_method CHECK (name IN ('Credit Card', 'Debit Card', 'Bank Transfer'))    
);

-- Ticket Table
CREATE TABLE IF NOT EXISTS Ticket (
    ticket_id INT NOT NULL PRIMARY KEY,
    event_id INT NOT NULL,
    visitor_id INT NOT NULL,
    ticket_type_id INT NOT NULL,
    purchase_date DATE NOT NULL,
    price DECIMAL(6,2) NOT NULL,     
    payment_method_id INT NOT NULL,
    ean_code VARCHAR(20) NOT NULL,
    used BOOLEAN NOT NULL DEFAULT FALSE,
    photo_url TEXT,
    photo_description TEXT,
    FOREIGN KEY (event_id) REFERENCES Event(event_id),
    FOREIGN KEY (visitor_id) REFERENCES Visitor(visitor_id),
    FOREIGN KEY (ticket_type_id) REFERENCES Ticket_type(ticket_type_id),
    FOREIGN KEY (payment_method_id) REFERENCES Payment_method(payment_method_id),

    CONSTRAINT check_price_be_over_zero CHECK (price > 0),
    CONSTRAINT check_used_value CHECK (used IS TRUE OR used IS FALSE)
    
);

-- Rating Table (we use likert rating)
CREATE TABLE IF NOT EXISTS Rating (
    rating_id INT NOT NULL PRIMARY KEY,
    ticket_id INT NOT NULL,
    performance_id INT NOT NULL,
    interpretation_rating INT NOT NULL CHECK (interpretation_rating BETWEEN 1 AND 5),
    sound_and_lighting_rating INT NOT NULL CHECK (sound_and_lighting_rating BETWEEN 1 AND 5),
    stage_presence_rating INT NOT NULL CHECK (stage_presence_rating BETWEEN 1 AND 5),
    organization_rating INT NOT NULL CHECK (organization_rating BETWEEN 1 AND 5),
    overall_impression INT NOT NULL CHECK (overall_impression BETWEEN 1 AND 5),
    photo_url TEXT,
    photo_description TEXT,
    FOREIGN KEY (ticket_id) REFERENCES Ticket(ticket_id),
    FOREIGN KEY (performance_id) REFERENCES Performance(performance_id)
);

-- Resale Buyer Table
CREATE TABLE IF NOT EXISTS Resale_Buyer (
    buyer_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(20),
    photo_url TEXT,
    photo_description TEXT,

    CONSTRAINT chk_age CHECK (age >= 12 AND age <= 99),
    CONSTRAINT chk_email
        CHECK (
            email IS NULL OR
            email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
        )
);

-- Resale Ticket Table
CREATE TABLE IF NOT EXISTS Resale_Queue (
    resale_id INT NOT NULL PRIMARY KEY,
    ticket_id INT NOT NULL,
    seller_id INT NOT NULL,  /* first owner of the ticket */
    listing_date DATE,
    price  FLOAT(6,2) NOT NULL,
    status BOOLEAN NOT NULL, 

    FOREIGN KEY (ticket_id) REFERENCES Ticket(ticket_id) ,
    FOREIGN KEY (seller_id) REFERENCES Visitor(visitor_id) 
);

-- Works on Table
CREATE TABLE IF NOT EXISTS Works_on (
    staff_id INT NOT NULL,
    stage_id INT NOT NULL,
    event_id INT NOT NULL,

    PRIMARY KEY (stage_id, staff_id, event_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (stage_id) REFERENCES Stage(stage_id),
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
);

CREATE TABLE IF NOT EXISTS Demand_Queue(
    demand_id INT NOT NULL PRIMARY KEY,
    buyer_id INT NOT NULL,
    preferred_ticket_type INT,
    preferred_event_id INT,
    request_date DATE NOT NULL,
    status BOOLEAN NOT NULL DEFAULT FALSE, 

    FOREIGN KEY (buyer_id) REFERENCES Resale_Buyer(buyer_id) ON DELETE CASCADE
);

-- Table to store logs from direct buys
CREATE TABLE IF NOT EXISTS Buys_specific_ticket(
    buyer_id INT NOT NULL,
    resale_id INT NOT NULL,
    interest_date DATE,
    status VARCHAR(20),

    
    PRIMARY KEY (buyer_id, resale_id)
);

-- Belongs to Table 
CREATE TABLE IF NOT EXISTS Belongs_to (
    artist_id INT NOT NULL,
    band_id INT NOT NULL,

    PRIMARY KEY (artist_id, band_id),
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id),
    FOREIGN KEY (band_id) REFERENCES Band(band_id)
);

CREATE TABLE Resale_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT,
    old_owner_id INT,
    new_owner_id INT,
    sale_price DECIMAL(10,2),
    sale_date DATETIME DEFAULT NOW()
);

-- Creating Indexes after all tables are created
CREATE INDEX idx_performer_nickname ON Artist(nickname);



-- View to check the population of assigned staff to every stage --
CREATE OR REPLACE VIEW Stage_Staff_Coverage AS
SELECT 
    w.event_id,
    w.stage_id,
    stg.name AS stage_name,
    stf.staff_role_id,
    r.name AS role_name,
    COUNT(*) AS assigned_staff,
    stg.max_capacity,
    CASE 
        WHEN stf.staff_role_id = 2 THEN ROUND(stg.max_capacity * 0.05, 0)
        WHEN stf.staff_role_id = 3 THEN ROUND(stg.max_capacity * 0.02, 0)
        ELSE 0
    END AS required_staff,
    CASE 
        WHEN stf.staff_role_id IN (2, 3) THEN 
            CASE 
                WHEN COUNT(*) >= 
                    CASE 
                        WHEN stf.staff_role_id = 2 THEN ROUND(stg.max_capacity * 0.05, 0)
                        WHEN stf.staff_role_id = 3 THEN ROUND(stg.max_capacity * 0.02, 0)
                    END 
                THEN '✔ OK'
                ELSE '✘ Understaffed'
            END
        ELSE 'N/A'
    END AS status
FROM Works_on w
JOIN Stage stg ON w.stage_id = stg.stage_id
JOIN Staff stf ON w.staff_id = stf.staff_id
JOIN Staff_role r ON stf.staff_role_id = r.staff_role_id
WHERE stf.staff_role_id IN (2, 3) -- Only security and support
GROUP BY w.event_id, w.stage_id, stf.staff_role_id;




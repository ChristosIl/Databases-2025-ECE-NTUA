-- Disable foreign key checks before dropping tables
SET FOREIGN_KEY_CHECKS=0; 

DROP TABLE IF EXISTS Festival;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS Event;
DROP TABLE IF EXISTS Stage;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Performance;
DROP TABLE IF EXISTS Performer;
DROP TABLE IF EXISTS Band;
DROP TABLE IF EXISTS Band_member;
DROP TABLE IF EXISTS Solo_Artists;
DROP TABLE IF EXISTS Visitor;

-- Enables again foreign keys
SET FOREIGN_KEY_CHECKS = 1;

-- Location Table
CREATE TABLE IF NOT EXISTS Location (
    location_id INT PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL,
    latitude DECIMAL(9,6) NOT NULL,
    country VARCHAR(255) NOT NULL,
    continent VARCHAR(255) NOT NULL,
    photo_url TEXT NOT NULL, 
    photo_description TEXT NOT NULL
);

-- Festival Table
CREATE TABLE IF NOT EXISTS Festival (
    festival_id INT NOT NULL PRIMARY KEY,
    year INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    duration_days INT,
    duration_per_day INT,
    photo_url TEXT NOT NULL, 
    photo_description TEXT NOT NULL,
    location_id INT NOT NULL,
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

-- Stage Table
CREATE TABLE IF NOT EXISTS Stage (
    stage_id INT NOT NULL PRIMARY KEY,
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

-- Staff Table
CREATE TABLE IF NOT EXISTS Staff (
    staff_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    role VARCHAR(255) NOT NULL,
    experience INT NOT NULL,
    photo_url TEXT NOT NULL, 
    photo_description TEXT NOT NULL
);

-- Performer Table
CREATE TABLE IF NOT EXISTS Performer (
    performer_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    nickname VARCHAR(255),
    birth_date DATE NOT NULL,
    is_solo BOOLEAN NOT NULL,
    music_genres VARCHAR(255) NOT NULL,
    sub_music_genres VARCHAR(255) NOT NULL,
    website VARCHAR(255),
    instagram VARCHAR(255),
    photo_url TEXT NOT NULL, 
    photo_description TEXT NOT NULL
);

-- Solo Artist Table
CREATE TABLE IF NOT EXISTS Solo_Artists (
    performer_id INT PRIMARY KEY,
    FOREIGN KEY (performer_id) REFERENCES Performer(performer_id) 
);

-- Band Table
CREATE TABLE IF NOT EXISTS Band (
    band_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    formation_date DATE,
    website TEXT,
    photo_url TEXT,
    photo_description TEXT
);
-- For now its only many to one relationship
CREATE TABLE IF NOT EXISTS Band_member (
    performer_id INT NOT NULL PRIMARY KEY,
    band_id INT NOT NULL,
    FOREIGN KEY (performer_id) REFERENCES Performer(performer_id),
    FOREIGN KEY (band_id) REFERENCES Band(band_id)
);

CREATE TABLE IF NOT EXISTS Performance (
    performance_id INT NOT NULL PRIMARY KEY,
    event_id INT NOT NULL,
    stage_id INT NOT NULL, 
    performer_id INT NOT NULL,
    type_of_performance VARCHAR(255) NOT NULL,
    duration FLOAT NOT NULL, 
    start_time FLOAT NOT NULL,
    end_time FLOAT NOT NULL,
    photo_url TEXT,
    photo_description TEXT,

    FOREIGN KEY(event_id) REFERENCES Event(event_id),
    FOREIGN KEY(stage_id) REFERENCES Stage(stage_id),
    FOREIGN KEY(performer_id) REFERENCES Performer(performer_id) 
);

-- Visitor Table
CREATE TABLE IF NOT EXISTS Visitor (
    visitor_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(255),
    phone_number VARCHAR(20) NOT NULL,
    photo_url TEXT,
    photo_description TEXT
);

-- Ticket Table
CREATE TABLE IF NOT EXISTS Ticket (
    ticket_id INT NOT NULL PRIMARY KEY,
    event_id INT NOT NULL,
    stage_id INT NOT NULL, 
    visitor_id INT NOT NULL,
    ticket_type VARCHAR(40) NOT NULL,
    purchase_date DATE NOT NULL,
    price DECIMAL(6,2) NOT NULL,     
    payment_method VARCHAR(40) NOT NULL,
    ean_code VARCHAR(20) NOT NULL,
    used BOOLEAN NOT NULL,
    photo_url TEXT,
    photo_description TEXT,
    FOREIGN KEY (event_id) REFERENCES Event(event_id),
    FOREIGN KEY (stage_id) REFERENCES Stage(stage_id),
    FOREIGN KEY (visitor_id) REFERENCES Visitor(visitor_id)
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
    email VARCHAR(255),
    phone_number VARCHAR(20),
    photo_url TEXT,
    photo_description TEXT
);

-- Resale Ticket Table
CREATE TABLE IF NOT EXISTS Resale_Queue (
    resale_id INT NOT NULL PRIMARY KEY,
    ticket_id INT NOT NULL,
    seller_id INT NOT NULL,  /* first owner of the ticket */
    buyer_id INT,  
    request_date DATE NOT NULL,
    listing_date DATE,
    purchase_date DATE,
    preferred_event_id INT,
    preferred_ticket_type VARCHAR(50),
    status VARCHAR(50), 

    FOREIGN KEY (ticket_id) REFERENCES Ticket(ticket_id) ,
    FOREIGN KEY (seller_id) REFERENCES Visitor(visitor_id) ,
    FOREIGN KEY (buyer_id) REFERENCES Resale_Buyer(buyer_id),
    FOREIGN KEY (preferred_event_id) REFERENCES Event(event_id)
);


-- Creating Indexes after all tables are created
CREATE INDEX idx_performer_nickname ON Performer(nickname);

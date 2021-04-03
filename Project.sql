

DROP TABLE IF EXISTS countries;
CREATE TABLE countries(
    id SERIAL,
    name VARCHAR(255),
    language VARCHAR(255),
    
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NULL ON UPDATE NOW()
);

DROP TABLE IF EXISTS championships;
CREATE TABLE championships(
    id SERIAL,
    name VARCHAR(255) NOT NULL,
    country_id BIGINT UNSIGNED NOT NULL,
    level TINYINT(10) DEFAULT 0,
    clubs_q TINYINT UNSIGNED DEFAULT 20,
    clubs_to_promote TINYINT UNSIGNED DEFAULT 3,
    clubs_to_demote TINYINT UNSIGNED DEFAULT 3,
    start_month TINYINT(12) UNSIGNED DEFAULT 9,
    end_month TINYINT(12) UNSIGNED DEFAULT 5,

    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NULL ON UPDATE NOW()
);


DROP TABLE IF EXISTS stadiums;
CREATE TABLE stadiums(
    id SERIAL,
    name VARCHAR(255) NOT NULL,
    country_id BIGINT UNSIGNED NOT NULL,
    built_date DATETIME,
    city VARCHAR(255),

    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NULL ON UPDATE NOW(),

    FOREIGN KEY (country_id) REFERENCES countries(id)
);
    

DROP TABLE IF EXISTS football_clubs;
CREATE TABLE football_clubs(
    id SERIAL,
    name VARCHAR(255),
    country_id BIGINT UNSIGNED NOT NULL,
    found_at DATETIME,
    home_stadium_id BIGINT UNSIGNED NOT NULL,
    home_city VARCHAR(255),

    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NULL ON UPDATE NOW(),

    FOREIGN KEY (country_id) REFERENCES countries(id),
    FOREIGN KEY (home_stadium_id) REFERENCES stadiums(id)
);


DROP TABLE IF EXISTS clubs_in_championships;
CREATE TABLE clubs_in_championships(
    id SERIAL,
    club_id BIGINT UNSIGNED NOT NULL,
    championship_id BIGINT UNSIGNED NOT NULL,
    year TINYINT UNSIGNED COMMENT "Year the club is in the league counting from 1900",
    place_taken TINYINT UNSIGNED,

    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NULL ON UPDATE NOW(),

    FOREIGN KEY (club_id) REFERENCES countries(id),
    FOREIGN KEY (championship_id) REFERENCES championships(id)
);


DROP TABLE IF EXISTS participants;
CREATE TABLE participants(
    id SERIAL,
    first_name VARCHAR(255) NOT NULL,
    second_name VARCHAR(255) NOT NULL,
    country_id BIGINT UNSIGNED NOT NULL,
    birthday DATETIME,
    preffered_position enum('GK','LD','CD','RD','LM','CM','RM','AM','DM','RF','CF','LF','Manager','Agent','trainer','other position') NOT NULL DEFAULT 'other position',
    is_retired BIT NOT NULL DEFAULT 0,

    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NULL ON UPDATE NOW(),

    FOREIGN KEY (country_id) REFERENCES countries(id)
);











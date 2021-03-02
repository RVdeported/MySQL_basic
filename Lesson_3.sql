USE vk;

# list of user's music
DROP TABLE IF EXISTS audio;
CREATE TABLE audio(
    id SERIAL,
    owner_id BIGINT UNSIGNED NOT NULL,
    band VARCHAR(255),
    song_name VARCHAR(255),
    created_on DATE COMMENT 'date of the song was written',
    filename VARCHAR(255),
    created_at DATETIME DEFAULT NOW(),
    lenght_sec SMALLINT,
    accsess_rights ENUM('all', 'friends', 'owner'),
    
    PRIMARY KEY (band, song_name),
    FOREIGN KEY (owner_id) REFERENCES users(id)
);

# table to potentially add option of showing your original city, current city and etc.
DROP TABLE IF EXISTS cities;
CREATE TABLE cities(
    id SERIAL,
    name VARCHAR(255),
    country_name VARCHAR(255),
    location POINT,
    
    PRIMARY KEY (name, country_name) COMMENT 'geoposition may slightly vary'
);


# table for ads to be shown in vk.
# This table contains only ads available to show and
# does not include information about where to put it, viewership statistics,
# and etc. I imagine each of the elements must have individual table(s).
DROP TABLE IF EXISTS ads;
CREATE TABLE ads(
	id SERIAL,
	company_id BIGINT UNSIGNED NOT NULL COMMENT 'company-owner of the ad',
	filename VARCHAR(255),
	description VARCHAR(255),
	age_restrictions ENUM('PG','E','NC-17')

	# the table needs another table with company details
	# FOREIGN KEY (company_id) REFERENCES companies(id)
);

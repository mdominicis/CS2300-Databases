-- Create the database
CREATE DATABASE IF NOT EXISTS WeatherDatabase;
USE WeatherDatabase;

-- Create the 'coordinates' table
CREATE TABLE coordinates (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    latitude DECIMAL(9, 6),
    longitude DECIMAL(9, 6)
);

-- Create the 'station_type' table
CREATE TABLE station_type (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

-- Create the 'weather_event_type' table
CREATE TABLE weather_event_type (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

-- Create the 'station' table
CREATE TABLE station (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    coordinates_id INT,
    install_date DATE,
    type_id INT,
    head_meteorologist_id INT,
    FOREIGN KEY (coordinates_id) REFERENCES coordinates(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (type_id) REFERENCES station_type(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (head_meteorologist_id) REFERENCES head_meteorologist(ID) ON DELETE SET NULL ON UPDATE CASCADE -- New foreign key constraint
);

-- Create the 'head_meteorologist' table
CREATE TABLE head_meteorologist (
     ID INT AUTO_INCREMENT PRIMARY KEY,
     name VARCHAR(255) NOT NULL UNIQUE,
     experience INT
);

-- Create the 'weather_event' table
CREATE TABLE weather_event(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    severity INT,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES weather_event_type(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create the 'city' table
CREATE TABLE city (
    coordinates_id INT PRIMARY KEY,
    name VARCHAR(255),
    population INT NOT NULL,
    FOREIGN KEY (coordinates_id) REFERENCES coordinates(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create the 'sensors' table
CREATE TABLE sensors (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    calibration_date DATE NOT NULL,
    manufacturer VARCHAR(255),
    reading_time DATETIME NOT NULL,
    response_time TIME NOT NULL
);

-- Create the 'thermometer' table
CREATE TABLE thermometer(
    sensor_id INT AUTO_INCREMENT PRIMARY KEY,
    unit VARCHAR(50),
    material VARCHAR(255),
    FOREIGN KEY (sensor_id) REFERENCES sensors(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create the 'barometer' table
CREATE TABLE barometer(
    sensor_id INT AUTO_INCREMENT PRIMARY KEY,
    unit VARCHAR(50),
    material VARCHAR(255),
    FOREIGN KEY (sensor_id) REFERENCES sensors(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create the 'anemometer' table
CREATE TABLE anemometer(
    sensor_id INT AUTO_INCREMENT PRIMARY KEY,
    unit VARCHAR(50),
    material VARCHAR(255),
    FOREIGN KEY (sensor_id) REFERENCES sensors(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Junction table 'forecast'
CREATE TABLE forecast (
     timestamp DATE,
     pressure INT,
     temperature INT,
     wind_speed INT,
     humidity INT,
     coordinates_id INT,
     station_id INT,
     PRIMARY KEY (timestamp),
     FOREIGN KEY (coordinates_id) REFERENCES coordinates(ID) ON DELETE CASCADE ON UPDATE CASCADE,
     FOREIGN KEY (station_id) REFERENCES station(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Junction table 'occurs'
CREATE TABLE occurs (
     city_id INT,
     weather_event_id INT,
     PRIMARY KEY (city_id, weather_event_id),
     FOREIGN KEY (city_id) REFERENCES city(ID) ON DELETE CASCADE ON UPDATE CASCADE,
     FOREIGN KEY (weather_event_id) REFERENCES weather_event(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create the 'user' table
CREATE TABLE user(
    Username varchar(20),
    Password varchar(20),
    PRIMARY KEY(Username)
);
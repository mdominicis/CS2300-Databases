-- Insert into 'coordinates' table
INSERT INTO coordinates (latitude, longitude) VALUES
    (48.8566, 2.3522), -- Paris
    (35.6895, 139.6917), -- Tokyo
    (-33.8688, 151.2093), -- Sydney
    (55.7558, 37.6173), -- Moscow
    (19.0760, 72.8777); -- Mumbai

-- Insert into 'station_type' table
INSERT INTO station_type (name) VALUES
    ('Urban'),
    ('Suburban'),
    ('Coastal'),
    ('Mountain'),
    ('Desert');

-- Insert into 'weather_event_type' table
INSERT INTO weather_event_type (name) VALUES
    ('Thunderstorm'),
    ('Fog'),
    ('Blizzard'),
    ('Hurricane'),
    ('Tornado');

-- Insert into 'head_meteorologist' table
INSERT INTO head_meteorologist (name, experience) VALUES
    ('Lisa Green', 7),
    ('Carlos Hernandez', 15),
    ('Amina Khan', 9),
    ('Chen Wei', 11),
    ('Igor Ivanov', 13);

-- Insert into 'station' table
INSERT INTO station (name, coordinates_id, install_date, type_id, head_meteorologist_id) VALUES
    ('Paris Climate Station', 4, '2021-05-20', 4, 4),
    ('Tokyo Weather Observatory', 5, '2022-07-10', 5, 5),
    ('Sydney Meteorological Center', 6, '2020-03-15', 1, 6),
    ('Moscow Atmospheric Station', 7, '2019-09-05', 2, 7),
    ('Mumbai Environmental Hub', 8, '2018-12-30', 3, 8);

-- Insert into 'weather_event' table
INSERT INTO weather_event (severity, start_time, end_time, type_id) VALUES
    (4, '2023-12-15 10:00:00', '2023-12-16 18:00:00', 4),
    (2, '2023-12-20 07:00:00', '2023-12-21 09:00:00', 5),
    (6, '2023-12-25 12:00:00', '2023-12-26 20:00:00', 6),
    (7, '2023-12-30 08:00:00', '2023-12-31 23:00:00', 7),
    (5, '2024-01-04 14:00:00', '2024-01-05 19:00:00', 8);

-- Insert into 'city' table
INSERT INTO city (coordinates_id, name, population) VALUES
    (4, 'Paris', 2148000),
    (5, 'Tokyo', 13929286),
    (6, 'Sydney', 5312000),
    (7, 'Moscow', 11920000),
    (8, 'Mumbai', 12478447);

-- Insert into 'sensors' table
INSERT INTO sensors (calibration_date, manufacturer, reading_time, response_time) VALUES
    ('2023-02-15', 'GlobalSensors Inc.', '2023-12-15 11:00:00', '00:00:08'),
    ('2022-10-25', 'ClimateTech', '2023-12-20 07:30:00', '00:00:12'),
    ('2021-04-10', 'WeatherMasters', '2023-12-25 13:00:00', '00:00:07'),
    ('2020-08-05', 'EnviroSense', '2023-12-30 09:00:00', '00:00:10'),
    ('2019-11-20', 'AtmosData', '2024-01-04 15:00:00', '00:00:09');

-- Insert into 'thermometer' table
INSERT INTO thermometer (sensor_id, unit, material) VALUES
    (4, 'Celsius', 'Digital'),
    (5, 'Fahrenheit', 'Bimetallic'),
    (6, 'Celsius', 'Mercury'),
    (7, 'Fahrenheit', 'Alcohol'),
    (8, 'Celsius', 'Digital');

-- Insert into 'barometer' table
INSERT INTO barometer (sensor_id, unit, material) VALUES
    (4, 'mmHg', 'Digital'),
    (5, 'hPa', 'Mercury'),
    (6, 'mmHg', 'Aneroid'),
    (7, 'hPa', 'Digital'),
    (8, 'mmHg', 'Mercury');

-- Insert into 'anemometer' table
INSERT INTO anemometer (sensor_id, unit, material) VALUES
    (4, 'm/s', 'Laser'),
    (5, 'km/h', 'Ultrasonic'),
    (6, 'm/s', 'Vane'),
    (7, 'km/h', 'Hot-wire'),
    (8, 'm/s', 'Laser');

-- Insert into 'forecast' table
INSERT INTO forecast (timestamp, pressure, temperature, wind_speed, humidity, coordinates_id, station_id) VALUES
    ('2023-12-15', 1018, 10, 15, 60, 4, 4),
    ('2023-12-20', 1023, 5, 10, 75, 5, 5),
    ('2023-12-25', 1010, 25, 20, 55, 6, 6),
    ('2023-12-30', 1005, -5, 25, 80, 7, 7),
    ('2024-01-04', 1015, 30, 5, 65, 8, 8);

-- Insert into 'occurs' table
INSERT INTO occurs (city_id, weather_event_id) VALUES
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8);

-- Insert into 'user' table
INSERT INTO user (Username, Password) VALUES
    ('user4', 'pass1111'),
    ('user5', 'pass2222'),
    ('user6', 'pass3333'),
    ('user7', 'pass4444'),
    ('user8', 'pass5555');
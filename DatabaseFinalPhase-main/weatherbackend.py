import mysql.connector
from dotenv import load_dotenv
import os
from datetime import datetime

def login(cursor):
    username = input("Please enter your username: ")
    cursor.execute(f"SELECT Username,Password FROM User WHERE Username='{username}';")
    userinfo = cursor.fetchone()

    if userinfo is None:
        print("Username not found. Please try again.")
        return False

    password = input("Please enter your password: ")
    if password!=userinfo[1]:
        print("Incorrect password. Please try again.")
        return False
    return True

def addUser(cursor):
    username = input("Please enter your username: ")
    password = input("Please enter your password: ")
    try:
        sql = "INSERT INTO User VALUES(%s, %s);"
        values = (username, password)
        cursor.execute(sql, values)
        connector.commit()
        return True
    except mysql.connector.Error:
        print("Username already exists! Try again.")

def addForecast():
    coordinates = int(input("Enter coordinates: "))
    humidity = int(input("Enter humidity: "))
    pressure = int(input("Enter pressure: "))
    stationID = int(input("Enter station ID: "))
    temperature = int(input("Enter temperature: "))
    now = datetime.now()
    timestamp = now.strftime('%Y-%m-%d %H:%M:%S')
    wind_speed = input("Enter wind speed: ")
    try:
        sql = """
            INSERT INTO forecast
            (timestamp, pressure, temperature, wind_speed, humidity, coordinates_id, station_id)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        values = (timestamp, pressure, temperature, wind_speed, humidity, coordinates, stationID)
        cursor.execute(sql,values)
        print("Insert succesful!")
    except Exception as e:
        print(f"Insert Failed: {e}")

def getClosestStation(cursor):
    city=input("What city do you live in: ")
    cursor.execute(f"SELECT station.name,station_type.name,install_date FROM station INNER JOIN city ON station.coordinates_id=city.coordinates_id INNER JOIN station_type ON station.type_id=station_type.ID WHERE city.name='{city}'")
    stationinfo=cursor.fetchone()
    print(f"The closest station is called {stationinfo[0]}, it is a {stationinfo[1]} station, and it was installed on {stationinfo[2]}")
    return

def mostRecentEvent(cursor):
    cursor.reset()
    cursor.execute("SELECT * FROM weather_event ORDER BY end_time DESC;")
    recentEvent = cursor.fetchone()
    end_time = recentEvent[2]
    id = recentEvent[0]
    cursor.reset()
    cursor.execute(f"SELECT * FROM weather_event_type WHERE ID = {id};")
    eventName = cursor.fetchone()
    formatted_datetime = end_time.strftime('%Y-%m-%d')
    print(f"{eventName[1]} occured on {formatted_datetime}")
    cursor.reset()

def purchase(cursor):
    print("Which type of sensor do you want?\n1. Thermometer\n2. Barometer\n 3. Anemometer")
    choice=int(input("Please choose: "))
    if choice==1:
        #insert thermometer
        sensor='thermometer'
    elif choice==2:
        #insert barometer
        sensor='barometer'
    elif choice==3:
        sensor='anemometer'
    try:
        id = int(input("Enter the sensor ID: "))
        unit = input("Enter the units: ")
        material = input("Enter the material: ")
        sql = f"INSERT INTO {sensor} VALUES(%s, %s, %s);"
        values = (id, unit, material)
        cursor.execute(sql, values)
        connector.commit()
    except Exception as e:
        print(f"Insert failed: {e}")

def avgTemp(cursor):
    timestamp=input("Please enter timestamp: ")
    cursor.execute(f"SELECT AVG(temperature) FROM forecast GROUP BY timestamp HAVING timestamp='{timestamp}';")
    avgweather=cursor.fetchone()
    print(f"The average weather on {timestamp} is {avgweather[0]} degrees.")

def deleteSensor(cursor):
    try:
        sensorId = int(input("Enter the sensor ID to be deleted: "))
        cursor.execute(f"DELETE FROM sensors WHERE ID={sensorId}")
        print("Sensor Deleted")
    except Exception as e:
        print(f"Delete failed: {e}")

load_dotenv()
# connector = mysql.connector.connect(host = os.getenv('DB_HOST'),user=os.getenv('DB_USER'),password=os.getenv('DB_PASSWORD'))
# instead of "Mst_2026", type in the password set during setup
connector = mysql.connector.connect(host = "localhost", user = "root", password="Mst_2026")
cursor = connector.cursor()
cursor.execute("USE WeatherDatabase;")
os.system('clear')

print("Hello, welcome to the WeatherDatabase! The one stop shop for all things weather!")
print("What would you like to do today?")
print("Input 1 to log in")
print("Input 2 to create an account")
account = int(input("Please choose an option: "))
os.system('clear')
signedin=False

while not signedin:
    if(account == 1):
        signedin = login(cursor)
    elif(account == 2):
        signedin = addUser(cursor)
    else:
        account = int(input("Please choose an option: "))

os.system('clear')
choice = 0
while choice != 6:
    choice = int(input("Do you want to:\n1. Add a forecast\n2. Find a station in your city\n3. See the most recent weather event around the world\n4. Get average temperature\n5. Purchase a sensor\n6. Delete a sensor\n7. Exit \nPlease choose an option:"))
    connector.commit()
    if choice == 1:
        addForecast()
    elif choice == 2:
        getClosestStation(cursor)
    elif choice == 3:
        mostRecentEvent(cursor)
    elif choice==4:
        avgTemp(cursor)
    elif choice==5:
        purchase(cursor)
    elif choice == 6:
        deleteSensor(cursor)
    elif choice == 7:
        break
    else:
        print()
        print("That's not an option. Try again.")

connector.commit()
import requests

# API Configuration
API_KEY = '******************'  
API_URL = 'http://api.aviationstack.com/v1/flights'

# Parameters for fetching active flights departing from Frankfurt
params = {
    'access_key': API_KEY,
    'flight_status': 'active',
    'dep_iata': 'FRA'  # Frankfurt Airport IATA code
}

# Fetch data from the API
response = requests.get(API_URL, params=params)
data = response.json()

# Process and display flight data
if data.get('data'):
    print("Real-Time Flight Data from Frankfurt Airport (FRA):")
    for flight in data['data']:
        flight_number = flight['flight']['iata']
        departure_airport = flight['departure']['airport']
        arrival_airport = flight['arrival']['airport']
        flight_status = flight['flight_status']
        print(f"Flight {flight_number} from {departure_airport} to {arrival_airport} is {flight_status}")
else:
    print("No flight data found or API request failed.")
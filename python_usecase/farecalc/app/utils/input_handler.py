from app.exceptions import (
    InvalidVehicleTypeException,
    InvalidInputException
)
from app.utils.validators import (
    validate_vehicle_type,
    validate_distance,
    validate_hour
)
def get_valid_distance():
    while True:
        try:
            distance=float(input("Enter distance:"))
            validate_distance(distance)
            return distance
        except (ValueError, InvalidInputException) as e:
            print(e)

def get_valid_vehicle_type():
    while True:
        try:
            vehicle_type=input("Enter vehicle type:")
            validate_vehicle_type(vehicle_type)
            return vehicle_type
        except (ValueError, InvalidVehicleTypeException) as e:
            print(e)


def get_valid_hour():
    while True:
        try:
            hour=int(input("Enter hour:"))
            validate_hour(hour)
            return hour
        except (ValueError, InvalidInputException) as e:
            print(e)
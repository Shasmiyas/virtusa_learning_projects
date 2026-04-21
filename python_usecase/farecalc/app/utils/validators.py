from app.config import VEHICLE_RATES
from app.exceptions import (
    InvalidVehicleTypeException,
    InvalidInputException
)

def validate_vehicle_type(vehicle_type:str):
    if vehicle_type.lower() not in VEHICLE_RATES:
        raise InvalidVehicleTypeException("Service not available")
    
def validate_distance(distance:float):
    if(distance<=0):
        raise InvalidInputException("Distance must be greater than 0")

def validate_hour(hour:int):
    if(hour<0 or hour>23):
        raise InvalidInputException("Hour must be from 0 to 23")
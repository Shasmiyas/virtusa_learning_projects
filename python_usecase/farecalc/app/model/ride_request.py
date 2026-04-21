from pydantic import BaseModel,validator
from app.utils.validators import (
    validate_vehicle_type,
    validate_distance,
    validate_hour
)

class RideRequest(BaseModel):
    distance:float
    vehicle_type:str
    hour:int

    @validator("distance")
    def check_distance(cls,value):
        validate_distance(value)
        return value
    
    @validator("vehicle_type")
    def check_vehicle_type(cls,value):
        validate_vehicle_type(value)
        return value
    
    @validator("hour")
    def check_hour(cls,value):
        validate_hour(value)
        return value


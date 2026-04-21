from app.config import VEHICLE_RATES,SURGE_CONFIG
from app.model.ride_request import RideRequest
from app.model.ride_response import RideResponse

class FareCalculation:

    @staticmethod
    def apply_surge(hour:int) -> bool:
        if(hour>=SURGE_CONFIG["start_time"] and hour<=SURGE_CONFIG["end_time"]):
            return True
        return False
    
    @staticmethod
    def calculate_fare(request: RideRequest)->RideResponse:
        rate=VEHICLE_RATES[request.vehicle_type]

        base_fare=request.distance * rate
        surge = FareCalculation.apply_surge(request.hour)

        total_fare=(
            base_fare * SURGE_CONFIG["multiplier"]
            if surge
            else base_fare
        )
        surge_applied=total_fare-base_fare

        return RideResponse(
            base_fare=base_fare,
            surge_applied=surge_applied,
            total_fare=total_fare
        )
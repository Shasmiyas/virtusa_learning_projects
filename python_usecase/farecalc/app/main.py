from app.model.ride_request import RideRequest
from app.model.ride_response import RideResponse
from app.service.fare_service import FareCalculation
from app.utils.input_handler import (
get_valid_distance,
get_valid_vehicle_type,
get_valid_hour
)


def main():
    while(True):
                distance=get_valid_distance()
                vehicle_type=get_valid_vehicle_type()
                hour=get_valid_hour()

                request=RideRequest(
                    distance=distance,
                    vehicle_type=vehicle_type,
                    hour=hour
                )
                response=FareCalculation.calculate_fare(request)

                print(response)
                choice="y"
                while(True):
                    choice=input("do you want to continue?(y/n)")
                    if(choice not in ["y","n"]):
                        print("Choose valid choice!")
                    else:
                          break
                if(choice=="n"):
                      break

if __name__=="__main__":
     main()
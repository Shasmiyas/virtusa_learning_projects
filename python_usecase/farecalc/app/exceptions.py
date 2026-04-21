class FareCalculationException(Exception):
    def __init__(self,message:str = "Application error"):
        self.message=message
        super().__init__(message)

class InvalidVehicleTypeException(FareCalculationException):
    def __init__(self,message:str = "Service not available"):
        super().__init__(message)

class InvalidInputException(FareCalculationException):
    def __init__(self,message:str = "Invalid input"):
        super().__init__(message)
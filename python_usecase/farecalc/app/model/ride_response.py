from pydantic import BaseModel

class RideResponse(BaseModel):
    base_fare:float
    surge_applied:float
    total_fare:float

    def __str__(self):
        return (
            f"\nReceipt\n"
            f"Base Fare    :${self.base_fare}\n"
            f"Surge Applied:${self.surge_applied}\n"
            f"Total Fare   :${self.total_fare}\n"
            f"-----------------------------------"
        )
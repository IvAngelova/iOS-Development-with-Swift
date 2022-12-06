import UIKit

//(Litres used X 100) ÷ km travelled = Litres per 100km.
func calculateAvgFuelConsumptionPer100Km(distanceInKm: Double, usedFuelLiters: Double) -> Double {
    let avgConsumption = (usedFuelLiters * 100) / distanceInKm
    return avgConsumption
}

func convertL100KMToMPG(l100km: Double) -> Double {
    return 235.21 * l100km
}

func calculateAvgPricePerKilometer(fuelPricePerLiter: Double, distanceInKm: Double, usedFuelLiters: Double) -> Double {
    return (calculateAvgFuelConsumptionPer100Km(distanceInKm: distanceInKm, usedFuelLiters: usedFuelLiters)
            * fuelPricePerLiter) / 100
    
}

func printInfoAboutFuelConsumption(date: String, distanceInKm: Double, usedFuelLiters: Double) {
    print("Fuel consumption in liters per 100km: \(calculateAvgFuelConsumptionPer100Km(distanceInKm: distanceInKm, usedFuelLiters: usedFuelLiters)), date of fueling: \(date)")
    print("Fuel consumption in mpg: \(convertL100KMToMPG(l100km: calculateAvgFuelConsumptionPer100Km(distanceInKm: distanceInKm, usedFuelLiters: usedFuelLiters))), date of fueling: \(date)")
}

printInfoAboutFuelConsumption(date: "01.01.2022", distanceInKm: 256, usedFuelLiters: 20)
print("Price per kilometer: \(calculateAvgPricePerKilometer(fuelPricePerLiter: 3, distanceInKm: 256, usedFuelLiters: 20))")


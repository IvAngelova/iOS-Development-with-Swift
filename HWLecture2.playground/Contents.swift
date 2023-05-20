import UIKit

//(Litres used X 100) ÷ km travelled = Litres per 100km.
func calculateAvgFuelConsumptionPer100Km(distanceInKm: Double, usedFuelLiters: Double) -> Double {
    let avgConsumption = (usedFuelLiters * 100) / distanceInKm
    return avgConsumption
}
//------------------------
struct FuelLog {
    let date: String
    let mileage: Double
    let fuelAmount: Double
}

var myFuelLog: [FuelLog] = [FuelLog]()

func addFuel(mileage: Double, fuelAmount: Double, dateOfFueling: String) {
    myFuelLog.append(FuelLog(date: dateOfFueling, mileage: mileage, fuelAmount: fuelAmount))
}
//Consider that the tank is being filled from empty to full!
let tankCapacity: Double = 60

func printAvgFuelConsumptionBetweenCurrentAndLastFueling (tankCapacity: Double){
    var mileageDiff: Double = 0.0
    if myFuelLog.count == 1 {
        print("The tank is fueled for a first time.")
    } else if myFuelLog.count > 1 {
        mileageDiff =  myFuelLog.last!.mileage - myFuelLog[myFuelLog.count - 2].mileage
        print("AvgFuelConsumptionBetweenCurrentAndLastFueling: \(calculateAvgFuelConsumptionPer100Km(distanceInKm: mileageDiff, usedFuelLiters: tankCapacity)) l/100km")
    } else {
        print("The tank is not fueled yet.")
    }
    
}
printAvgFuelConsumptionBetweenCurrentAndLastFueling(tankCapacity: tankCapacity)

addFuel(mileage: 70000, fuelAmount: tankCapacity, dateOfFueling: "01.01.2022")

printAvgFuelConsumptionBetweenCurrentAndLastFueling(tankCapacity: tankCapacity)

addFuel(mileage: 70400, fuelAmount: tankCapacity, dateOfFueling: "12.01.2022")

printAvgFuelConsumptionBetweenCurrentAndLastFueling(tankCapacity: tankCapacity)

//-------------------------
func convertL100KMToMPG(l100km: Double) -> Double {
    return 235.21 / l100km
}
//-------------------------
func calculateAvgPricePerKilometer(fuelPricePerLiter: Double, distanceInKm: Double, usedFuelLiters: Double) -> Double {
    return (calculateAvgFuelConsumptionPer100Km(distanceInKm: distanceInKm, usedFuelLiters: usedFuelLiters)
            * fuelPricePerLiter) / 100
    
}
//-------------------------

func printInfoAboutFuelConsumption() {
    print("Info about fuel consumption per dates of fueling: ")
    if (myFuelLog.count > 1) {
        var counter: Int = 0
        for aFuelLog in myFuelLog {
            counter += 1
            if(counter == 1 ){
                continue
            }
            print("Fuel consumption: \(calculateAvgFuelConsumptionPer100Km(distanceInKm: aFuelLog.mileage - myFuelLog[counter - 2].mileage, usedFuelLiters: tankCapacity)) l/100km for date: \(aFuelLog.date)")
            
        }
    } else {
        print("Nothing to show")
    }
}


addFuel(mileage: 70600, fuelAmount: tankCapacity, dateOfFueling: "17.01.2022")
addFuel(mileage: 70800, fuelAmount: tankCapacity, dateOfFueling: "21.01.2022")
printInfoAboutFuelConsumption()

print("Price per kilometer: \(calculateAvgPricePerKilometer(fuelPricePerLiter: 3, distanceInKm: 256, usedFuelLiters: 20))")


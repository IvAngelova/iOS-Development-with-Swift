import UIKit

// Task 1
func calculateTriangleSurfaceWith(side: Float, height: Float) -> Float {
    let surface = (side * height) / 2
    return surface
}

let surfaceTriangle = calculateTriangleSurfaceWith(side: 10, height: 4)
print(surfaceTriangle)


// Task 2
func calculateCircleSurfaceWith(radius: Float) -> Float {
    let surface = Float.pi * pow(radius, 2)
    return surface
}

func calculateCirclePerimeterWith(radius: Float) -> Float {
    let perimeter = 2 * Float.pi * radius
    return perimeter
}

let surfaceCircle = calculateCircleSurfaceWith(radius: 4)
print(surfaceCircle)
let perimeterCircle = calculateCirclePerimeterWith(radius: 4)
print(perimeterCircle)

//Task 3
struct Car {
    let make: String
    let model: String
    let horsePower: Double
    let torque: Float
    let dateOfManufacturing: String
}

func printCarDescription(car: Car) {
    print(car.make, car.model, car.horsePower, car.torque, car.dateOfManufacturing, separator: ", ")
}

let car1 = Car(make: "VW", model: "Golf", horsePower: 90, torque: 175, dateOfManufacturing: "01.01.2020")

printCarDescription(car: car1)

func printCarPowerInWatts(car: Car) {
    print(car.horsePower * 746)
}

printCarPowerInWatts(car: car1)


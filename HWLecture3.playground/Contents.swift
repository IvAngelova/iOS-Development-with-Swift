import UIKit
import Foundation

enum Currency {
    case BGN
    case EUR
    case USD
}

struct Card {
    let id: String
    let owner: String
    var currentStock: [Currency:Double]
    
    var hasUSDCurrency: Bool {
        for aKey in currentStock.keys {
            if aKey == .USD {
                return true
            }
        }
        return false
    }
    
    var hasEURCurrency: Bool {
        for aKey in currentStock.keys {
            if aKey == .EUR {
                return true
            }
        }
        return false
    }
}

struct ATM {
    let id: String
    var currentStock: [Currency:Double]
    let currencyConvertionFee: Double
    
    mutating func withdraw(card: inout Card, moneyAmountInBGN: Double) {
        if moneyAmountInBGN <= currentStock[.BGN]! && moneyAmountInBGN <= card.currentStock[.BGN]!{
            //success
            currentStock[.BGN]! -= moneyAmountInBGN
            card.currentStock[.BGN]! -= moneyAmountInBGN
            print("Current stock in ATM in BGN: \(currentStock[.BGN]!)")
            print("Current stock in card in BGN: \(card.currentStock[.BGN]!)")
        } else if moneyAmountInBGN > currentStock[.BGN]!{
            //not enough money in ATM
            print("Insufficient availability in the ATM!")
        } else {
            //not enough BGN in card
            convertCurrency(card: &card, moneyAmountInBGN: moneyAmountInBGN)
        }
    }
    
    func conversionFromEURtoBGN(eur: Double) -> Double{
        return eur * 1.956
    }
    
    func conversionFromUSDtoBGN(usd: Double) -> Double{
        return usd * 1.858
    }
    
    func conversionFromBGNtoEUR(bgn: Double) -> Double{
        return bgn / 1.956
    }
    
    func conversionFromBGNtoUSD(bgn: Double) -> Double{
        return bgn / 1.858
    }
    
    mutating func convertCurrency(card: inout Card, moneyAmountInBGN: Double) {
        let fee = moneyAmountInBGN * (self.currencyConvertionFee / 100)
        if card.hasEURCurrency {
            var amountEURToBGN = conversionFromEURtoBGN(eur: card.currentStock[.EUR]!)
            if moneyAmountInBGN + fee <= amountEURToBGN  {
                card.currentStock[.EUR]! = conversionFromBGNtoEUR(bgn: amountEURToBGN - (moneyAmountInBGN + fee))
                self.currentStock[.BGN]! -= moneyAmountInBGN
                print("Current stock in ATM in BGN: \(currentStock[.BGN]!)")
                print("Current stock in card in BGN: \(card.currentStock[.BGN]!)")
                print("Current stock in card in EUR: \(card.currentStock[.EUR]!)")
                return
            }
        }
        
        if card.hasUSDCurrency {
            var amountUSDtoBGN = conversionFromUSDtoBGN(usd: card.currentStock[.USD]!)
            if moneyAmountInBGN + fee <= amountUSDtoBGN  {
                card.currentStock[.USD]! = conversionFromBGNtoUSD(bgn: amountUSDtoBGN - (moneyAmountInBGN + fee))
                self.currentStock[.BGN]! -= moneyAmountInBGN
                print("Current stock in ATM in BGN: \(currentStock[.BGN]!)")
                print("Current stock in card in BGN: \(card.currentStock[.BGN]!)")
                print("Current stock in card in USD: \(card.currentStock[.USD]!)")
                return
            }
        }
        
        print("Insufficient availability in your card!")
    }
}


print("Example 1:")
var atmStock1: [Currency: Double] = [.BGN: 20]
var ATM1 = ATM(id: "1", currentStock: atmStock1, currencyConvertionFee: 2)
var cardStock1: [Currency: Double] = [.BGN: 80]
var card1 = Card(id: "1", owner: "A", currentStock: cardStock1)
ATM1.withdraw(card: &card1, moneyAmountInBGN: 20.00)

print("Example 2:")
var atmStock2: [Currency: Double] = [.BGN: 100]
var ATM2 = ATM(id: "2", currentStock: atmStock2, currencyConvertionFee: 2)
var cardStock2: [Currency: Double] = [.BGN: 80]
var card2 = Card(id: "2", owner: "B", currentStock: cardStock2)
ATM2.withdraw(card: &card2, moneyAmountInBGN: 80.00)

print("Example 3:")
var atmStock3: [Currency: Double] = [.BGN: 100]
var ATM3 = ATM(id: "3", currentStock: atmStock3, currencyConvertionFee: 2)
var cardStock3: [Currency: Double] = [.BGN: 80]
var card3 = Card(id: "3", owner: "C", currentStock: cardStock3)
ATM3.withdraw(card: &card3, moneyAmountInBGN: 90.00)

print("Example 4:")
var atmStock4: [Currency: Double] = [.BGN: 60]
var ATM4 = ATM(id: "4", currentStock: atmStock4, currencyConvertionFee: 2)
var cardStock4: [Currency: Double] = [.BGN: 80]
var card4 = Card(id: "4", owner: "D", currentStock: cardStock4)
ATM4.withdraw(card: &card4, moneyAmountInBGN: 80.00)

print("Example 5:")
var atmStock5: [Currency: Double] = [.BGN: 100]
var ATM5 = ATM(id: "5", currentStock: atmStock5, currencyConvertionFee: 2)
var cardStock5: [Currency: Double] = [.BGN: 80, .EUR: 60]
var card5 = Card(id: "5", owner: "E", currentStock: cardStock5)
ATM5.withdraw(card: &card5, moneyAmountInBGN: 100.00)

print("Example 6:")
var atmStock6: [Currency: Double] = [.BGN: 400]
var ATM6 = ATM(id: "6", currentStock: atmStock6, currencyConvertionFee: 2)
var cardStock6: [Currency: Double] = [.BGN: 80, .EUR: 60]
var card6 = Card(id: "6", owner: "F", currentStock: cardStock6)
ATM6.withdraw(card: &card6, moneyAmountInBGN: 150.00)

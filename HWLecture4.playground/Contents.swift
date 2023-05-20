import UIKit
import Foundation


enum Currency: String {
    case BGN = "BGN"
    case USD = "USD"
    case EUR = "EUR"
    
    var rateToBGN: Double {
        switch self {
        case .BGN:
            return 1
        case .EUR:
            return 1.956
        case .USD:
            return 1.858
        }
    }
    
    func convertToBGN(amount: Double, currencyFeeInPercent: Double) -> Double {
        switch self {
        case .BGN:
            return amount
        case .EUR, .USD:
            return amount*(self.rateToBGN/(1+currencyFeeInPercent/100))
        }
    }
    
    func convertToEUR(amount: Double, currencyFeeInPercent: Double) -> Double {
        switch self {
        case .EUR:
            return amount
        case .BGN:
            return amount/(Currency.EUR.rateToBGN/(1+currencyFeeInPercent/100))
        case .USD:
            return amount/(Currency.USD.rateToBGN/Currency.EUR.rateToBGN/(1+currencyFeeInPercent/100))
        }
    }
    
    func convertToUSD(amount: Double, currencyFeeInPercent: Double) -> Double {
        switch self {
        case .USD:
            return amount
        case .BGN:
            return amount/(Currency.USD.rateToBGN/(1+currencyFeeInPercent/100))
        case .EUR:
            return amount/(Currency.EUR.rateToBGN/Currency.USD.rateToBGN/(1+currencyFeeInPercent/100))
        }
    }
}

class BankAccount {
    var owner: String
    var IBAN: String
    var availability: [Currency: Double]
    
    init(owner: String, IBAN: String, availability: [Currency: Double]) {
        self.owner = owner
        self.IBAN = IBAN
        self.availability = availability
    }
}

struct Card {
    var id: String
    var owner: String
    var bankAccount: BankAccount
    
    func printCardBalance() {
        self.bankAccount.availability.forEach({
            print("Card balance \($0.key.rawValue):\($0.value)")
        })
    }
    
    ///Used to see which is going to be the currency for withdraw. If none of the balances is enough - it will return nil
    func getCurrencyToWithdraw(amount: Double, fee: Double) -> (currency: Currency?, amount: Double) {
        if amount <= self.bankAccount.availability[.BGN]! {
            return (.BGN, amount)
        } else if Currency.BGN.convertToEUR(amount: amount, currencyFeeInPercent: fee) <= self.bankAccount.availability[.EUR]! {
            return (.EUR, Currency.BGN.convertToEUR(amount: amount, currencyFeeInPercent: fee))
        } else if Currency.BGN.convertToUSD(amount: amount, currencyFeeInPercent: fee) <= self.bankAccount.availability[.USD]! {
            return (.USD, Currency.BGN.convertToUSD(amount: amount, currencyFeeInPercent: fee))
        } else {
            return (nil, 0)
        }
    }
    
    ///Withdraw function returns success if the withdraw is successful and false if it's not
    mutating func withdraw(amount: Double, currency: Currency) -> Bool {
        //safety to be sure that we have balance of that currency
        guard let currentBalanceForCurrency = self.bankAccount.availability[currency] else {
            return false
        }
        
        guard currentBalanceForCurrency >= amount else {
            return false
        }
        
        let finalBalance = currentBalanceForCurrency - amount
        self.bankAccount.availability[currency] = finalBalance
        return true
    }
}

class ATM {
    var id: String
    var availabilityАТМ: [Currency: Double]
    var currencyFee: Double = 2
    
    init(id: String, availabilityАТМ: [Currency: Double], currencyFee: Double){
        self.id = id
        self.availabilityАТМ = availabilityАТМ
        self.currencyFee = currencyFee
    }
    
    func withdrawing(card: Card, amount: Double, currency: Currency) -> Card? {
        var aCard = card
        
        switch currency {
        case .BGN:
            let currencyAndAmountToWithdraw = aCard.getCurrencyToWithdraw(amount: amount, fee: currencyFee)
            guard let withdrawCurrency = currencyAndAmountToWithdraw.currency else {
                print("Недостатъчна наличност по вашата сметка")
                return nil
            }
            
            guard var atmAvailability = availabilityАТМ[.BGN], atmAvailability >= amount else {
                print("Недостатъчна наличност в банкомата")
                return nil
            }
            
            guard aCard.withdraw(amount: currencyAndAmountToWithdraw.amount, currency: withdrawCurrency) == true else {
                print("Недостатъчна наличност по вашата сметка")
                return nil
            }
            
            atmAvailability -= amount
            self.availabilityАТМ[.BGN] = atmAvailability
            
            return aCard
        case .EUR:
            guard aCard.withdraw(amount: amount, currency: .EUR) == true else {
                print("Недостатъчна наличност по вашата сметка")
                return nil
            }
            
            guard var atmAvailability = availabilityАТМ[.EUR], atmAvailability >= amount else {
                print("Недостатъчна наличност в банкомата")
                return nil
            }
            
            atmAvailability -= amount
            self.availabilityАТМ[.EUR] = atmAvailability
            
            return aCard
            
        case .USD:
            guard aCard.withdraw(amount: amount, currency: .USD) == true else {
                print("Недостатъчна наличност по вашата сметка")
                return nil
            }
            
            guard var atmAvailability = availabilityАТМ[.USD], atmAvailability >= amount else {
                print("Недостатъчна наличност в банкомата")
                return nil
            }
            
            atmAvailability -= amount
            self.availabilityАТМ[.USD] = atmAvailability
            
            return aCard
        }
    }
    
    func printATMBalance() {
        self.availabilityАТМ.forEach({print("ATM Balance: \($0.key.rawValue):\($0.value)")})
    }
}

var atm = ATM(id: "1312", availabilityАТМ: [.USD: 0,.BGN: 20.0,.EUR: 0.0], currencyFee: 2.0)
var bankAccount = BankAccount(owner: "Somebody", IBAN: "abcdefg", availability: [.USD: 0.0, .EUR: 0.0, .BGN: 80.0])
var card1 = Card(id: "1", owner: "Somebody", bankAccount: bankAccount)
var card2 = Card(id: "2", owner: "Somebody", bankAccount: bankAccount)

// Example 1
print("Example 1")

if let result = atm.withdrawing(card: card1, amount: 20.0, currency: .BGN) {
    card1 = result
}

atm.printATMBalance()
card1.printCardBalance()

// Example 2
print("Example 2")
atm.availabilityАТМ[Currency.BGN] = 100.0
card2.bankAccount.availability = [Currency.USD: 0.0, Currency.EUR: 0.0, Currency.BGN: 80.0]

if let result = atm.withdrawing(card: card1, amount: 80.0, currency: .BGN) {
    card1 = result
}

atm.printATMBalance()
card2.printCardBalance()

// Example 3
print("Example 3")
atm.availabilityАТМ[Currency.BGN] = 100.0
card1.bankAccount.availability = [Currency.USD: 0.0, Currency.EUR: 0.0, Currency.BGN: 80.0]

if let result = atm.withdrawing(card: card1, amount: 90.0, currency: .BGN) {
    card1 = result
}

atm.printATMBalance()
card2.printCardBalance()

// Example 4
print("Example 4")
atm.availabilityАТМ[Currency.BGN] = 60.0
card2.bankAccount.availability = [Currency.USD: 0.0, Currency.EUR: 0.0, Currency.BGN: 80.0]

if let result = atm.withdrawing(card: card2, amount: 80.0, currency: .BGN) {
    card2 = result
}

atm.printATMBalance()
card2.printCardBalance()

// Example 5
print("Example 5")
atm.availabilityАТМ[Currency.BGN] = 100.0
card1.bankAccount.availability = [Currency.USD: 0.0, Currency.EUR: 60.0, Currency.BGN: 80.0]

if let result = atm.withdrawing(card: card1, amount: 100.0, currency: .BGN) {
    card1 = result
}

atm.printATMBalance()
card2.printCardBalance()

// Example 6
print("Example 6")
atm.availabilityАТМ[Currency.BGN] = 400.0
card1.bankAccount.availability = [Currency.USD: 0.0, Currency.EUR: 60.0, Currency.BGN: 80.0]

if let result = atm.withdrawing(card: card1, amount: 150.0, currency: .BGN) {
    card1 = result
}

atm.printATMBalance()
card1.printCardBalance()

// Example 7 - EUR
print("Example 7")
atm.availabilityАТМ = [Currency.USD: 20.0, Currency.EUR: 70.0, Currency.BGN: 0.0]
card1.bankAccount.availability = [Currency.USD: 0.0, Currency.EUR: 20.0, Currency.BGN: 120.0]

if let result = atm.withdrawing(card: card1, amount: 50.0, currency: .EUR) {
    card1 = result
}

atm.printATMBalance()
card1.printCardBalance()

// Example 8 - EUR
print("Example 8")
atm.availabilityАТМ = [Currency.USD: 20.0, Currency.EUR: 70.0, Currency.BGN: 0.0]
card1.bankAccount.availability = [Currency.USD: 0.0, Currency.EUR: 60.0, Currency.BGN: 120.0]

if let result = atm.withdrawing(card: card2, amount: 50.0, currency: .EUR) {
    card2 = result
}

atm.printATMBalance()
card2.printCardBalance()

// Example 9 - USD
print("Example 9")
atm.availabilityАТМ = [Currency.EUR: 20.0, Currency.USD: 70.0, Currency.BGN: 0.0]
card1.bankAccount.availability = [Currency.EUR: 0.0, Currency.USD: 20.0, Currency.BGN: 120.0]

if let result = atm.withdrawing(card: card1, amount: 50.0, currency: .USD) {
    card1 = result
}

atm.printATMBalance()
card1.printCardBalance()

// Example 10 - USD
print("Example 10")
atm.availabilityАТМ = [Currency.EUR: 20.0, Currency.USD: 70.0, Currency.BGN: 0.0]
card1.bankAccount.availability = [Currency.EUR: 0.0, Currency.USD: 60.0, Currency.BGN: 120.0]

if let result = atm.withdrawing(card: card2, amount: 50.0, currency: .USD) {
    card2 = result
}

atm.printATMBalance()
card2.printCardBalance()

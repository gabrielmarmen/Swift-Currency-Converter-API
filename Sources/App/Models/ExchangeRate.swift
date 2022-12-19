import Fluent
import Vapor

final class ExchangeRate: Model, Content {
    static let schema = "exchange_rates"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "date_time")
    var timestamp: Int
    
    @Field(key: "conversion_rates")
    var rates: [String: Double]

   
    
    static var exempleExchangeRate: ExchangeRate {
        let  tempExchangeRate = ExchangeRate(exchangeRateTable: ["USD":1,
                                                                 "AED":3.6725,
                                                                 "AFN":85.9889,
                                                                 "ALL":120.0586,
                                                                 "AMD":403.1078,
                                                                 "ANG":1.7900],
                                             dateTime: 1665619202)
        return tempExchangeRate
    }
    
    var convertedDateTime: Date {
        Date(timeIntervalSince1970: Double(timestamp))
    }
    
    init() { }

    init(id: UUID? = nil, exchangeRateTable: [String: Double]) {
        self.id = id
        self.timestamp = Int(Date().timeIntervalSince1970)
        self.rates = exchangeRateTable
    }
    
    init(id: UUID? = nil, exchangeRateTable: [String: Double], dateTime: Int) {
        self.id = id
        self.timestamp = dateTime
        self.rates = exchangeRateTable
    }
    
    
}




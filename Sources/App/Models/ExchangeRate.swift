import Fluent
import Vapor

final class ExchangeRate: Model, Content {
    static let schema = "exchange_rates"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "date_time")
    var dateTime: Int
    
    @Field(key: "conversion_rates")
    var exchangeRateTable: [String: Double]

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
        Date(timeIntervalSince1970: Double(dateTime))
    }
    
    init() { }

    init(id: UUID? = nil, exchangeRateTable: [String: Double]) {
        self.id = id
        self.dateTime = Int(Date.now.timeIntervalSince1970)
        self.exchangeRateTable = exchangeRateTable
    }
    
    init(id: UUID? = nil, exchangeRateTable: [String: Double], dateTime: Int) {
        self.id = id
        self.dateTime = dateTime
        self.exchangeRateTable = exchangeRateTable
    }
    
    
}

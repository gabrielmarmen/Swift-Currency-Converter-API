import Fluent
import Vapor

final class ExchangeRate: Model, Content {
    static let schema = "exchange-rates"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "date-time")
    var dateTime: Date
    
    @Field(key: "conversion-rates")
    var exchangeRateTable: [String: Double]

    init() { }

    init(id: UUID? = nil, exchangeRateTable: [String: Double]) {
        self.id = id
        self.dateTime = Date.now
        self.exchangeRateTable = exchangeRateTable
    }
}

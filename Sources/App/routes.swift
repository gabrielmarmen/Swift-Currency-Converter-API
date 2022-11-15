import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("exchange-rates","latest") { req in
        if let allExchangeRates = try? await ExchangeRate.query(on: req.db).all() {
            let json = try JSONEncoder().encode(allExchangeRates)
            return String(data: json, encoding: .utf8)!
        }
        return "Not found"
    }

}

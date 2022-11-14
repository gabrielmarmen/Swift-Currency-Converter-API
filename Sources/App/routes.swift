import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("exchange-rates","latest") { req async  in
        
        try! await ExchangeRate.query(on: req.db).first() ?? ExchangeRate.exempleExchangeRate
    }

}

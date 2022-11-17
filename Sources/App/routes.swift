import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("exchange-rates","latest") { req in
        
        let allExchangeRates = try await ExchangeRate.query(on: req.db)
            .filter(\.$dateTime > Int(Date.now.timeIntervalSince1970) - 400)
            .all()
        
        if allExchangeRates.isEmpty {
            throw Abort(.notFound)
        }else {
           return allExchangeRates
        }
    }
    
    app.get("test") { req in
        "'Test' route is working"
    }
    
    app.get("redis") { req in
        return req.redis.ping()
    }
    

}

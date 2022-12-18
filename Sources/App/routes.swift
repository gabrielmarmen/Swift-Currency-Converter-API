import Fluent
import Vapor

func routes(_ app: Application) throws {

    app.get("exchange-rates","latest") { req in
        let allExchangeRates = try await ExchangeRate.query(on: req.db)
            .filter(\.$timestamp > Int(Date.now.timeIntervalSince1970 - 900))
            .all()
           return allExchangeRates
    }
    
    
    app.get("test") { req in
        "'Test' route is working"
    }
    
    app.get("redis") { req in
        return req.redis.ping()
    }
    

}

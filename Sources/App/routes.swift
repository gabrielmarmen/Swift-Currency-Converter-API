import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("echange-rates","latest") { req async -> String in
        "Latest rates not available yet."
        //Add logic to get latest exchangerate from database
    }
    
    app.get("echange-rates","one-hour") { req async -> String in
        "The exchange rates are not available yet."
        //Add logic to get latest exchangerate from database
    }

    try app.register(collection: TodoController())
}

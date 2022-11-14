import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    
    app.databases.use(.postgres(
        hostname: "localhost",
        port: PostgresConfiguration.ianaPortNumber,
        username: "postgres",
        password: "",
        database: "currencyconverter"
    ), as: .psql)

    app.migrations.add(CreateExchangeRate())

    // register routes
    try routes(app)
}

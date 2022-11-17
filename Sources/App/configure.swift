import Fluent
import FluentPostgresDriver
import Vapor
import Queues
import QueuesRedisDriver


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
    app.redis.configuration = try RedisConfiguration(hostname: "localhost")
    try app.queues.use(.redis(url: "redis://127.0.0.1:6379"))
    
    try app.queues.startScheduledJobs()
}

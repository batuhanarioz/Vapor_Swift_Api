import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database",
        tls: .prefer(try .init(configuration: .clientDefault)))
    ), as: .psql)

    // MARK: Migration Setup
    
    app.migrations.add(UserModelMigration())
    app.migrations.add(TokenModelMigration())
    app.migrations.add(CourseModelMigration())
    app.migrations.add(SessionModelMigration())
    app.migrations.add(GuideModelMigration())
    app.migrations.add(ArticleModelMigration())
    
    // MARK: Seed Setup
    
    app.migrations.add(CreateUserSeed())
    
    // register routes
    try routes(app)
}

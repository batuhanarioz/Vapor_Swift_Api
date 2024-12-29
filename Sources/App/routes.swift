import Fluent
import Vapor

func routes(_ app: Application) throws {

    // Basic Auth MiddleWare
    
    let basicAuthMiddleWare = UserModel.authenticator()
    let guardMiddleWare = UserModel.guardMiddleware()
    _ = app.routes.grouped(basicAuthMiddleWare, guardMiddleWare)
    let basicAuthGroup = app.routes.grouped(basicAuthMiddleWare)
    
    // Token Auth
    
    let tokenAuthMiddleWare = TokenModel.authenticator()
    let tokenAuthGroup = app.routes.grouped(tokenAuthMiddleWare, guardMiddleWare)
    
    // Admin Auth
    
    let adminMiddleWare = CheckAdminMiddleWare()
    let adminTokenAuthGroup = app.routes.grouped(tokenAuthMiddleWare, adminMiddleWare)
    
    // Student Auth
    
    let studentMiddleWre = CheckStudentMiddleWare()
    let studentTokenAuthGroup = app.routes.grouped(tokenAuthMiddleWare, studentMiddleWre)
    
    // MARK: Controllers
    
    let authController = AuthController()
    let userController = UserController()
    let courseController = CourseController()
    let guideController = GuideController()
    let articleController = ArticleController()
    let sessionController = SessionController()
    
    // MARK: Registered Auth Routes
    
    basicAuthGroup.post("login", use: authController.loginHandler)
    

    // MARK: Registered User Routes

    basicAuthGroup.post("users", "\(RoutesEnum.register.rawValue)", use: userController.create)
    tokenAuthGroup.get("users", "\(RoutesEnum.profile.rawValue)", use: userController.get)
    tokenAuthGroup.patch("users", "\(RoutesEnum.profile.rawValue)", "\(RoutesEnum.update.rawValue)", use: userController.update)
    tokenAuthGroup.delete("users", "\(RoutesEnum.profile.rawValue)", "\(RoutesEnum.delete.rawValue)", use: userController.delete)
    
    
    // MARK: Registered User Content Routes
    
    app.routes.get("users", "\(RoutesEnum.courses.rawValue)", use: courseController.getAllObject)
    app.routes.get("users", "\(RoutesEnum.courses.rawValue)", "\(RouteParameter.slug.rawValue)", use: courseController.getObject)
    studentTokenAuthGroup.get("users", "\(RoutesEnum.courses.rawValue)", "\(RouteParameter.slug.rawValue)", "session", "\(RouteParameter.article.rawValue)", use: sessionController.getSelectedObject)
    app.routes.get("users", "\(RoutesEnum.guides.rawValue)", use: guideController.getAllObject)
    app.routes.get("users", "\(RoutesEnum.guides.rawValue)", "\(RouteParameter.slug.rawValue)", use: guideController.getObject)
    studentTokenAuthGroup.get("users", "\(RoutesEnum.guides.rawValue)", "\(RouteParameter.slug.rawValue)", "article", "\(RouteParameter.article.rawValue)", use: articleController.getSelectedObject)

    
    
    // MARK: Registered Admin Routes

    adminTokenAuthGroup.post("\(RoutesEnum.courses.rawValue)", use: courseController.create)
    adminTokenAuthGroup.get("\(RoutesEnum.courses.rawValue)", "\(RouteParameter.slug.rawValue)", use: courseController.get)
    adminTokenAuthGroup.get("\(RoutesEnum.courses.rawValue)", use: courseController.getAll)
    adminTokenAuthGroup.patch("\(RoutesEnum.courses.rawValue)", "\(RouteParameter.slug.rawValue)", use: courseController.update)
    adminTokenAuthGroup.delete("\(RoutesEnum.courses.rawValue)", "\(RouteParameter.slug.rawValue)", use: courseController.delete)
    adminTokenAuthGroup.get("\(RoutesEnum.courses.rawValue)", "\(RouteParameter.status.rawValue)", use: courseController.getByStatus)
    adminTokenAuthGroup.get("\(RoutesEnum.courses.rawValue)", "\(RoutesEnum.search.rawValue)", "\(RouteParameter.term)", use: courseController.search)
    
    
    adminTokenAuthGroup.post("\(RoutesEnum.guides.rawValue)", use: guideController.create)
    adminTokenAuthGroup.get("\(RoutesEnum.guides.rawValue)", "\(RouteParameter.slug.rawValue)", use: guideController.get)
    adminTokenAuthGroup.get("\(RoutesEnum.guides.rawValue)", use: guideController.getAll)
    adminTokenAuthGroup.patch("\(RoutesEnum.guides.rawValue)", "\(RouteParameter.slug.rawValue)", use: guideController.update)
    adminTokenAuthGroup.delete("\(RoutesEnum.guides.rawValue)", "\(RouteParameter.slug.rawValue)", use: guideController.delete)
    adminTokenAuthGroup.get("\(RoutesEnum.guides.rawValue)", "\(RouteParameter.status.rawValue)", use: guideController.getByStatus)
    adminTokenAuthGroup.get("\(RoutesEnum.guides.rawValue)", "\(RoutesEnum.search.rawValue)", "\(RouteParameter.term)", use: guideController.search)
    
    
    adminTokenAuthGroup.post("\(RoutesEnum.articles.rawValue)", use: articleController.create)
    adminTokenAuthGroup.get("\(RoutesEnum.articles.rawValue)", "\(RouteParameter.slug.rawValue)", use: articleController.get)
    adminTokenAuthGroup.get("\(RoutesEnum.articles.rawValue)", use: articleController.getAll)
    adminTokenAuthGroup.patch("\(RoutesEnum.articles.rawValue)", "\(RouteParameter.slug.rawValue)", use: articleController.update)
    adminTokenAuthGroup.delete("\(RoutesEnum.articles.rawValue)", "\(RouteParameter.slug.rawValue)", use: articleController.delete)
    adminTokenAuthGroup.get("\(RoutesEnum.articles.rawValue)", "\(RouteParameter.status.rawValue)", use: articleController.getByStatus)
    adminTokenAuthGroup.get("\(RoutesEnum.articles.rawValue)", "\(RoutesEnum.search.rawValue)", "\(RouteParameter.term)", use: articleController.search)
    
    
    adminTokenAuthGroup.post("\(RoutesEnum.sessions.rawValue)", use: sessionController.create)
    adminTokenAuthGroup.get("\(RoutesEnum.sessions.rawValue)", "\(RouteParameter.slug.rawValue)", use: sessionController.get)
    adminTokenAuthGroup.get("\(RoutesEnum.sessions.rawValue)", use: sessionController.getAll)
    adminTokenAuthGroup.patch("\(RoutesEnum.sessions.rawValue)", "\(RouteParameter.slug.rawValue)", use: sessionController.update)
    adminTokenAuthGroup.delete("\(RoutesEnum.sessions.rawValue)", "\(RouteParameter.slug.rawValue)", use: sessionController.delete)
    adminTokenAuthGroup.get("\(RoutesEnum.sessions.rawValue)", "\(RouteParameter.status.rawValue)", use: sessionController.getByStatus)
    adminTokenAuthGroup.get("\(RoutesEnum.sessions.rawValue)", "\(RoutesEnum.search.rawValue)", "\(RouteParameter.term)", use: sessionController.search)
    
    
}

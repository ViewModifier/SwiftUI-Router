import Combine
import SwiftUI

public extension AppRouter {
    struct SheetRoute: Identifiable {
        public var id: Route {
            self.route
        }
        
        let route: Route
        let presentation: Set<PresentationDetent>
        
        public init(
            route: Route,
            presentation: Set<PresentationDetent>
        ) {
            self.route = route
            self.presentation = presentation
        }
    }
}

public extension AppRouter {
    class StackController: ObservableObject {
        @Published
        var path: NavigationPath
        
        var currentRoute: Route? {
            Self.lastRoute(from: self.path)
        }
        
        @Published
        var sheetRoute: SheetRoute?
        
        @Published
        var fullScreenCoverRoute: Route?
        
        public init(path: NavigationPath = NavigationPath()) {
            self.path = path
        }
        
        public func goBack(_ count: Int = 1) {
            guard canGoBack() else { return }

            self.path.removeLast(count)
        }
        
        public func reset() {
            self.path = .init()
        }
        
        public func canGoBack() -> Bool {
            self.path.isEmpty == false
        }
        
        public func push(route: Route) {
            self.path.append(route)
            print("new count: \(self.path.count)")
        }
        
        public func present(route: Route, with presentation: Set<PresentationDetent>) {
            self.sheetRoute = .init(
                route: route,
                presentation: presentation
            )
        }
        
        public func presentFullScreenCover(route: Route) {
            self.fullScreenCoverRoute = route
        }
    }
}


extension AppRouter.StackController {
    // FIXME: Theres a way to clean this up a bit
    static func lastRoute(from path: NavigationPath) -> Route? {
        guard
            let pathData = try? JSONEncoder().encode(path.codable),
            let pathArr = try? JSONDecoder().decode([String].self, from: pathData),
            pathArr.count >= 2,
            let data = pathArr[1].data(using: .utf8),
            let route = try? JSONDecoder().decode(Route.self, from: data)
        else {
            return nil
        }
        
        return route
    }
}


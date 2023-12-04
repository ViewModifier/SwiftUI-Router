import SwiftUI

public extension AppRouter {
    struct Link<Content: View>: View {
        @EnvironmentObject var stack: StackController
        
        var route: Route
        var presentation: RoutePresentation
        
        let content: Content
        
        public init(
            to route: Route,
            presentation: RoutePresentation = .page,
            @ViewBuilder content: () -> Content
        ) {
            self.route = route
            self.presentation = presentation
            self.content = content()
        }
        
        public var body: some View {
            Button {
                switch self.presentation {
                case .page:
                    stack.push(route: self.route)
                    break
                case .sheet(let detents):
                    stack.present(route: self.route, with: detents)
                    break
                case .fullscreenCover:
                    stack.presentFullScreenCover(route: self.route)
                    break
                }
            } label: {
                content
            }
            .buttonStyle(.plain)
        }
    }
}

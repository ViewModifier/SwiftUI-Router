import SwiftUI

public extension AppRouter {
    struct Stack<Root> : View where Root : View {
        @StateObject var stackController = AppRouter.StackController()
        
        @ViewBuilder
        public var root: Root
        
        public init(
            @ViewBuilder root: () -> Root
        ) {
            self.root = root()
        }
        
        public var body: some View {
            AppRouter.ObservedStack(
                stack: self.stackController
            ) {
                self.root
            }
        }
    }
}

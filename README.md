# AppRouter Swift Package - README

## Overview

`AppRouter` is a Swift package designed to streamline navigation in SwiftUI applications.

## Key Features

- **Custom Route Definitions:** Define app-specific routes using `AppRoute` protocol.
- **Versatile Presentation Modes:** Support for page navigation, fullscreen covers, and sheet presentations.

## Usage

### Define Routes

Implement the `AppRoute` protocol to create custom routes for your app.

```swift
public enum Route: AppRoute {
    case home
    case profile(_ userId: String)
    case settings

    @ViewBuilder
    var content: some View {
        switch self {
        case .home:
            HomeView()
        case .profile(let userId):
            ProfileView(userId: userId)
        case .settings:
            SettingsView()
        }
    }
}
```

### Setting up the Router

Define a router type with your custom routes.

```swift
public typealias Router = AppRouter<AppRoute>
```

### Router Integration in SwiftUI Views

Use the `Router.Stack` in your SwiftUI views to implement navigation.
Suggested to add at the root view of your app.
Add Stacks to create nested navigation flows.

```swift
Router.Stack {
    HomeView() // Your root view
}
```

### Example Navigation Implementation

Implement navigation actions using `Link` or `StackController`.

#### Using `Link`

```swift
struct HomeView: View {
    var body: some View {
        VStack {
            Router.Link(to: .profile("user-id")) {
                Text("Go to Profile")
            }

            Router.Link(to: .settings, presentation: .sheet([.medium])) {
                Text("Open Settings")
            }
        }
    }
}
```

#### Using `StackController`

```swift
struct HomeView: View {
    @EnvironmentObject
    var stackController: Router.StackController

    var body: some View {
        VStack {
            Button("Go to Profile") {
                stackController.push(route: .profile)
            }

            Button("Open Settings") {
                stackController.present(route: .settings, with: [.medium])
            }
        }
    }
}
```

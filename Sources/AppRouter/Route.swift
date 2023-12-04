import SwiftUI

public protocol AppRoute: Identifiable, Hashable, Codable {
    associatedtype RouteView: View
    
    var content: RouteView { get }
}

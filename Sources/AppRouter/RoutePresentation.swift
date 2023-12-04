import SwiftUI

public enum RoutePresentation: Identifiable, Hashable {
    case page
    case fullscreenCover
    case sheet(detents: Set<PresentationDetent> = [PresentationDetent.large])
    
    public var id: Self {
        return self
    }
}

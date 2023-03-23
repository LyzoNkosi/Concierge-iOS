import Foundation

final class LaunchScreenStateManager: ObservableObject {
    
    @MainActor @Published private(set) var state: LaunchScreenStep = .firstStep
    
    @MainActor func dismiss() {
        self.state = .finished
    }
}

enum LaunchScreenStep {
    case firstStep
    case finished
}

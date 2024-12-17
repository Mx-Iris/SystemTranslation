import Foundation
import SwiftUI
import Translation

@available(macOS 15.0, iOS 18.0, *)
struct TranslationHeadlessSwiftUIView: View {
    @ObservedObject
    var coordinator: TranslationCoordinator

    var body: some View {
        EmptyView()
            .translationTask(coordinator.configuration) { session in
                let session = TranslationSessionBox(session: session)
                coordinator.session = session
                coordinator.sessionDidChange(session)
            }
    }
}

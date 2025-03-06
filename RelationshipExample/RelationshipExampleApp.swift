import SwiftUI

@main
struct RelationshipExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    TripListStore(
                        initialState: .init(),
                        reducer: tripListReducer,
                        middlewares: [tripsMiddleware()]
                    )
                )
        }
    }
}

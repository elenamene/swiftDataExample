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
                .task {
                    #if DEBUG
                    let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
                    print(url.path(percentEncoded: false))
                    #endif
                }
        }
    }
}

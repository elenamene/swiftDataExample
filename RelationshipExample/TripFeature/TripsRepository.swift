import SwiftData
import TripModels
import TravellerModels
import Foundation

final class TripsRepository {
    private let context: ModelContext
    
    @MainActor
    static let shared = TripsRepository()

    @MainActor
    private init() {
        self.context = tripsContainer.mainContext
    }
    
    func retrievePersistedTrips() -> [Trip] {
        do {
            return try context.fetch(FetchDescriptor<Trip>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchTripsFromRemote() -> [Trip] {
        simulateRemoteFetch()
        return retrievePersistedTrips()
    }

    func delete(_ trip: Trip) {
        context.delete(trip)
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func deleteAllTrips() {
        let trips = retrievePersistedTrips()
        trips.forEach { trip in
            delete(trip)
        }
    }
}

private extension TripsRepository {
    func simulateRemoteFetch() {
        guard retrievePersistedTrips().isEmpty else { return }
        
        let john = Traveller(id: UUID(), name: "John")
        let mary = Traveller(id: UUID(), name: "Mary")
        let steve = Traveller(id: UUID(), name: "Steve")
        let sarah = Traveller(id: UUID(), name: "Sarah")
        let mark = Traveller(id: UUID(), name: "Mark")
        
        let trips: [Trip] = [
            .init(id: UUID(), travellers: [john, mary]),
            .init(id: UUID(), travellers: [steve]),
            .init(id: UUID(), travellers: [mark, sarah])
        ]
        
        trips.forEach { trip in
            save(trip)
        }
    }
    
    func save(_ trip: Trip) {
        context.insert(trip)
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

private let tripsContainer: ModelContainer = try! {
    let storeURL = FileManager.default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("TripStore")
    
    let schema = Schema([Trip.self])
    
    let modelConfiguration = ModelConfiguration(
        schema: schema,
        url: storeURL,
        allowsSave: true
    )
    
    return try ModelContainer(
        for: schema,
        configurations: [modelConfiguration]
    )
}()

//
import SwiftUI
import TripModels

extension ContentView {
    struct ViewState {
        let trips: [Trip]
        
        init(state: TripListState) {
            self.trips = state.trips
        }
    }
}

struct ContentView: View {
    @Environment(TripListStore.self) private var store
    
    var state: ViewState {
        ViewState(state: store.state)
    }
    
    var body: some View {
        VStack {
            actionButtons

            List {
                ForEach(state.trips) { trip in
                    VStack(alignment: .leading) {
                        Text("TripID: \(trip.id.uuidString)")
                        Spacer()
                        Text("Travellers: \(trip.travellers.map(\.name).joined(separator: ", "))")
                    }
                    .padding(.vertical)
                }
                .onDelete { indexSet in
                    let trip = state.trips[indexSet.first!]
                    store.dispatch(.deleteTrip(trip))
                }
            }
            .listStyle(.plain)
        }
        .onAppear {
            store.dispatch(.loadTrips)
        }
    }
}

private extension ContentView {
    var actionButtons: some View {
        HStack {
            if state.trips.isEmpty {
                Button {
                    store.dispatch(.loadTrips)
                } label: {
                    Text("Load trips")
                }
            }
            
            Spacer()
            
            Button(role: .destructive) {
                store.dispatch(.deleteAllTrips)
            } label: {
                Text("Delete all trips")
            }
        }
        .padding()
    }
}

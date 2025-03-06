func tripListReducer(_ state: inout TripListState, action: TripListAction) {
    switch action {
    case .loadTrips, .deleteTrip, .deleteAllTrips:
        break
    case .didFetchTrips(let trips):
        state.trips = trips
    }
}

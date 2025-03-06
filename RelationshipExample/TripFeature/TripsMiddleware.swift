func tripsMiddleware(repo: TripsRepository = .shared) -> Middleware<TripListState, TripListAction> {
    { state, action in
        switch action {
        case .loadTrips:
            let trips = repo.fetchTripsFromRemote()
            return .didFetchTrips(trips)
        case .deleteTrip(let trip):
            repo.delete(trip)
            return refreshTrips(repo: repo)
        case .deleteAllTrips:
            repo.deleteAllTrips()
            return refreshTrips(repo: repo)
        case .didFetchTrips:
            break
        }
        return nil
    }
}

func refreshTrips(repo: TripsRepository) -> TripListAction {
    let trips = repo.retrievePersistedTrips()
    return .didFetchTrips(trips)
}

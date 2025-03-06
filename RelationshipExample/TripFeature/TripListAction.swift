import TripModels

enum TripListAction: Action {
    case didFetchTrips([Trip])
    case loadTrips
    case deleteTrip(Trip)
    case deleteAllTrips
}

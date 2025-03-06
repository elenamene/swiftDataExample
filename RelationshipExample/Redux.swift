import SwiftUI

typealias TripListStore = Store<TripListState, TripListAction>

public typealias Reducer<State: Sendable, T: Action> = (inout State, T) -> Void
public typealias Middleware<State: Sendable, T: Action> = (State, T) async -> T?

@Observable
public final class Store<State: Sendable, T: Action> {
    public private(set) var state: State

    private let reducer: Reducer<State, T>
    private let middlewares: [Middleware<State, T>]

    public init(
        initialState: State,
        reducer: @escaping Reducer<State, T>,
        middlewares: [Middleware<State, T>] = []
    ) {
        self.state = initialState
        self.reducer = reducer
        self.middlewares = middlewares
    }

    public func dispatch(_ action: T) {
        reducer(&state, action)

        for middleware in middlewares {
            Task {
                if let action = await middleware(state, action) {
                    await MainActor.run {
                        dispatch(action)
                    }
                }
            }
        }
    }
}

public protocol Action: Sendable {}

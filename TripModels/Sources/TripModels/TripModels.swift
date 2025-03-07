import SwiftData
import Foundation
import TravellerModels

@Model
public final class Trip {
    @Attribute(.unique)
    public var id: UUID
    
    public var travellers: [Traveller]
    
    public init(id: UUID, travellers: [Traveller]) {
        self.id = id
        self.travellers = travellers
    }
}

import SwiftData
import Foundation

@Model
public final class Traveller {
    public var id: UUID
    public var name: String
    
    // This inverse relationship is inferred no need to specify
//    var trips: [Trip]?
    
    public init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}

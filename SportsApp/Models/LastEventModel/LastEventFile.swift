
import Foundation
struct LastAllEvents : Codable {
    let events : [Events]?

    enum CodingKeys: String, CodingKey {
        case events = "events"
    }


}

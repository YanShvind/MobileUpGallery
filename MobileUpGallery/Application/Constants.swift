
import Foundation

struct MConstants {
    static let ownerId = "-128666765"
    static let albumId = "266310117"
    static let baseURL = "https://api.vk.com/method/"
    static var albumURL: String {
        return "photos.get?&owner_id=\(ownerId)&album_id=\(albumId)"
    }
    static let token = MKeychainManager.shared.getToken(withIdentifier: "myToken")
}

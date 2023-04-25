
import Foundation
import WebKit

final class MDataManager {
    
    static let shared = MDataManager()
    
    private init() {}
    
    func clearningCookies() {
        HTTPCookieStorage.shared.removeCookies(since: .distantPast)
        let websiteDataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
        let _ = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: websiteDataTypes) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes,
                                                        for: [record], completionHandler: {})
            }
        }
    }
}

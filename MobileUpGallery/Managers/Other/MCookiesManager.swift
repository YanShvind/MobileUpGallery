
import Foundation
import WebKit

final class MCookiesManager {
    
    static let shared = MCookiesManager()
    
    private init() {}
    
    func clearningCookies() {
        HTTPCookieStorage.shared.removeCookies(since: .distantPast)
        let websiteDataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: websiteDataTypes) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes,
                                                        for: [record], completionHandler: {})
            }
        }
    }
}


import Foundation

final class MKeychainManager {
    
    static let shared = MKeychainManager()
    
    private init() {}
    
    func saveToken(token: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "myToken",
            kSecValueData as String: token.data(using: .utf8)!,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        let status = SecItemCopyMatching(query as CFDictionary, nil)
        switch status {
        case errSecSuccess:
            let attributes: [String: Any] = [
                kSecValueData as String: token.data(using: .utf8)!
            ]
            let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
            if status == errSecSuccess {
                print("Token update")
            }
        case errSecItemNotFound:
            let status = SecItemAdd(query as CFDictionary, nil)
            if status == errSecSuccess {
                print("Token add")
            }
        default:
            print("Error: \(status)")
        }
    }
    
    func getToken(withIdentifier identifier: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: identifier,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess, let tokenData = item as? Data else {
            return nil
        }
        
        let token = String(data: tokenData, encoding: .utf8)
        return token
    }
    
    func deleteToken(withIdentifier identifier: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: identifier
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        if status == errSecSuccess {
            print("Token delete")
        } else {
            print("Error: \(status)")
        }
    }
}

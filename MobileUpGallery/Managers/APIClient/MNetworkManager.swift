
import Foundation

final class MNetworkManager {
    
    static let shared = MNetworkManager()
    
    func fetchData(completion: @escaping (Result<[MImageDataModel], Error>) -> Void) {
        
        var components = URLComponents(string: MConstants.baseURL + MConstants.albumURL)!
        components.queryItems = [
            URLQueryItem(name: "owner_id", value: MConstants.ownerId),
            URLQueryItem(name: "album_id", value: MConstants.albumId),
            URLQueryItem(name: "access_token", value: MConstants.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let request = URLRequest(url: components.url!)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .millisecondsSince1970
                let result = try decoder.decode(MImageModel.self, from: data)
                let images = result.response.items.compactMap { item -> MImageDataModel? in
                    guard let url = item.sizes.first(where: { $0.type.rawValue == "z" })?.url else { return nil }
                    return MImageDataModel(urlString: url, date: item.date)
                }
                completion(.success(images))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

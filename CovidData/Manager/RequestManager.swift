import Foundation

class RequestManager {
    
    var session: URLSession {
        get {
            return URLSession.shared
        }
    }
    
    func get(request: URLRequest,  completion: @escaping (Result<Data, Error>) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(error ?? LocalError.unknown))
            }
        }
        task.resume()
    }
    
}

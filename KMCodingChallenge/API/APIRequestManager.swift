//
//  APIRequestManager.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/14/21.
//

import Alamofire


class APIRequestManager: NSObject {
    /// Responsible for all HTTP calls: GET, POST, PUT, & DELETE
    let session: Session
    
    init(session: Session? = nil) {
        self.session = session ?? APIManager.shared.session
        // If a custom session is needed, override else use default shared session from APIManager
    }
    
    func download<T>(url: URLConvertible, fileName: String, responseType: T.Type, parameters: Parameters? = nil, completionHandler: @escaping (APIResponseResult<T>) -> ()) where T: Decodable {
        let destination: DownloadRequest.Destination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent(fileName)
            print("APIRequestManager: documentsURL \(documentsURL.absoluteString)")
            return (documentsURL, [.removePreviousFile])
        }
        let _ = session.download(url,
                                 method: .get,
                                 parameters: parameters,
                                 encoding: URLEncoding.default,
                                 to: destination).responseData { response in
            guard let destinationURL = response.fileURL else { return }
            do {
                guard let data = try String(contentsOf: destinationURL, encoding: .utf8).data(using: .utf8) else { return }
                let model = try JSONDecoder().decode(responseType, from: data)
                completionHandler(APIResponseResult<T>(data: model))
            } catch {
                // Improve error handling
                print("APIRequestManager: Download error \(error)")
            }
        }
    }
}
// MARK: - APIResponse
protocol APIResponseDecodable: Decodable {
    associatedtype DecodableType
    var data: DecodableType? { get set }
    var error: APIResponseError? { get set }
}

struct APIResponse<T: Decodable>: APIResponseDecodable {
    typealias DecodableType = T
    var data: DecodableType?
    var error: APIResponseError?
}

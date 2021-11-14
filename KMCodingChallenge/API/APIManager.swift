//
//  APIManager.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/14/21.
//

import Alamofire

struct APIBase {
    typealias BaseURL = URL
    static let url: BaseURL? = APIManager.shared.baseUrl
}
// MARK: - APIManager
class APIManager: NSObject {
    
    internal var baseUrl: URL?
    internal var session: Session
    private var activeRequest: DataRequest?
    
    static var shared: APIManager {
        if let initializedShared = _shared {
            return initializedShared
        }
        fatalError("Singleton not yet initialized. Run setupURL(baseUrlString) first")
    }
    private static var _shared: APIManager?

    enum SuccessResultType {
        case success(data: Decodable, metadata: APIResponseMetadata)
        case withError(error: APIResponseError, metadata: APIResponseMetadata)
        case undefined
    }
    
    class func setupURL(baseUrlString: String) {
        _shared = APIManager(urlString: baseUrlString) // setup singleton on app launch so entire app can have access to the base url
    }
    
    private init(urlString: String) {
        let config = Session.default.session.configuration
        config.timeoutIntervalForRequest = 60
        self.session = Session(configuration: config)
        if let url = urlString.asURL() {
            self.baseUrl = url
        } else {
            fatalError("base url isn't responding")
        }
    }

    func get<T>(url: URLConvertible, responseType: T.Type, completionHandler: @escaping (APIResponseResult<T>) -> ()) where T : Decodable {

        session.request(
            url,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.queryString,
            headers: nil,
            interceptor: nil,
            requestModifier: nil).responseDecodable(of: APIResponse<T>.self) { response in
                
        }
    }
    
}

// MARK: - parseSuccessResponse
extension APIManager {
    
    private static func parseSuccessResponse(result: (data: Decodable?,
                                                      error: APIResponseError?,
                                                      httpStatusCode: Int,
                                                      serverTimestamp: String?)) -> SuccessResultType {
        
        let metadata =  APIResponseMetadata(httpStatusCode: result.httpStatusCode,
                                            serverTimestamp: result.serverTimestamp)
        
        if let error = result.error {
            print("APIManager: Error parsing \(String(describing: error.title))")
            return .withError(error: error, metadata: metadata)
        }
        
        if let d = result.data {
            return .success(data: d, metadata: metadata)
        }
        
        return .undefined
    }
}

// MARK: - APIResponseMetadata
struct APIResponseMetadata {
    let httpStatusCode: Int
    let serverTimestamp: String?
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

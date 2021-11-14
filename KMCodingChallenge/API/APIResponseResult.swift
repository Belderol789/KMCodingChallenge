//
//  APIResponseResult.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/14/21.
//

import Alamofire

enum APIResponseResult<T: Decodable> {
    case success(_ response: T, metadata: APIResponseMetadata)
    case error(_ error: Error?, metadata: APIResponseMetadata)
    case failed(_ failure: APIResponseMetadata)
}

extension APIResponseResult {
    init(data: T, type: T.Type, metadata: APIResponseMetadata) {
        self = .success(data, metadata: metadata)
    }
    
    init(error: Error, metadata: APIResponseMetadata) {
        self = .error(error, metadata: metadata)
    }
    
    init(failure: APIResponseMetadata) {
        self = .failed(failure)
    }
}

struct APIResponseError: Decodable {
    var tag: String?
    var title: String?
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case tag
        case title
        case message
    }
}

//
//  APIResponseResult.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/14/21.
//

import Alamofire

enum APIResponseResult<T: Decodable> {
    case success(_ response: T)
}

extension APIResponseResult {
    init(data: T) {
        self = .success(data)
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

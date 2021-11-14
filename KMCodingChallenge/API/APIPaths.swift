//
//  APIPaths.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/14/21.
//

import Alamofire

enum APIPaths: URLConvertible {
    case home(baseURL: URL, term: String, country: String, media: String, listAll: Bool)
    
    private var path: (base: URL, path: String) {
        switch self {
        case .home(let baseURL, let term, let country, let media, let listAll):
            let all = listAll ? "all" : ""
            return (baseURL, "/search?term=\(term)&amp;country=\(country)&amp;media=\(media)&amp;\(all)")
        }
    }
    
    func asURL() throws -> URL {
        return path.base.appendingPathComponent(path.path)
    }
}

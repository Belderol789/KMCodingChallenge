//
//  Extensions.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/14/21.
//

import Foundation

// MARK: - String
extension String {
    func asURL() -> URL? {
        return URL(string: self)
    }
    
    func asURLRequest() -> URLRequest? {
        guard let url = URL(string: self) else { return nil }
        return URLRequest(url: url)
    }
}

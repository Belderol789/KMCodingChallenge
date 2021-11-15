//
//  HomeDataManager.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/14/21.
//

import Foundation
// Handles all of the api related tasks for HomeViewController
// 1. Retrieves or updates data objects
// 2. Communicates with the HomeViewController
// 3. Communicates with the API Classes
// 4. Could also handle networking unless a singleton is used

struct APIHomeResponse: Decodable {
    let resultCount: Double
    let results: [MediaModel]
}

class HomeDataManager: NSObject {
    
    let apiManager: APIRequestManager
    
    init(apiManager: APIRequestManager) {
        self.apiManager = apiManager
    }
    
    public func getMediaModels(media: MediaModel.WrapperType, completion: @escaping (APIResponseResult<APIHomeResponse>) -> ()) {
        apiManager.download(url: APIPaths.home(baseURL: APIBase.url,
                                               term: "star",
                                               country: "au",
                                               media: media.rawValue,
                                               listAll: true),
                            fileName: "1.txt",
                            responseType: APIHomeResponse.self,
                            parameters: nil,
                            completionHandler: completion)
    }
    
}

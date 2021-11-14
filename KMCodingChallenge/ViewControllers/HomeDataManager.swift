//
//  HomeDataManager.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/14/21.
//

import Foundation
// Handles all of the api related tasks for HomeViewController
// 1. Retrieves or updates data objects
// 2. Communicates with the ViewModel
// 3. Communicates with the API Classes
// 4. Could also handle networking unless a singleton is used
class HomeDataManager: NSObject {
    let apiManager: APIManager
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    public func getMediaModels(completion: @escaping (APIResponseResult<MediaModel>) -> ()) {
        
    }
    
}

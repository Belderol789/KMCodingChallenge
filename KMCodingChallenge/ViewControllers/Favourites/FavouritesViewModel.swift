//
//  FavouritesViewModel.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/15/21.
//

import Foundation

struct FavouritesViewModel {
    
    public func getAllFavourites() -> [MediaCollectionModel] {
        let allSavedObjects = RealmDatabase.shared.getAllObjects(type: RealmMediaModel.self)
        let mediaModels = allSavedObjects.map({
            return MediaCollectionModel(titleName: $0.titleName,
                                        artwork: $0.artwork,
                                        backupArtwork: $0.backupArtwork,
                                        price: $0.price,
                                        genre: $0.genre)
        })
        return mediaModels
    }
    
    public func getFavouritesCount() -> Int {
        let allSavedObjects = RealmDatabase.shared.getAllObjects(type: RealmMediaModel.self)
        return allSavedObjects.count
    }
    
}

//
//  RealmStorage.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/15/21.
//

import RealmSwift

class RealmDatabase {
    
    let realm = try! Realm()
    
    static let shared = RealmDatabase()
    
    // MARK: - Write to Realm
    public func writeToRealm<T>(_ realmType: T.Type, mediaModel: MediaCollectionModel) {
        var objects: [Object] = []
        if T.self == RealmMediaModel.self {
            let rMediaModel = RealmMediaModel.create(with: mediaModel)
            objects.append(rMediaModel)
        }
        
        for object in objects {
            do {
                try realm.write({
                    realm.add(object)
                })
            } catch {
                
            }
        }
    }
    
    public func deleteFromRealm(mediaModel: MediaCollectionModel) {
        guard let objectToDelete = realm.objects(RealmMediaModel.self).filter({$0.titleName == mediaModel.titleName}).first else { return }
        do {
            try realm.write({
                realm.delete(objectToDelete)
            })
        } catch {
            
        }
        
    }
    
    public func getAllObjects<T>(type: T.Type) -> [T] where T: (Object) {
        let allObjects = realm.objects(T.self)
        return allObjects.map({$0})
    }
}

// MARK: - RealmMediaModel
class RealmMediaModel: Object {
    
    @objc dynamic var titleName: String = ""
    @objc dynamic var artwork: String = ""
    @objc dynamic var backupArtwork: String? = ""
    @objc dynamic var price: String = ""
    @objc dynamic var genre: String = ""
    
    static func create(with mediaModel: MediaCollectionModel) -> RealmMediaModel {
        let realmMediaModel = RealmMediaModel()
        realmMediaModel.titleName = mediaModel.titleName
        realmMediaModel.artwork = mediaModel.artwork
        realmMediaModel.backupArtwork = mediaModel.backupArtwork
        realmMediaModel.price = mediaModel.price
        realmMediaModel.genre = mediaModel.genre
        return realmMediaModel
    }
}

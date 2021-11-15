//
//  HomeViewModel.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/15/21.
//

import Foundation

struct HomeViewModel {
    
    let homeModel: APIHomeResponse
    
    struct MediaCollectionModel {
        let titleName: String
        let artwork: String
        var backupArtwork: String?
        let price: String
        let genre: String
    }

    var dataCount: Int {
        return Int(homeModel.resultCount)
    }
    
    var mediaModels: [MediaModel] {
        return homeModel.results
    }
    
    var mediaTypes: [MediaModel.WrapperType] {
        let availableTypes = mediaModels.map({$0.wrapperType})
        let set = Set(availableTypes)
        return Array(set).sorted().map({MediaModel.WrapperType(rawValue: $0) ?? .all})
    }

    func returnWrapperModels<T>(type: MediaModel.WrapperType, resultType: T.Type) -> [T] {
        let filteredMediaModels = mediaModels.filter({$0.wrapperType == type.rawValue})
        switch type {
        case .track:
            let trackModels = filteredMediaModels.map({Track(mediaModel: $0) as! T})
            return trackModels
        case .audiobook:
            let audioBooks = filteredMediaModels.map({AudioBook(mediaModel: $0) as! T})
            return audioBooks
        default:
            return []
        }
    }
    
    func returnWrapperItemCount(type: MediaModel.WrapperType) -> Int {
        let filteredMediaModels = mediaModels.filter({$0.wrapperType == type.rawValue})
        switch type {
        case .track:
            let trackModels = filteredMediaModels.map({Track(mediaModel: $0)})
            return trackModels.count
        case .audiobook:
            let audioBooks = filteredMediaModels.map({AudioBook(mediaModel: $0)})
            return audioBooks.count
        default:
            return 0
        }
    }
    
    /// Decided to separate the setup functions for different wrapper types in case
    func constructMediaCellModel(track: Track) -> MediaCollectionModel {
        let price = track.trackPrice != nil ? "\(track.trackPrice!)" : "Unavailable"
        return MediaCollectionModel(titleName: track.trackName ?? "Anonymous",
                                    artwork: track.artworkUrl100,
                                    backupArtwork: track.artworkUrl60,
                                    price: price,
                                    genre: track.primaryGenreName)
    }
    
    func constructMediaCellMode(audioBook: AudioBook) -> MediaCollectionModel {
        return MediaCollectionModel(titleName: audioBook.collectionName ?? "Anonymous",
                                    artwork: audioBook.artworkUrl100,
                                    backupArtwork: audioBook.artworkUrl60,
                                    price: "\(audioBook.collectionPrice)",
                                    genre: audioBook.primaryGenreName)
    }
    
}

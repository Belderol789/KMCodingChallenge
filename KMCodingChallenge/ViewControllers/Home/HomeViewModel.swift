//
//  HomeViewModel.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/15/21.
//

import Foundation

struct HomeViewModel {
    
    let homeModel: APIHomeResponse

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

    func returnWrapperModels<T>(type: MediaModel.WrapperType, resultType: T.Type, isSearching: String?) -> [T] {
        let filteredMediaModels = mediaModels.filter({$0.wrapperType == type.rawValue}).sorted(by: {$0.artistName.lowercased() < $1.artistName.lowercased()})
        switch type {
        case .track:
            var trackModels: [T] = filteredMediaModels.map({Track(mediaModel: $0) as! T})
            if let searchText = isSearching?.lowercased() { // check if a searchText is present then filter trackName
                trackModels = trackModels.filter({($0 as! Track).trackName!.lowercased().contains(searchText)})
            }
            return trackModels
        case .audiobook:
            var audioBooks: [T] = filteredMediaModels.map({AudioBook(mediaModel: $0) as! T})
            if let searchText = isSearching?.lowercased() { // check if a collectionName is present then filter trackName
                audioBooks = audioBooks.filter({($0 as! AudioBook).collectionName!.lowercased().contains(searchText)})
            }
            return audioBooks
        default:
            return []
        }
    }
    
    func returnWrapperItemCount(type: MediaModel.WrapperType, isSearching: String?) -> Int {
        let filteredMediaModels = mediaModels.filter({$0.wrapperType == type.rawValue}).sorted(by: {$0.artistName.lowercased() < $1.artistName.lowercased()})
        switch type {
        case .track:
            var trackModels: [Track] = filteredMediaModels.map({Track(mediaModel: $0)})
            if let searchText = isSearching?.lowercased() {
                trackModels = trackModels.filter({$0.trackName!.lowercased().contains(searchText)})
            }
            return trackModels.count
        case .audiobook:
            var audioBooks: [AudioBook] = filteredMediaModels.map({AudioBook(mediaModel: $0)})
            if let searchText = isSearching?.lowercased() {
                audioBooks = audioBooks.filter({$0.collectionName!.lowercased().contains(searchText)})
            }
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

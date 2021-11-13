//
//  AudioBookMediaModel.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/14/21.
//

import Foundation

struct AudioBook {
    
    let collectionId: Double
    let artistName: String
    let collectionName: String
    let collectionCensoredName: String
    let collectionViewUrl: String
    let artworkUrl60: String
    let artworkUrl100: String
    let collectionPrice: Double
    let collectionExplicitness: String
    let trackCount: Int
    let country: String
    let currency: String
    let releaseDate: String
    let primaryGenreName: String
    let previewUrl: String
    
    var copyright: String?
    var description: String?
    var artistViewURL: String?
    
    init(mediaModel: MediaModel) {
        collectionId = mediaModel.collectionId
        artistName = mediaModel.artistName
        collectionName = mediaModel.collectionName
        collectionCensoredName = mediaModel.collectionCensoredName
        collectionViewUrl = mediaModel.collectionViewUrl
        artworkUrl60 = mediaModel.artworkUrl60
        artworkUrl100 = mediaModel.artworkUrl100
        collectionPrice = mediaModel.collectionPrice
        collectionExplicitness = mediaModel.collectionExplicitness
        trackCount = mediaModel.trackCount
        country = mediaModel.country
        currency = mediaModel.currency
        releaseDate = mediaModel.releaseDate
        primaryGenreName = mediaModel.primaryGenreName
        previewUrl = mediaModel.previewUrl
        copyright = mediaModel.copyright
        description = mediaModel.description
        artistViewURL = mediaModel.artistViewURL
    }
    
}

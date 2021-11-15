//
//  TrackMediaModel.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/14/21.
//

import Foundation

struct Track {
    
    let artistName: String
    let artworkUrl60: String
    let artworkUrl100: String
    let collectionPrice: Double
    let collectionExplicitness: String
    let country: String
    let currency: String
    let releaseDate: String
    let primaryGenreName: String
    let previewUrl: String
    
    
    var collectionName: String?
    var collectionCensoredName: String?
    var collectionViewUrl: String?
    var collectionId: Double?
    var trackId: Double?
    var trackCount: Double?
    var trackName: String?
    var trackCensoredName: String?
    var collectionArtistId: Double?
    var collectionArtistViewUrl: String?
    var trackViewUrl: String?
    var artworkUrl30: String?
    var trackPrice: Double?
    var trackRentalPrice: Double?
    var collectionHdPrice: Double?
    var trackHdPrice: Double?
    var trackHdRentalPrice: Double?
    var trackExplicitness: String?
    var discCount: Int?
    var discNumber: Int?
    var trackNumber: Int?
    var trackTimeMillis: Double?
    var contentAdvisoryRating: String?
    var shortDescription: String?
    var longDescription: String?

    init(mediaModel: MediaModel) {
        self.collectionId = mediaModel.collectionId
        self.artistName = mediaModel.artistName
        self.collectionName = mediaModel.collectionName
        self.collectionCensoredName = mediaModel.collectionCensoredName
        self.collectionViewUrl = mediaModel.collectionViewUrl
        self.artworkUrl60 = mediaModel.artworkUrl60
        self.artworkUrl100 = mediaModel.artworkUrl100
        self.collectionPrice = mediaModel.collectionPrice
        self.collectionExplicitness = mediaModel.collectionExplicitness
        self.trackCount = mediaModel.trackCount
        self.country = mediaModel.country
        self.currency = mediaModel.currency
        self.releaseDate = mediaModel.releaseDate
        self.primaryGenreName = mediaModel.primaryGenreName
        self.previewUrl = mediaModel.previewUrl
        self.trackId = mediaModel.trackId
        self.trackName = mediaModel.trackName
        self.trackCensoredName = mediaModel.trackCensoredName
        self.collectionArtistId = mediaModel.collectionArtistId
        self.collectionArtistViewUrl = mediaModel.collectionArtistViewUrl
        self.trackViewUrl = mediaModel.trackViewUrl
        self.artworkUrl30 = mediaModel.artworkUrl30
        self.trackPrice = mediaModel.trackPrice
        self.trackRentalPrice = mediaModel.trackRentalPrice
        self.collectionHdPrice = mediaModel.collectionHdPrice
        self.trackHdPrice = mediaModel.trackHdPrice
        self.trackHdRentalPrice = mediaModel.trackHdRentalPrice
        self.trackExplicitness = mediaModel.trackExplicitness
        self.discCount = mediaModel.discCount
        self.discNumber = mediaModel.discNumber
        self.trackNumber = mediaModel.trackNumber
        self.trackTimeMillis = mediaModel.trackTimeMillis
        self.contentAdvisoryRating = mediaModel.contentAdvisoryRating
        self.shortDescription = mediaModel.shortDescription
        self.longDescription = mediaModel.longDescription
    }
}

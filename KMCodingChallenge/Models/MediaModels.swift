//
//  MediaModels.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/13/21.
//

import Foundation

struct MediaModel: Decodable {
    // Enums - Using enums here because data returns a specific set of names
    enum WrapperType: String, CaseIterable {
        case movie
        case podcast
        case music
        case musicVideo
        case shortFilm
        case tvShow
        case software
        case ebook
        case track
        case audiobook
        case all
    }
    enum TrackKind: String {
        case song
        case featureMovie = "feature-movie"
    }
    // Required
    let wrapperType: String // Using String here instead of directly the enum to prevent crashes on possible data changes outside enum cases. With this we can just put string values that don't conform inside the else block
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
    // Optional
    var collectionViewUrl: String?
    var collectionCensoredName: String?
    var collectionName: String?
    var collectionId: Double?
    var trackCount: Double?
    // AudioBook
    var copyright: String?
    var description: String?
    var artistViewURL: String?
    // Track
    var kind: String?
    var trackId: Double?
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
}

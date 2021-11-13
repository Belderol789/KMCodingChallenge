//
//  MediaModels.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/13/21.
//

import Foundation

struct MediaModel: Decodable {
    // Enums - Using enums here because data returns a specific set of names
    enum WrapperType {
        case track(kind: TrackKind)
        case audiobook
        
        private var trackKindRaw: String {
            switch self {
            case .track(let kind):
                return kind.rawValue
            default:
                return "" // Unrecognized track kind; send empty string to prevent possible crash
            }
        }
    }
    enum TrackKind: String {
        case song
        case featureMovie = "feature-movie"
    }
    // General
    let wrapperType: String // Using String here instead of directly the enum to prevent crashes on possible data changes outside enum cases. With this we can just put string values that don't conform inside the else block
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

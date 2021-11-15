//
//  MediaCollectionViewCell.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/15/21.
//

import UIKit
import SDWebImage

protocol MediaCellProtocol: AnyObject {
    func reloadDatabase()
}

class MediaCollectionViewCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var mediaTitleLabel: UILabel!
    @IBOutlet weak var mediaGenreLabel: UILabel! {
        didSet {
            mediaGenreLabel.adjustsFontSizeToFitWidth = true
        }
    }
    @IBOutlet weak var mediaPriceLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton! {
        didSet {
            favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        }
    }
    
    weak var delegate: MediaCellProtocol?
    var indexPath: IndexPath!
    
    var favouriteState: Bool = false {
        didSet {
            favouriteButton.isSelected = favouriteState
        }
    }
    var mediaModel: MediaCollectionModel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Setup
    public func setupCell(model: MediaCollectionModel) {
        mediaModel = model
        mediaImageView.sd_setImage(with: model.artwork.asURL()) { [weak self] image, error, _, _ in
            if image == nil || error != nil {
                // in case of failure to download image, download the next size
                self?.mediaImageView.sd_setImage(with: model.backupArtwork?.asURL(), completed: nil)
            }
        }
        mediaTitleLabel.text = model.titleName
        mediaGenreLabel.text = model.genre
        mediaPriceLabel.text = "$\(model.price)"
        
        let allFavourites = RealmDatabase.shared.getAllObjects(type: RealmMediaModel.self).map({$0.titleName})
        favouriteState = allFavourites.contains(model.titleName) // This should be a unique identifier, but I couldn't breakdown the JSON enough to find one
        
    }
    
    public func setupCell(favourite: MediaCollectionModel) {
        mediaModel = favourite
        mediaImageView.sd_setImage(with: favourite.artwork.asURL()) { [weak self] image, error, _, _ in
            if image == nil || error != nil {
                // in case of failure to download image, download the next size
                self?.mediaImageView.sd_setImage(with: favourite.backupArtwork?.asURL(), completed: nil)
            }
        }
        mediaTitleLabel.text = favourite.titleName
        mediaGenreLabel.text = favourite.genre
        mediaPriceLabel.text = "$\(favourite.price)"
        favouriteState = true
    }

    // MARK: - @IBAction
    @IBAction func didSelectFavouriteBtn(_ sender: UIButton) {
        sender.isSelected = !favouriteButton.isSelected
        favouriteState = sender.isSelected
        if sender.isSelected {
            RealmDatabase.shared.writeToRealm(RealmMediaModel.self, mediaModel: mediaModel)
        } else {
            RealmDatabase.shared.deleteFromRealm(mediaModel: mediaModel)
        }
        delegate?.reloadDatabase()
    }
}

//
//  MediaCollectionViewCell.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/15/21.
//

import UIKit
import SDWebImage

protocol MediaCellProtocol: AnyObject {
    func didSelectModel(index: IndexPath)
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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setupCell(model: HomeViewModel.MediaCollectionModel) {
        mediaImageView.sd_setImage(with: model.artwork.asURL()) { [weak self] image, error, _, _ in
            if image == nil || error != nil {
                // in case of failure to download image, download the next size
                self?.mediaImageView.sd_setImage(with: model.backupArtwork?.asURL(), completed: nil)
            }
        }
        mediaTitleLabel.text = model.titleName
        mediaGenreLabel.text = model.genre
        mediaPriceLabel.text = "$\(model.price)"
    }

    @IBAction func didSelectFavouriteBtn(_ sender: UIButton) {
        sender.isSelected = !favouriteButton.isSelected
        favouriteState = sender.isSelected
        delegate?.didSelectModel(index: self.indexPath)
    }

}

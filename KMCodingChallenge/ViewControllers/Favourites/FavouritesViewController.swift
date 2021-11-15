//
//  FavouritesViewController.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/15/21.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    @IBOutlet weak var favouritesCollectionView: UICollectionView!
    
    let favouritesVM = FavouritesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favouritesCollectionView.reloadData()
    }
    
    private func setupViews() {
        favouritesCollectionView.register(MediaCollectionViewCell.nib, forCellWithReuseIdentifier: MediaCollectionViewCell.className)
        favouritesCollectionView.delegate = self
        favouritesCollectionView.dataSource = self
        favouritesCollectionView.showsHorizontalScrollIndicator = false
    }

}

// MARK: - FavouritesViewController
extension FavouritesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouritesVM.getFavouritesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCollectionViewCell.className, for: indexPath) as? MediaCollectionViewCell else { fatalError("ViewModel is nil or cell isn't registered") }
        cell.setupCell(favourite: favouritesVM.getAllFavourites()[indexPath.item])
        cell.delegate = self
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavouritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 56) / 3
        return CGSize(width: width, height: (width * 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
    }
}

// MARK: - MediaCellProtocol
extension FavouritesViewController: MediaCellProtocol {
    func reloadDatabase() {
        favouritesCollectionView.reloadData()
    }
}

//
//  ViewController.swift
//  KMCodingChallenge
//
//  Created by Kem Bel on 11/13/21.
//

import UIKit

class HomeViewController: UIViewController {
    // Variables
    let dataManager: HomeDataManager = HomeDataManager(apiManager: APIRequestManager())
    var homeViewModel: HomeViewModel?
    // Views
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupViews()
    }
    
    // MARK: - SetupData
    private func setupData() {
        dataManager.getMediaModels(media: .movie) { [weak self] mediaModel in
            switch mediaModel {
            case .success(let model):
                self?.homeViewModel = HomeViewModel(homeModel: model)
                self?.mediaCollectionView.reloadData()
            case .error(let error):
                // alert error title
                self?.showAlertWith(title: error.title,
                                    message: error.message,
                                    defaultBtnTitle: "OK",
                                    actions: [])
                break
            }
        }
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        mediaCollectionView.register(MediaCollectionViewCell.nib, forCellWithReuseIdentifier: MediaCollectionViewCell.className)
        mediaCollectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        mediaCollectionView.delegate = self
        mediaCollectionView.dataSource = self
        mediaCollectionView.showsHorizontalScrollIndicator = false
    }
    
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return homeViewModel?.mediaTypes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
            let mediaType = homeViewModel?.mediaTypes[indexPath.section]
            sectionHeader.label.text = mediaType?.rawValue.uppercased()
            return sectionHeader
        } else { //No footer in this case but can add option for that
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let hm = homeViewModel else { return 0 }
        let sectionType = hm.mediaTypes[section]
        return hm.returnWrapperItemCount(type: sectionType)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let hm = homeViewModel, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCollectionViewCell.className, for: indexPath) as? MediaCollectionViewCell else { fatalError("ViewModel is nil or cell isn't registered") }
        switch hm.mediaTypes[indexPath.section] {
        case .track:
            let track = hm.returnWrapperModels(type: .track, resultType: Track.self)[indexPath.item]
            cell.setupCell(model: hm.constructMediaCellModel(track: track))
        case .audiobook:
            let audioBook = hm.returnWrapperModels(type: .audiobook, resultType: AudioBook.self)[indexPath.item]
            cell.setupCell(model: hm.constructMediaCellMode(audioBook: audioBook))
        default:
            break
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
}

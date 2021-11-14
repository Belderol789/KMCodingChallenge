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
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    // MARK: - SetupData
    private func setupData() {
        dataManager.getMediaModels(media: .movie) { mediaModel in
            
        }
    }
}


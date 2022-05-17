//
//  RewardsTileViewController.swift
//  Starbucks
//
//  Created by Владимир on 13.05.2022.
//

import UIKit

class RewardsTileViewController: UIViewController {
    
    let rewardTileView = RewardsTileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rewardTileView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(rewardTileView)
        
        NSLayoutConstraint.activate([
            rewardTileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rewardTileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rewardTileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rewardTileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

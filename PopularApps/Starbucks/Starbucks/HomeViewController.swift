//
//  ViewController.swift
//  Starbucks
//
//  Created by Владимир on 08.05.2022.
//

import UIKit

class HomeViewController: StarBucksViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setTabBarImage(imageName: "house.fill", title: "Home")
    }

    func setupNavBar() {
        navigationController?.navigationBar.topItem?.title = "Good afternoon, Vladimir ☀️"
    }

}


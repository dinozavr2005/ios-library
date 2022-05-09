//
//  ViewController.swift
//  Starbucks
//
//  Created by Владимир on 08.05.2022.
//

import UIKit

class HomeViewController: StarBucksViewController {
    
    let headerView = HomeHeaderView()
    var headerViewTopConstriant: NSLayoutConstraint?
    
    let tableView = UITableView()
    
    let cellId = "cellId"
    let tiles = ["Star balance",
                  "Bonus stars",
                  "Try these",
                  "Welcome back",
                  "Uplifting"
                  ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setTabBarImage(imageName: "house.fill", title: "Home")
        setupTableView()
        style()
        layout()
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.topItem?.title = "Good afternoon, Vladimir ☀️"
    }
}

extension HomeViewController {
    func style() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .systemOrange
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        headerViewTopConstriant = headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        
        NSLayoutConstraint.activate([
            // put constraint in variable
//            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerViewTopConstriant!,
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
// MARK: - TableView
extension HomeViewController: UITableViewDataSource {
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = tiles[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tiles.count
    }
    
}

// MARK: - Animating scrollView
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    // hide header when scroll down
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        let swipingDown = y <= 0
        let shouldSnap = y > 30
        let labelHeight = headerView.greeting.frame.height + 16 // label + spacer (102)
        
        UIView.animate(withDuration: 0.3) {
            self.headerView.greeting.alpha = swipingDown ? 1.0 : 0.0
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
            self.headerViewTopConstriant?.constant = shouldSnap ? -labelHeight : 0
            self.view.layoutIfNeeded()
        })

    }
}



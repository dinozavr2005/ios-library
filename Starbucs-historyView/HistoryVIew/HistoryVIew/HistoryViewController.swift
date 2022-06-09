//
//  HistoryViewController.swift
//  HistoryVIew
//
//  Created by Владимир on 31.05.2022.
//

import UIKit

struct HistorySection {
    let title: String
    let transactions: [Transaction]
}

struct Transaction: Codable {
    let id: Int
    let type: String
    let amount: String
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case amount
        case date = "processed_at"
    }
}

class HistoryViewController: UITableViewController {
    
    let games = ["Pacman",
                 "Space Invaders",
                 "Galaga",
                 "Space patrol",
                 "Donkey kong"]
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    func layout() {
        navigationItem.title = "Games"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}
// MARK: - Data Source

extension HistoryViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = games[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
}


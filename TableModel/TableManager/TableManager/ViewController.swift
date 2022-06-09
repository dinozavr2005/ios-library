//
//  ViewController.swift
//  TableManager
//
//  Created by Владимир on 08.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let games = [
                "Pacman",
                "Space Invaders",
                "Space Patrol",
    ]

    var items = [String]()
    var reustableTable: GenericTableView<String, UITableViewCell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (_) in
            self.items = self.games
            self.reustableTable.reload(data: self.items)
        }
        setupTable()
    }

    func setupTable() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300))
        
        reustableTable = GenericTableView(frame: view.frame, header: header, headerHeight: 40.0, sections: 3, items: items, config: { (item, cell) in
            cell.textLabel?.text = item
            self.reustableTable.tableHeaderView = header
        }, selectHandler: { (item) in
            print(item)
        })
        
        view.addSubview(reustableTable)
    }

}

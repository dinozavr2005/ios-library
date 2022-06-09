//
//  GenericTableView.swift
//  TableManager
//
//  Created by Владимир on 08.06.2022.
//

import UIKit

class GenericTableView<Item, Cell: UITableViewCell>: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var header: UIView
    var headerHeight: CGFloat
    var sections: Int
    var items: [Item]!
    var config: (Item, Cell) -> ()
    var selectHandler: (Item) -> ()
    
    init(frame: CGRect, header: UIView, headerHeight: CGFloat, sections: Int, items: [Item], config: @escaping (Item, Cell) -> (), selectHandler: @escaping (Item) -> ()) {
        self.header = header
        self.headerHeight = headerHeight
        self.sections = sections
        self.items = items
        self.config = config
        self.selectHandler = selectHandler
        super.init(frame: frame, style: .plain)
        
        self.delegate = self
        self.dataSource = self
        self.register(Cell.self, forCellReuseIdentifier: "Cell")
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.header.backgroundColor = .systemBlue
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return headerHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        config(items[indexPath.row], cell)
        cell.backgroundColor = .yellow
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectHandler(items[indexPath.row])
    }

}

extension GenericTableView {
    func reload(data items: [Item]) {
        self.items = items
        self.reloadData()
    }
}


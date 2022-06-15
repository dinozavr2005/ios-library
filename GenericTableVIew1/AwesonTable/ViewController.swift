

import UIKit

class ViewController: UIViewController {

    var items = [String]()
    var reustableTable: GenericTableView<String, UITableViewCell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (_) in
            self.items = ["black", "white"]
            self.reustableTable.reload(data: self.items)
        }
        setupTable()
    }

    func setupTable() {
        reustableTable = GenericTableView(frame: view.frame, items: items, config: { (item, cell) in
            cell.textLabel?.text = item
        }, selectHandler: { (item) in
            print(item)
        })
        
        view.addSubview(reustableTable)
    }

}


//
//  DetailViewController.swift
//  TodoList
//
//  Created by t2023-m0062 on 2023/08/03.
//

import UIKit

class DetailViewController: UIViewController {
    var receiveItem: Todo?
    
    //  let tableView = UITableView()
    
    @IBOutlet weak var detailItem: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let item = receiveItem else { return }
        detailItem.text = item.content
    }
    
    func receiveItem(_ item: Todo) {
        self.receiveItem = item
    }
    
    @IBAction func changeCategory(_ sender: UIButton) {

    }
}


//
//  HomeViewController.swift
//  TodoList
//
//  Created by t2023-m0062 on 2023/08/10.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var MainTodo: UIButton!
    
    @IBOutlet weak var DoneList: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tableVC = TableViewController()
        tableVC.modalPresentationStyle = .fullScreen
    }
    
    @IBAction func viewDoneList(_ sender: UIButton) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

//
//  HomeViewController.swift
//  TodoList
//
//  Created by t2023-m0062 on 2023/08/10.
//

import UIKit

var category: [String] = []

class HomeViewController: UIViewController {

    @IBOutlet weak var MainTodo: UIButton!
    
    @IBOutlet weak var DoneList: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAsyncImage()
        
        let tableVC = TableViewController()
        tableVC.modalPresentationStyle = .fullScreen
        
        if let data = UserDefaults.standard.object(forKey: "category") as? Data,
           let categoryArray = try? JSONDecoder().decode([Category].self, from: data),
           !categoryArray.isEmpty {
            categories = categoryArray
        } else {
            categories = [Category(name: "other")]
            let data = try? JSONEncoder().encode(categories)
            UserDefaults.standard.setValue(data, forKey: "category")
        }
        
    }
    
    func loadAsyncImage() {
        let url = URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg")
        DispatchQueue.global().async {
            [weak self] in
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
            }
        }
    }
    
    @IBAction func viewDoneList(_ sender: UIButton) {
        
    }
    
    
    @IBAction func AddCategory(_ sender: UIButton) {
        let categoryAlert = UIAlertController(title: "카테고리 추가", message: nil, preferredStyle: .alert)
        let categoryOk = UIAlertAction(title: "확인", style: .default, handler: { _ in
            guard let text = categoryAlert.textFields?[0].text else {return}
            categories.append(Category(name: text))
            
            let encoder = JSONEncoder()
            let data = try? encoder.encode(categories)
            UserDefaults.standard.setValue(data, forKey: "category")  //저장
        })
        
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        categoryAlert.addTextField(configurationHandler: {textfield in
            textfield.placeholder = "카테고리명을 입력해주세요."
        })
        
        categoryAlert.addAction(cancel)
        categoryAlert.addAction(categoryOk)
        
        self.present(categoryAlert, animated: true)
    }
    
}

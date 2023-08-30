//
//  TableViewController.swift
//  TodoList
//
//  Created by t2023-m0062 on 2023/08/03.
//

import UIKit

class Todo: Codable {
    var content: String = ""
    var isCompleted: Bool = false
    
    init(content: String) {
        self.content = content
    }
}

var items: [Todo] = []

class TableViewController: UITableViewController {
    
    //let filter = itemsTest.filter { $0.isCompleted == true }
    
    @IBOutlet var tvListView: UITableView!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = defaults.object(forKey: "todo") as? Data {
            
            //데이터 변환
            guard let itemsArray = try? JSONDecoder().decode([Todo].self, from: data) else {
                    return
            }
            
            items = itemsArray
            tableView.reloadData()
        }
        
        //바 버튼으로 목록 삭제하기
        self.navigationItem.rightBarButtonItems?.append(editButtonItem)
    }
    
    //check버튼 누를때 호출되는 함수
    @IBAction func checkBtn(_ sender: UIButton) { //누르는 정보가 sender로 넘어간다
        items[sender.tag].isCompleted = !items[sender.tag].isCompleted //나갔다 들어와도 값이 유지되는건 isCompleted때문
        //isCompleted로 들어온 값을 테이블을 다시 만들어서 보여주기 때문에 값이 유지됨
        tableView.reloadData()
    }
    
    //플러스 버튼
    @IBAction func plusBtn(_ sender: Any) {
        let alert = UIAlertController(title: "할 일 추가", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: { _ in
            guard let text = alert.textFields?[0].text else { return }
            items.append(Todo(content: text))
            
            //데이터 변환
            let encoder = JSONEncoder()
            let data = try? encoder.encode(items)
            self.defaults.setValue(data, forKey: "todo")  //저장
            
            self.tableView.reloadData()
        })
        
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        alert.addTextField(configurationHandler: { textfield in
            textfield.placeholder = "할 일을 입력해주세요."
        })
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1    //테이블 안에 섹션이 1개이므로 리턴값은 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    //앞에서 선언한 변수의 내용을 셀에 적용하는 함수
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TodoCell
        //셀의 텍스트레이블에 앞에서 선언한 items배열을 대입

        cell.textLabel?.text = items[(indexPath as NSIndexPath).row].content
        cell.checkBtn.tag = indexPath.row
        cell.configureCell(isCompleted: items[indexPath.row].isCompleted)
        
        return cell
    }
    
    
    //셀 내용 삭제
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: (indexPath as NSIndexPath).row)
           tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }

    
    //목록 순서 바꾸기 rearranging the table view
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = items[(fromIndexPath as NSIndexPath).row] // 이동할 아이템위치를 itemToMove에 저장
        items.remove(at: (fromIndexPath as NSIndexPath).row)  //이동할 아이템 삭제
        items.insert(itemToMove, at: (to as NSIndexPath).row)
        //삭제된 아이템을 이동할 위치로 삽입. 삽입한 아이템 뒤의 아이템들의 인덱스가 재정렬
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sgDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let detailView = segue.destination as! DetailViewController
            detailView.receiveItem(items[((indexPath! as NSIndexPath).row)])
        }
    }
}



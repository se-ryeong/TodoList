//
//  TableViewController.swift
//  TodoList
//
//  Created by t2023-m0062 on 2023/08/03.
//

import UIKit

class Todo {
    var content: String = ""
    var isCompleted: Bool = false
    
    init(content: String) {
        self.content = content
    }
}

var items: [Todo] = []
//var items = ["테스트1","테스트2"]


class TableViewController: UITableViewController {
    
    //let filter = itemsTest.filter { $0.isCompleted == true }
    
    
    @IBOutlet var tvListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        //바 버튼으로 목록 삭제하기
        self.navigationItem.rightBarButtonItems?.append(editButtonItem)
    }
    
    //check버튼 누를때 호출되는 함수
    @IBAction func checkBtn(_ sender: UIButton) { //누르는 정보가 sender로 넘어간다.
        items[sender.tag].isCompleted = !items[sender.tag].isCompleted //나갔다 들어와도 값이 유지되는게 isCompleted때문
        //isCompleted로 들어온 값을 테이블을 다시 만들어서 보여줬다. 그래서 값이 유지가 된다.
        tableView.reloadData()
    }
    
    //플러스 버튼
    @IBAction func plusBtn(_ sender: Any) {
        let alert = UIAlertController(title: "할 일 추가", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: { _ in
            guard let text = alert.textFields?[0].text else { return }
            items.append(Todo(content: text))

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
        // #warning Incomplete implementation, return the number of sections
        return 1    //테이블 안에 섹션이 1개이므로 리턴값은 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    //앞에서 선언한 변수의 내용을 셀에 적용하는 함수
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TodoCell
        //셀의 텍스트레이블에 앞에서 선언한 items배열을 대입한다.

        cell.textLabel?.text = items[(indexPath as NSIndexPath).row].content
        cell.checkBtn.tag = indexPath.row
        cell.configureCell(isCompleted: items[indexPath.row].isCompleted)
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view. - 셀의 내용을 삭제하는 함수
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    
    //목록 순서 바꾸기 - Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = items[(fromIndexPath as NSIndexPath).row] // 이동할 아이템위치를 itemToMove에 저장
        items.remove(at: (fromIndexPath as NSIndexPath).row)  //이동할 아이템 삭제
        items.insert(itemToMove, at: (to as NSIndexPath).row)
        //삭제된 아이템을 이동할 위치로 삽입한다. 삽입한 아이템 뒤의 아이템들의 인덱스가 재정렬된다.
        
    }
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let detailView = segue.destination as! DetailViewController
            detailView.receiveItem(items[((indexPath! as NSIndexPath).row)])
        }
    }
}

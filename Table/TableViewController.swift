//
//  TableViewController.swift
//  Table
//
//  Created by 김규리 on 2022/02/04.
//

import UIKit

//var items = [String]()
//var content = [String]()
//var itemsImageFile = [String]()
var items = ["책 구매", "스터디"]
var content = ["교과서 구매", "8시 ~ 9시반"]
var itemsImageFile = ["cart.png", "pencil.png"]


class TableViewController: UITableViewController {

    @IBOutlet var tvListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem // edit 버튼 추가
    }
    
    // 뷰가 전환될 때 호출되는 함수 (Main View로 돌아올 때 호출됨)
    override func viewWillAppear(_ animated: Bool) {
        tvListView.reloadData() // 테이블 뷰를 다시 불러옴 : 추가된 내용을 목록으로 불러들임
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 // 보통 테이블 안에 섹션이 한 개이므로
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count // 섹션당 열 개수는 Items의 개수이므로
    }

    // 앞에서 선언한 변수의 내용을 셀에 적용하는 함수
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // withIdentifier 바꿔주기
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = items[(indexPath as NSIndexPath).row]
        cell.imageView?.image = UIImage(named: itemsImageFile[(indexPath as NSIndexPath).row])

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // 셀의 내용을 삭제하는 함수
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: (indexPath as NSIndexPath).row)
            itemsImageFile.remove(at: (indexPath as NSIndexPath).row)
            content.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // 영어 Delete -> '삭제'
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    
    // 목록 순서 바꾸기 함수
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        // 이동할 아이템 저장
        let itemToMove = items[(fromIndexPath as NSIndexPath).row]
        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row]
        let itemContentToMove = content[(fromIndexPath as NSIndexPath).row]
        
        // 이동할 아이템 삭제
        items.remove(at: (fromIndexPath as NSIndexPath).row)
        itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row)
        content.remove(at: (fromIndexPath as NSIndexPath).row)
        
        // 이동할 위치로 삽입
        items.insert(itemToMove, at: (to as NSIndexPath).row)
        itemsImageFile.insert(itemImageToMove, at: (to as NSIndexPath).row)
        content.insert(itemContentToMove, at: (to as NSIndexPath).row)

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
        
        if segue.identifier == "sgDetail" { // detailView로 이동시
            // TableViewCell의 indexPath를 구하는 부분
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            
            let detailView = segue.destination as! DetailViewController // 세그웨이의 도착 컨트롤러를 DetailViewController으로
            detailView.receiveItem(items[((indexPath! as NSIndexPath).row)])
            detailView.receiveContent(content[((indexPath! as NSIndexPath).row)])
            detailView.receiveImage(itemsImageFile[((indexPath! as NSIndexPath).row)])
            detailView.receiveIndex((indexPath! as NSIndexPath).row)
        }
    }
    

}

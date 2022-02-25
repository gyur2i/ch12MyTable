//
//  DetailViewController.swift
//  Table
//
//  Created by 김규리 on 2022/02/04.
//

import UIKit

class DetailViewController: UIViewController, EditDelegate {
    
    var receiveItem = "" // 메인에서 받을 텍스트를 위한 변수 선언
    var receiveContent = ""
    var receiveImage = ""
    var receiveIndex = 0

    @IBOutlet var lblItem: UILabel!
    @IBOutlet var lblContent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lblItem.text = receiveItem // 뷰가 노출될 때 텍스트를 receiveItem으로 표시
        lblContent.text = receiveContent
    }
    
    // Main View에서 변수를 받기 위한 함수
    func receiveItem(_ item: String){
        receiveItem = item
    }
    
    func receiveContent(_ content: String){
        receiveContent = content
    }
    
    func receiveImage(_ image: String){
        receiveImage = image
    }
    
    func receiveIndex(_ index: Int){
        receiveIndex = index
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "sgEditDetail" { // detailView로 이동시
            // TableViewCell의 indexPath를 구하는 부분
            
            let editDetailViewController = segue.destination as! EditDetailViewController // 세그웨이의 도착 컨트롤러를 EditDetailViewController으로
            editDetailViewController.receiveItem(receiveItem)
            editDetailViewController.receiveContent(receiveContent)
            editDetailViewController.receiveImage(receiveImage)
            editDetailViewController.receiveIndex(receiveIndex)
            
            editDetailViewController.delegate = self
        }
    }
    
    
    func editItem(_ controller: EditDetailViewController, item: String) {
        lblItem.text = item // 뷰가 노출될 때 텍스트를 receiveItem으로 표시
    }
    
    func editContent(_ controller: EditDetailViewController, content: String) {
        lblContent.text = content
    }
    


}

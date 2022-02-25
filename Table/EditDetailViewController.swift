//
//  EditDetailViewController.swift
//  Table
//
//  Created by 김규리 on 2022/02/07.
//

import UIKit

protocol EditDelegate {
    // EditDetailViewController에서 함수 호출
    func editItem(_ controller: EditDetailViewController, item: String)
    func editContent(_ controller: EditDetailViewController, content: String)
}

class EditDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var receiveItem = "" // 디테일뷰에서 받을 텍스트를 위한 변수 선언
    var receiveContent = ""
    var receiveImage = ""
    var receiveIndex = 0
    
    var delegate : EditDelegate?
    
    // 피커 뷰가 동작하는 데 필요한 변수 및 상수
    let MAX_ARRAY_NUM = 3 // 사용할 이미지 개수
    let PICKER_VIEW_COLUMN = 1 // 피커 뷰 열의 개수
    let PICKER_VIEW_HEIGHT:CGFloat = 40 // 피커뷰 높이 지정
    var imageArray = [UIImage?]() // UIImage 타입의 배열 선언
    
    var choiceImage = ""
    var imageFileName = ["cart.png", "clock.png", "pencil.png"] // 이미지 파일명 저장할 배열
    
   
    
    
    @IBOutlet var tfAddItem: UITextField!
    @IBOutlet var tfAddItemContent: UITextField!
    
    // 피커뷰
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var pickerImage: UIPickerView!
    //

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for i in 0 ..< MAX_ARRAY_NUM {
            let image = UIImage(named: imageFileName[i])
            imageArray.append(image!) // imageArray에 이미지 추가
        }
        
        // 처음 화면에
        imgView.image = UIImage(named: receiveImage) // detail view에서 가져온 이미지
        choiceImage = receiveImage
        
        tfAddItem.text = receiveItem
        tfAddItemContent.text = receiveContent
        //
        
        print(receiveImage)
        print(receiveIndex)
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
    
    
    // Done 버튼
    @IBAction func btnEditItem(_ sender: UIButton) {
        items[receiveIndex] = tfAddItem.text!
        content[receiveIndex] = tfAddItemContent.text!
        itemsImageFile[receiveIndex] = choiceImage
        
        if delegate != nil { // 수정화면의 텍스트 필드 내용을 메인화면으로 전달
            delegate?.editItem(self, item: tfAddItem.text!)
            delegate?.editContent(self, content: tfAddItemContent.text!)
            print(tfAddItem.text!)
            print(tfAddItemContent.text!)
        }
        
        tfAddItem.text = "" // 텍스트 필드 내용 지우기
        tfAddItemContent.text = "" // 텍스트 필드 내용 지우기
        
        _ = navigationController?.popViewController(animated: true) // 테이블 뷰로 돌아가는 코드
    }
    
    // 델리게이트 메서드 추가
    // 피커 뷰에 표시되는 열의 개수를 넘겨주는 함수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    
    // 피커 뷰 높이를 정수 값으로 전달
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    
    // imageFileName의 데이터의 개수(행의 개수)를 넘겨주는 함수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    }
    
    // 피커 뷰 행 : imageArray의 이미지를 리턴 (UIView 타입의 값으로 넘겨줌)
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imgView = UIImageView(image: imageArray[row]) // imageView에 UIView 타입으로 저장
        imgView.frame = CGRect(x: 0, y: 0, width: 40, height: 40) // 이미지 뷰 프레임 크기
        
        return imgView // 이미지뷰 리턴
    }
    
    
    // lblImageFileName(Item)에 선택된 imageFileName 출력하는 함수
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        imgView.image = imageArray[row] // 이미지 부착
        choiceImage = imageFileName[row] // 내가 추가
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

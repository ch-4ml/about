//
//  PortfolioViewController.swift
//  chpark
//
//  Created by comsoft on 2017. 12. 4..
//  Copyright © 2017년 comsoft. All rights reserved.
//

import UIKit

var imageViewPortfolioBack: UIImage?

protocol AddDelegate {
    func didPortfolioAddEditDone(_ controller: PortfolioViewController, portfolioImage:UIImage)
}

class PortfolioViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tfPortfolio: UITextField!
    @IBOutlet weak var tfPortfolioDate: UITextField!
    @IBOutlet weak var tvPortfolio: UITextView!
    @IBOutlet weak var imgViewPortfolio: UIImageView!
    @IBOutlet weak var imgViewPortfolioBack: UIImageView!
    
    let imagePicker : UIImagePickerController! = UIImagePickerController()
    var delegate : AddDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        if let img = imageViewPortfolioBack {
            imgViewPortfolioBack.image = img
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnPortfolio(_ sender: UIButton) {
        let alert = UIAlertController(title: "포트폴리오 사진", message: "어디에서 가져올까요?", preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
        }
        
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func openLibrary(){
        if(UIImagePickerController .isSourceTypeAvailable(.photoLibrary)){
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: false, completion: nil)
        }
        else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album.")
        }
    }
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            imagePicker.sourceType = .camera
            present(imagePicker, animated: false, completion: nil)
        }
        else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album.")
        }
    }

    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert
        )
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imgViewPortfolio.image = image
            print(info)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnAdd(_ sender: UIButton) {
        items.append(tfPortfolio.text!)
        tfPortfolio.text=""
        itemsImageFile.append(imgViewPortfolio.image!) // edit
        itemsDate.append(tfPortfolioDate.text!)
        tfPortfolioDate.text=""
        imgViewPortfolio.image=nil
        _ = navigationController?.popViewController(animated: true)
        if delegate != nil {
        delegate?.didPortfolioAddEditDone(self, portfolioImage: imgViewPortfolio.image!)
        }
        _ = navigationController?.popViewController(animated: true)

    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

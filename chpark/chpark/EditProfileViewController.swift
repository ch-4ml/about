//
//  EditProfileViewController.swift
//  chpark
//
//  Created by comsoft on 2017. 12. 1..
//  Copyright © 2017년 comsoft. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol EditDelegate {
    func didProfileEditDone(_ controller: EditProfileViewController, name:String, nameEng:String, email:String, profileMusic:String, landscape:UIImage, portrait: UIImage)
}

class EditProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var delegate : EditDelegate?
    var textName : String = ""
    var textNameEng : String = ""
    var textEmail : String = ""
    var imagePortrait : UIImage!
    var imageLandscape : UIImage!
    var isLandscape : Bool = false
    let imagePicker : UIImagePickerController! = UIImagePickerController()
    @IBOutlet weak var imgViewEditLandscape: UIImageView!
    @IBOutlet weak var imgViewEditPortrait: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtNameEng: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMusic: UITextField!
    @IBAction func btnEditLandscape(_ sender: UIButton) {
        isLandscape = true
        let alert = UIAlertController(title: "프로필 배경사진", message: "어디에서 가져올까요?", preferredStyle: .actionSheet)
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
    @IBAction func btnEditPortrait(_ sender: UIButton) {
        isLandscape = false
        let alert = UIAlertController(title: "프로필 사진", message: "어디에서 가져올까요?", preferredStyle: .actionSheet)
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
    @IBAction func btnEditDone(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didProfileEditDone(self, name: txtName.text!, nameEng: txtNameEng.text!, email: txtEmail.text!, profileMusic: txtMusic.text!, landscape: imgViewEditLandscape.image!, portrait: imgViewEditPortrait.image!)
        }
        _ = navigationController?.popViewController(animated: true)
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            if isLandscape {
                imgViewEditLandscape.image = image
            }
            else {
                imgViewEditPortrait.image = image
            }
            print(info)
        }
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        txtName.text = textName
        txtNameEng.text = textNameEng
        txtEmail.text = textEmail
        imgViewEditLandscape.image = imageLandscape
        imgViewEditPortrait.image = imagePortrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert
        )
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

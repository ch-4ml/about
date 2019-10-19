//
//  EditPortfolioViewController.swift
//  chpark
//
//  Created by comsoft on 2017. 12. 4..
//  Copyright © 2017년 comsoft. All rights reserved.
//

import UIKit

var imageViewEditPortfolioBack: UIImage?

class EditPortfolioViewController: UIViewController {

    @IBOutlet weak var imgViewEditPortfolio: UIImageView!
    @IBOutlet weak var tfEditPortfolio: UITextField!
    @IBOutlet weak var tfEditPortfolioDate: UITextField!
    @IBOutlet weak var tvEditPortfolio: UITextView!
    @IBOutlet weak var imgViewEditPortfolioBack: UIImageView!
    
    var receiveItem = ""
    var receiveItemImageFile: UIImage?
    var receiveItemDate = ""
    
    func receiveItem(_ item: String) {
        receiveItem = item
    }
    
    func receiveItemImageFile(_ itemImageFile: UIImage?) {
        if let itemImgFile = itemImageFile {
            receiveItemImageFile = itemImgFile
        }
        else {
            // 기본 이미지
        }
    }
    
    func receiveItemDate(_ itemDate: String) {
        receiveItemDate = itemDate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tfEditPortfolio.text = receiveItem
        tfEditPortfolioDate.text = receiveItemDate
        imgViewEditPortfolio.image = receiveItemImageFile
        if let img = imageViewEditPortfolioBack {
            imgViewEditPortfolioBack.image = img
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnEditPortfolio(_ sender: UIButton) {
        
    }
    
    @IBAction func btnEdit(_ sender: UIButton) {
        
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

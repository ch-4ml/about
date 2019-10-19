//
//  IntroducePortfolioViewController.swift
//  chpark
//
//  Created by comsoft on 2017. 12. 4..
//  Copyright © 2017년 comsoft. All rights reserved.
//

import UIKit

var imageViewIntroduceBack: UIImage?

class IntroducePortfolioViewController: UIViewController {
    var receiveIntroduce = ""

    @IBOutlet weak var imgViewIntroduceBack: UIImageView!
    @IBOutlet weak var tvIntroduce: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        tvIntroduce.text = receiveIntroduce
        if let img = imageViewIntroduceBack {
            imgViewIntroduceBack.image = img
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        introduce = tvIntroduce.text
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

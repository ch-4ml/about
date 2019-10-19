//
//  ImageViewController.swift
//  chpark
//
//  Created by comsoft on 2017. 12. 8..
//  Copyright © 2017년 comsoft. All rights reserved.
//

import UIKit

var images = ["01.jpg", "02.jpg", "03.jpg", "04.jpg", "05.jpg", "06.jpg"]

class ImageViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBAction func pageChanged(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.green
        pageControl.currentPageIndicatorTintColor = UIColor.red
        imgView.image = UIImage(named: images[0])
        // Do any additional setup after loading the view.
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ImageViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ImageViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)

    }

    func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left:
                if pageControl.currentPage < images.count-1 {
                    pageControl.currentPage = pageControl.currentPage + 1
                }
                else {
                    pageControl.currentPage = 0
                }
                imgView.image = UIImage(named: images[pageControl.currentPage])
            case UISwipeGestureRecognizerDirection.right:
                if pageControl.currentPage > 0 {
                    pageControl.currentPage = pageControl.currentPage - 1
                }
                else {
                    pageControl.currentPage = images.count
                }
                imgView.image = UIImage(named: images[pageControl.currentPage])
            default:
                break
            }
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        imageViewBackGround = imgView.image
        imageViewPortfolioBack = imgView.image
        imageViewIntroduceBack = imgView.image
        imageViewEditPortfolioBack = imgView.image
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        imageViewBackGround = imgView.image
        imageViewPortfolioBack = imgView.image
        imageViewIntroduceBack = imgView.image
        imageViewEditPortfolioBack = imgView.image
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

}

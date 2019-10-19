//
//  PortfolioTableViewController.swift
//  chpark
//
//  Created by comsoft on 2017. 12. 4..
//  Copyright © 2017년 comsoft. All rights reserved.
//

import UIKit

var items = [String]()
var itemsImageFile = [UIImage]()
var itemsDate = [String]()
var rows: Int = 0
var introduce: String = ""
var indexPath: NSIndexPath?

class CustomTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = CGRect(x: 10, y: 0, width: 80, height: 60)
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.textLabel?.frame = CGRect(x: 105, y: 20, width: self.frame.width - 45, height: 20)
        self.detailTextLabel?.frame = CGRect(x: 105, y: 40, width: self.frame.width - 45, height: 15)
    }
}

class PortfolioTableViewController: UITableViewController {
    
    @IBOutlet var tvListView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        tvListView.reloadData()
        
    }
    
    func didIntroduceWriteDone(_ controller: IntroducePortfolioViewController, textViewIntroduce: String) {
        introduce = textViewIntroduce
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let sections: Int = tableView.numberOfSections
        for i in 0..<sections {
            rows += tableView.numberOfRows(inSection: i)
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return items.count
    }

//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRow(at: indexPath as IndexPath)
//        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
//        performSegue(withIdentifier: "sgEdit", sender: cell)
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CustomTableViewCell {
        let cell: CustomTableViewCell = CustomTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myCell")
        cell.imageView!.layer.cornerRadius = 10
        cell.imageView!.clipsToBounds = true
        cell.textLabel?.text = items[(indexPath as NSIndexPath).row]
        cell.imageView?.image = itemsImageFile[(indexPath as NSIndexPath).row]
        cell.detailTextLabel?.text = itemsDate[(indexPath as NSIndexPath).row]
        
        return cell
        
                // Configure the cell...
    }
    
    func didPortfolioAddEditDone(_ controller: PortfolioViewController, portfolioImage: UIImage) {
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: (indexPath as NSIndexPath).row)
            itemsImageFile.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = items[(fromIndexPath as NSIndexPath).row]
        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row]
        let itemDateToMove = itemsDate[(fromIndexPath as NSIndexPath).row]
        items.remove(at: (fromIndexPath as NSIndexPath).row)
        itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row)
        itemsDate.remove(at: (fromIndexPath as NSIndexPath).row)
        items.insert(itemToMove, at: (to as NSIndexPath).row)
        itemsImageFile.insert(itemImageToMove, at: (to as NSIndexPath).row)
        itemsDate.insert(itemDateToMove, at: (to as NSIndexPath).row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgIntroduce" {
            let introducePortfolioViewController = segue.destination as! IntroducePortfolioViewController
            introducePortfolioViewController.receiveIntroduce = introduce
        }
        if segue.identifier == "sgEdit" {
            let cell = sender as! CustomTableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let editView = segue.destination as! EditPortfolioViewController
            editView.receiveItem(items[((indexPath as NSIndexPath?)?.row)!])
            editView.receiveItemImageFile(itemsImageFile[((indexPath as NSIndexPath?)?.row)!])
            editView.receiveItemDate(itemsDate[((indexPath as NSIndexPath?)?.row)!])
        }
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

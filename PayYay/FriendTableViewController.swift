//
//  FriendTableViewController.swift
//  PayYay
//
//  Created by Zhiqiang Lin on 3/7/17.
//  Copyright © 2017 Zhiqiang Lin. All rights reserved.
//

import UIKit
import Firebase


class FriendTableViewController: UITableViewController {
    
    
    //MARK: Properties
    
    var friends = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load sample users
        loadSampleUsers()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        
        // Table view cells are reused and should be dequeued using a cell identifier
        
        let cellIdentifier = "FriendTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FriendTableViewCell
            else {
                 fatalError("The dequeued cell is not an instance of FriendTableViewCell.")
        }
        
        // Fetches the appropriate user for the data source layout.
        let friend = friends[indexPath.row]
        
        
        // Configure the cell... //using email for now
        cell.nameLabel.text = friend.email
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

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

    
    //MARK: Private Methods
    
    
    
    
    @IBAction func getUID(_ sender: UIBarButtonItem) {
        
        
    }
    
    private func loadSampleUsers() {
        let user1 = User()
        user1.email = "abc@gmail.com"
        let user2 = User()
        user2.email = "123@gmail.com"
        
        friends += [user1, user2]
    }
}

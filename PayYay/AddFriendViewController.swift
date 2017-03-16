//
//  AddFriendViewController.swift
//  Pods
//
//  Created by Zhiqiang Lin on 3/8/17.
//
//

import UIKit
import Firebase
import FirebaseDatabase


class AddFriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var dbRef: FIRDatabaseReference!

    @IBOutlet weak var emailSearchedTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var friends = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dbRef = FIRDatabase.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier
        
        let cellIdentifier = "FriendTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FriendTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of FriendTableViewCell.")
        }
        
        // Fetches the appropriate user for the data source layout.
        let friend = friends[indexPath.row]
        
        
        // Configure the cell... //using email for now
        cell.nameLabel.text = "blah"
        
        return cell
    }

    
    @IBAction func searchByEmail(_ sender: UIButton) {
        
        
        let email = emailSearchedTextField.text!
        
        print(email)
        
//        let emailToIdRef = self.dbRef.child("users")
        
        let emailToIdRef = self.dbRef.child("emailtoId").child(emailToKey(email: email))
        emailToIdRef.observeSingleEvent(of: .value, with: {(snapshot) in
            print(snapshot.value!)
        
        })
        

        
        

        
        
        if email == "" {
            print("No email entered")
        } else {
            print(emailSearchedTextField.text!)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: Private methods
    
    private func emailToKey(email: String) -> String{
        return email.replacingOccurrences(of: ".", with: ",")
    }
}

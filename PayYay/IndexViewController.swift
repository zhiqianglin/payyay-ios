//
//  IndexViewController.swift
//  Pods
//
//  Created by Zhiqiang Lin on 3/7/17.
//
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase



class IndexViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //Firebase reference /??
    
    var dbRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.dbRef = FIRDatabase.database().reference()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Actions
    
    
    @IBAction func login(_ sender: UIButton) {
        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            

            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            self.indexErrorAlert(title: "Error", message: "Please enter an email and password.")
            
//            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
//            
//            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            alertController.addAction(defaultAction)
//            
//            self.present(alertController, animated: true, completion: nil)
        } else {
            DataService.login(email: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (errorInfo) in
                if errorInfo != "" {
                    self.indexErrorAlert(title: "Login Error", message: errorInfo)
                } else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                    print("logged")
                }
            })
        }
        
    }
    
    @IBAction func trying(_ sender: UIButton) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        print("I am in tryping")
        
        let out = DataService.printOut(email: email, password: password)
        
        print("I am back in typing \(out)")
        
    }
    
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            self.indexErrorAlert(title: "Error", message: "Please enter an email and password.")
        }
        
        else {
            print("ok?")
            DataService.createUser(email: email, password: password, completion: { (errorInfo) in
                if errorInfo != "" {
                    self.indexErrorAlert(title: "Error", message: errorInfo)
                } else {
                    print("blah")
                    //Go to the HomeViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                    print("logged")
                    print(errorInfo)
//                    print(FIRAuth.auth()?.currentUser)
                }
            })
        }
        
    }
    
    
    
    
//    @IBAction func addEmailtoId(_ sender: UIButton) {
//        let emailtoUserIdRef = self.dbRef.child("emailtoId")
//        
//        let newUser = User()
//        newUser.userID = "12345"
//        newUser.email = self.emailTextField.text!
//        
//        print(newUser.userID!)
//        print(newUser.email!)
//        
//        
//        var update = [String: Any]()
//        update.updateValue(newUser.email!, forKey: newUser.userID!)
//        
//        print("a")
//        emailtoUserIdRef.setValue(update, withCompletionBlock: {
//            (error, ref) in
//            if (error != nil) {
//                print("b")
//                self.indexErrorAlert(title: "Account Database Error", message: error?.localizedDescription)
//            }
//            
//        })
//        
//    }
    

    //MARK: Private Methods
    
    func indexErrorAlert(title: String, message: String?) { //Why need optional?
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    
    }
    

//    @IBAction func registerButtonPressed(_ sender: UIButton) {
//        let email = emailTextField.text!
//        let password = passwordTextField.text!
//        
//        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
//            self.indexErrorAlert(title: "Error", message: "Please enter an email and password.")
//        }
//            
//        else {
//            DataService.createUser(email: email, password: password, completion: { (errorInfo) in
//                if errorInfo != "" {
//                    self.indexErrorAlert(title: "Error", message: errorInfo)
//                } else {
//                    print("blah")
//                    //Go to the HomeViewController if the login is sucessful
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
//                    self.present(vc!, animated: true, completion: nil)
//                    print("logged")
//                    print(errorInfo)
//                    //                    print(FIRAuth.auth()?.currentUser)
//                }
//            })
//            //                errorInfo = DataService.createUser(email: email, password: password)
//            //                print("I am printing")
//            //                print(errorInfo)
//            //            }
//            //
//            //            queue.sync {
//            //                if errorInfo != "" {
//            //                    self.indexErrorAlert(title: "Error", message: errorInfo)
//            //                } else {
//            //                    //Go to the HomeViewController if the login is sucessful
//            //                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
//            //                    self.present(vc!, animated: true, completion: nil)
//            //                    print("logged")
//            //                    print(errorInfo)
//            //                }
//            //            }
//            //            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {
//            //
//            //                //This is where your uid is created. You can access it by using user!uid. Be sure to unwrap it.
//            //                (user, error) in
//            //
//            //
//            //                print(email + " d")
//            //                print(password + " d")
//            //
//            //
//            //                if error != nil{
//            //                    self.indexErrorAlert(title: "Account Creation Error", message: error?.localizedDescription)
//            //                    //                print("Account Creation Error: \(error?.localizedDescription)")
//            //                } else {
//            //                    //Update the database
//            //                    //This constant holds the uid. Your FIRAuth uid is now the value from user!uid above
//            //                    let currentUserID = FIRAuth.auth()?.currentUser?.uid
//            //
//            //                    //This gives you reference to your database, then to a child node named "users", then another node using the uid, and finally to another node named "userAccount". This final node is where you will keep your dictionary values for your database.
//            //                    let usersRef = self.dbRef.child("users")
//            //
//            //                    let userIDRef = usersRef.child(currentUserID!)
//            //                    let userRef = userIDRef.child("user")
//            //
//            //
//            //
//            //                    //dbRef/users//currentUserID/userAccount
//            //
//            //                    //This is the User Model object. You instantiate it then you set the properties in the object to the values such as the uid, email address, and timestamp in secs
//            //                    let newUser = User()
//            //                    newUser.userID = currentUserID!
//            //                    newUser.email = self.emailTextField.text!
//            //                    //            userAccount.creationDateInSecs = self.timeStamp!
//            //
//            //                    let emailKey = self.emailToKey(email: newUser.email!)
//            //                    let emailtoUserIdRef = self.dbRef.child("emailtoId") //payyal/emailtoID/
//            ////                    var update = [String: Any]()
//            ////                    print(newUser.userID!)
//            ////                    update.updateValue(newUser.userID!, forKey: newUser.email!)
//            //
//            //                    emailtoUserIdRef.updateChildValues([emailKey: newUser.userID!], withCompletionBlock: {
//            //                        (error, ref) in
//            //                        if (error != nil) {
//            //                            self.indexErrorAlert(title: "Account Database Error", message: error?.localizedDescription)
//            //                        }
//            //
//            //                    })
//            ////
//            //
//            //
//            //
//            //
//            //
//            //
//            //                    //Here you initialize an empty dictionary to hold the keys and values you want uploaded to your database
//            //                    var newUserDict = [String:Any]()
//            //
//            //                    //Here you can use a dictionary method to update the keys and matching values. The values are the ones from your UserAccount model's properties and the keys are what I decided I wanted them to be named in FirebaseDatabase. You use these keys to extract the values
//            //                    newUserDict.updateValue(newUser.userID!, forKey: "userID")
//            //                    newUserDict.updateValue(newUser.email!, forKey: "email")
//            //                    //            userAccountDict.updateValue(userAccount.creationDateInSecs!, forKey: "acctCreationDateKey")
//            //
//            //                    //Here you upload your dictionary with the keys and values you set above. Your database will hold these key/value pairs under the "user" node. userRef (you set it above) is the constant that has that node value
//            //
//            //                    //ref = //payyal/users/
//            //                    //ref.update(values, function (errror, user){})
//            //                    //ref.retrivef("key", function(error, data) {a = data})
//            //
//            //                    userRef.updateChildValues(newUserDict, withCompletionBlock: {
//            //
//            //                        (error, user) in
//            //
//            //                        if error != nil{
//            //                            self.indexErrorAlert(title: "Account Database Error", message: error?.localizedDescription)
//            //                            //                        print("Account-Database Error: \(error?.localizedDescription)\n")
//            //                        }
//            //                        
//            //                        else {
//            //                            //Go to the HomeViewController if the login is sucessful
//            //                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
//            //                            self.present(vc!, animated: true, completion: nil)
//            //                            print("logged")
//            //                        
//            //                        }
//            //                        
//            //                    })
//            //                    
//            //
//            //                    
//            //                    
//            ////                    emailtoUserIdRef.setValue({newUser.email!: newUser.userID!}, withCompletionBlock: { (error, firebaseref) -> void in
//            ////                        if (error != nil) {
//            ////                            self.indexErrorAlert(title: "Account Database Error", message: error?.localizedDescription)
//            ////                        }
//            ////                    })
//            ////                    {newUser.email: newUser.userID!}
//            //                    
//            //                }
//            //            })
//            
//        }
//        
//        
//    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
//    private func emailToKey(email: String) -> String{
//        return email.replacingOccurrences(of: ".", with: ",")
//    }
    
}

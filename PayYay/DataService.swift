//
//  DataService.swift
//  PayYay
//
//  Created by Zhiqiang Lin on 3/9/17.
//  Copyright © 2017 Zhiqiang Lin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DataService {
    static var dbRef: FIRDatabaseReference! = FIRDatabase.database().reference()
    
    //Return userID
    static func getUserIdByEmail(email: String) ->String {
        
        let emailToIdRef = self.dbRef.child("emailtoId").child(emailToKey(email: email))
        let userID = ""
        
        
        emailToIdRef.observeSingleEvent(of: .value, with: {(snapshot) in
            print(snapshot.value!)
        })
        return userID
    }
    
    //Reture USER information by userID
    static func getUserByUserID(userID: String) {
        let userRef = self.dbRef.child("users").child(userID)
        
        userRef.observeSingleEvent(of: .value, with: { (userData) in
            print(userData)
        })
    }
    
    static func login(email: String, password: String, completion:@escaping (_ : String) -> Void) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            var errorInfo = ""
            if error != nil {
                errorInfo = error!.localizedDescription
            }
            
            completion(errorInfo)
        }
    }
    
    static func createUser(email: String, password: String, completion:@escaping (_: String) -> Void) {
        // Create a user by Firebase(id, email, imageURL)
            // If success, update our customized User tree
            // Update emailToUserID tree
        
        var errorInfo = ""
        print("abdddddd")
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
 
                errorInfo = error!.localizedDescription
                print("what\(errorInfo)")
            } else {
                //Update the database
                //This constant holds the uid. Your FIRAuth uid is now the value from user!uid above
                let currentUserID = FIRAuth.auth()?.currentUser?.uid
                
                print("aaaaaaa" + currentUserID!)
                //This gives you reference to your database, then to a child node named "users", then another node using the uid, and finally to another node named "userAccount". This final node is where you will keep your dictionary values for your database.
                let userRef = self.dbRef.child("users").child(currentUserID!).child("user")
                
                //This is the User Model object. You instantiate it then you set the properties in the object to the values such as the uid, email address, and timestamp in secs
                let newUser = User()
                
                newUser.userID = currentUserID!
                newUser.email = email
                //Here you initialize an empty dictionary to hold the keys and values you want uploaded to your database
                var newUserDict = [String:Any]()
                //
                //Here you can use a dictionary method to update the keys and matching values. The values are the ones from your UserAccount model's properties and the keys are what I decided I wanted them to be named in FirebaseDatabase. You use these keys to extract the values
                newUserDict.updateValue(newUser.userID!, forKey: "userID")
                newUserDict.updateValue(newUser.email!, forKey: "email")
                
                
                
                //Here you upload your dictionary with the keys and values you set above. Your database will hold these key/value pairs under the "user" node. userRef (you set it above) is the constant that has that node value

                userRef.updateChildValues(newUserDict, withCompletionBlock: {
                    (error, user) in
                    if (error != nil) {
                        errorInfo = error!.localizedDescription
                    }
                })
                
                
                // Update emailToUserID tree
                
                let emailKey = self.emailToKey(email: newUser.email!)
                let emailtoUserIdRef = self.dbRef.child("emailtoId") //payyal/emailtoID/
                
                emailtoUserIdRef.updateChildValues([emailKey: newUser.userID!], withCompletionBlock: {
                    (error, ref) in
                    if (error != nil) {
                        errorInfo += "\n" + error!.localizedDescription
                    }
                    
                })
            }
            print("Clouse!\(errorInfo)")
            completion(errorInfo)

        })
    }

    
    static func printOut(email:String, password: String) -> String{
        let error = email + password
        print("I am in printout\(error)")
        return error
    }

    static func emailToKey(email: String) -> String{
        return email.replacingOccurrences(of: ".", with: ",")
    }
    
    
    

    
}

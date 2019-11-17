//
//  DatabaseManager.swift
//  Deezy
//
//  Created by William Hickman on 11/16/19.
//  Copyright © 2019 William Hickman Ent. All rights reserved.
//

import Foundation
import Firebase

class DatabaseManager {
    
    static var ref = Database.database()
    
    static func uploadUser(uid: String, name: String, songid: String) {
        ref.reference(withPath: "Users").child(uid).setValue(["name":name, "songid":songid, "friends":[]] as [String : Any])
    }
    
    static func getUser(uid: String, completion: @escaping (_ user: User?) -> Void)  {
        ref.reference(withPath: "Users").child(uid).observeSingleEvent(of: .value, with: { (snaphot) in
            if let ss = snaphot.value! as? [String:Any] {
                completion(User(uid: uid, name: ss["name"] as! String, songid: ss["songid"] as! String))
            }
            else {
                completion(nil)
            }
        })
    }
    
    static func addFriend(user: String, friend: String) {
        ref.reference(withPath: "Users").child(user).observeSingleEvent(of: .value, with: { (snapshot) in
            if let ss = snapshot.value! as? [String:Any] {
                var friends = ss["friends"] as! [String]
                friends.append(friend)
                ref.reference(withPath: "Users").child(user).child("friends").setValue(friends)
            }
            else {
                NSLog("user not found")
            }
        })
    }
    
    static func getFriends(uid: String, completion: @escaping (_ success: Bool, _ friends: [User]) -> Void) {
        let userRef = ref.reference(withPath: "Users").child(uid)
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let friendsSS = snapshot.value! as? [String:Any] {
                completion(true, friendsSS["friends"] as! [String])
            }
            else {
                NSLog("could not get friends")
                completion(false, [])
            }
        })
    }
    
}

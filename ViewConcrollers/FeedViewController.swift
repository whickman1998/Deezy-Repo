//
//  FeedViewController.swift
//  Deezy
//
//  Created by William Hickman on 11/16/19.
//  Copyright © 2019 William Hickman Ent. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var friends = [User]()
    var imageCacheManager = ImageCacheManager()
    
    var setterQueue = DispatchQueue(label: "FeedViewController")
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedTableViewCell else {
            return UITableViewCell()
        }
        
        let user = friends[indexPath.row]
        
        cell.nameLabel.text = user.name
        
        user.findSong(completion: { (mediaItem) -> Void in
            if (mediaItem != nil) {
                cell.imageView.image = self.imageCacheManager.cachedImage(url: mediaItem!.artwork.imageURL(size: cell.imageView.frame.size))
            }
        })
        
        return cell
    }
    

    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DatabaseManager.getFriends(uid: Profile.user.uid, completion: { (success, users) -> Void in
            if success {
                self.friends = users
                self.table.reloadData()
            }
            else {
                NSLog("User has no friends")
            }
        })
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

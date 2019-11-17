//
//  User.swift
//  Deezy
//
//  Created by William Hickman on 11/16/19.
//  Copyright © 2019 William Hickman Ent. All rights reserved.
//

import Foundation

class User {
    var uid: String
    var name: String
    var songid: String
    var mediaItem: MediaItem?
    
    var setterQueue = DispatchQueue(label: "User")
    
    let appleMusicManager = AppleMusicManager()
    var authorizationManager: AuthorizationManager?
    
    init(uid: String, name: String, songid: String) {
        authorizationManager = AuthorizationManager(appleMusicManager: appleMusicManager)
        self.uid = uid
        self.name = name
        self.songid = songid
    }
    
    func findSong(completion: @escaping (_ mediaItem: MediaItem?) -> Void) {
        appleMusicManager.performAppleMusicCatalogSearchWithIdentifier(with: songid, countryCode: authorizationManager!.cloudServiceStorefrontCountryCode, completion: { [weak self] (searchResults, error) in
            guard error == nil else {
                NSLog("rip L")
            }
                                                    
            self?.mediaItem = searchResults
            completion(searchResults)
        })
    }
    
}

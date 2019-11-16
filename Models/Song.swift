//
//  Song.swift
//  Deezy
//
//  Created by William Hickman on 11/16/19.
//  Copyright © 2019 William Hickman Ent. All rights reserved.
//

import UIKit
import Foundation

class Song {
    var title: String 
    var artist: String
    var art: UIImage
    var id: String
    
    var artwork: Artwork?
    var imageCacheManager: ImageCacheManager?
    
    init(title: String, artist: String, art: UIImage, id: String) {
        self.title = title
        self.artist = artist
        self.art = art
        self.id = id
    }
    
    init(mediaItem: MediaItem) {
        self.title = mediaItem.name
        self.artist = mediaItem.artistName
        self.art = UIImage()
        self.id = mediaItem.identifier
        self.artwork = mediaItem.artwork
        imageCacheManager = ImageCacheManager()
        updateImage(dimensions: 50)
    }
    
    func updateImage(dimensions: CGFloat) {
        if (artwork != nil) {
            let imageURL = artwork!.imageURL(size: CGSize(width: dimensions, height: dimensions))
            imageCacheManager!.masterGetImage(url: imageURL, completion: { (image) -> Void in
                if (image != nil) {
                    self.art = image!
                }
            })
        }
    }
}

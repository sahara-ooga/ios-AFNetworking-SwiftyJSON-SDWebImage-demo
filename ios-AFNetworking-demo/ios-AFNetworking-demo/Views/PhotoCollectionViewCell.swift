//
//  PhotoCollectionViewCell.swift
//  ios-AFNetworking-demo
//
//  Created by OkuderaYuki on 2017/03/13.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
    
    var photo: Photo? {
        didSet {
            titleLabel.text = photo?.title
            favoriteLabel.text = String.init(format: "★%d", photo?.favoriteNum ?? 0)
            
            //SDWebImage
            imageView.image = nil
            imageView.sd_setImage(with: URL(string: (photo?.thumbnailUrlString)!))
        }
    }
}

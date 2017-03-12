//
//  PhotoCollectionView.swift
//  ios-AFNetworking-demo
//
//  Created by OkuderaYuki on 2017/03/13.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit

/// DataSourceクラス
class PhotoCollectionView: NSObject {

    var photoList = PhotoList()
    func add(photos: PhotoList) {
        photoList = photos
    }
}

// MARK:- UICollectionViewDataSource
extension PhotoCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.photo = photoList.photos[indexPath.row]
        return cell
    }
}

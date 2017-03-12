//
//  PhotozouAPI.swift
//  ios-AFNetworking-demo
//
//  Created by OkuderaYuki on 2017/03/12.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import AFNetworking
import SwiftyJSON

enum Result {
    case success(Any)
    case failure(Error)
}

class PhotozouAPI: NSObject {
    
    class func getRequest(keyword: String,
                          limit: Int,
                          completionHandler: @escaping (Result) -> () = {_ in}) {
        
        // リクエストパラメータを作成する
        let params: [String: Any] = ["keyword": keyword, "limit": limit]
        
        let manager = AFHTTPSessionManager()
        
        // GETリクエストを送る
        manager.get("https://api.photozou.jp/rest/search_public.json",
                    parameters: params,
                    progress: nil,
                    success: { (task, responseObject) in
                        
                        if let responseObject = responseObject {
                            // responseObjectをSwiftyJSONのJSONに変換する
                            let json = JSON(responseObject)
                            
                            // JSONからPhotoListへ変換する
                            guard let photos = json["info"]["photo"].array else {
                                fatalError("jsonが不正")
                            }
                            var photoList = PhotoList()
                            for var photoInfo in photos {
                                var photo = Photo()
                                
                                if let title = photoInfo["photo_title"].string {
                                    photo.title = title
                                }
                                if let favoriteNum = photoInfo["favorite_num"].int {
                                    photo.favoriteNum = favoriteNum
                                }
                                
                                if let thumbnailUrl = photoInfo["thumbnail_image_url"].string {
                                    photo.thumbnailUrlString = thumbnailUrl
                                }
                                
                                photoList.photos.append(photo)
                            }
                            
                            completionHandler(.success(photoList))
                            return
                        }
                        
                        fatalError("responseObjectがnil")
                        
        }) { (task, error) in
            
            print("ERROR:\(error.localizedDescription)")
            completionHandler(.failure(error))
        }
    }
}

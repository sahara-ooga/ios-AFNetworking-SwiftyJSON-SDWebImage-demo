# ios-AFNetworking-SwiftyJSON-SDWebImage-demo
iOS AFNetworking3.1.0 + SwiftyJSON3.1.4 + SDWebImage4.0.0を利用したサンプル

## 1. PodFile

```
  pod 'AFNetworking', '3.1.0'
  pod 'SwiftyJSON', '3.1.4'
  pod 'SDWebImage', '4.0.0'
```

## 2. import する
```
import AFNetworking
import SwiftyJSON
import SDWebImage
```

## 3.1 AFNetworkingの使い方(GETリクエスト)
```swift
let manager = AFHTTPSessionManager()

manager.get("https://api.photozou.jp/rest/search_public.json",
                    parameters: params,
                    progress: nil,
                    success: { (task, responseObject) in
                        // GET成功時の処理
                        if let responseObject = responseObject {
                            print("\(responseObject)")
                        }
}) { (task, error) in
            // GET失敗時の処理
            print("ERROR:\(error.localizedDescription)")
            completionHandler(.failure(error))
}

```
## 3.2 SwiftyJSONの使い方
```swift
let manager = AFHTTPSessionManager()

manager.get("https://api.photozou.jp/rest/search_public.json",
                    parameters: params,
                    progress: nil,
                    success: { (task, responseObject) in
                        // GET成功時の処理
                        if let responseObject = responseObject {
                        
                            // responseObjectをSwiftyJSONのJSONに変換する
                            let json = JSON(responseObject)
                            
                            // JSONを操作する
                            
                            // JSONからphoto配列を生成
                            guard let photos = json["info"]["photo"].array else {
                                fatalError("jsonが不正")
                            }
                            for var photoInfo in photos {
                                
                                if let title = photoInfo["photo_title"].string {
                                    print("title:\(title)")
                                }
                                if let favoriteNum = photoInfo["favorite_num"].int {
                                    print("favoriteNum:\(favoriteNum)")
                                }
                                
                                if let thumbnailUrl = photoInfo["thumbnail_image_url"].string {
                                    print("thumbnailUrl:\(thumbnailUrl)")
                                }
                            }
                        }
}) { (task, error) in
            // GET失敗時の処理
}

```

## 3.3 SDWebImageの使い方
```swift
// URLから画像をダウンロードして、imageViewにセットする
let imageUrl = URL(string: "https://xxx/photo/thumbnail.jpg")
imageView.sd_setImage(with: imageUrl)

```

## 環境

|category | Version| 
|---|---|
| Swift | 3.0 |
| XCode | 8.2.1 |
| Cocoa Pods | 1.2.0 |
| iOS | 10.0〜 |

## OSS

|OSS name | Version| 
|---|---|
| AFNetworking | 3.1.0 |
| SwiftyJSON | 3.1.4 |
| SDWebImage | 4.0.0 |

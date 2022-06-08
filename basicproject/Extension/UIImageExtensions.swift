//
//  UIImageExtensions.swift
//  WeiWeiFresh
//
//  Created by Mac on 2020/6/28.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    //图片压缩
//    如果要保证图片清晰度，建议选择压缩图片质量。如果要使图片一定小于指定大小，压缩图片尺寸可以满足。对于后一种需求，还可以先压缩图片质量，如果已经小于指定大小，就可得到清晰的图片，否则再压缩图片尺寸。
//    NSData *compressData = [image compressWithLengthLimit:500.0f * 1024.0f];
    func compressWithMaxLength(_ maxLength: Int) -> Data {
         // Compress by quality
        var compression:CGFloat = 1.0
        var data = self.jpegData(compressionQuality: compression)
        //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
        if data!.count < maxLength {
            return data!
        }
        var max:CGFloat = 1.0
        var min:CGFloat = 0
        for _ in 0...5 {
            compression = (max + min)/2
            data = self.jpegData(compressionQuality: compression)
            //NSLog(@"Compression = %.1f", compression);
            //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
            if  data!.count < maxLength * Int(0.9) {
                min = compression
            } else if data!.count > maxLength {
                max = compression
            } else {
                break
            }
        }
        
        print("After compressing quality, image size = \(data!.count / 1024) KB")
        if data!.count < maxLength {
            return data!
        }
        var resultImage = UIImage(data: data!)
        // Compress by size
        var lastDataLength = 0
        while data!.count > maxLength && data?.count != lastDataLength {
            lastDataLength = data!.count
            let ratio:CGFloat = CGFloat(CGFloat(maxLength)/CGFloat(data!.count))
             //NSLog(@"Ratio = %.1f", ratio);
            let size = CGSize(width: (resultImage!.size.width) * CGFloat(sqrtf(Float(ratio))), height: (resultImage!.size.width) * CGFloat(sqrtf(Float(ratio))))
            
            UIGraphicsBeginImageContext(size)
            resultImage?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            resultImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext();
            data = resultImage!.jpegData(compressionQuality: compression)
           
            print("In compressing size loop, image size = \(data!.count / 1024) KB")
        }
        print("After compressing size loop, image size = \(data!.count / 1024) KB")
        return data!
    }
    
    func reSizeImage(reSize:CGSize)->UIImage {
          //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
          draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
          
          let reSizeImage:UIImage =   UIGraphicsGetImageFromCurrentImageContext()!
          UIGraphicsEndImageContext()
          return reSizeImage;
      }
       
      /**
       *  等比率缩放
       */
      func scaleImage(scaleSize:CGFloat)->UIImage {
          let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
          return reSizeImage(reSize: reSize)
      }
    
}

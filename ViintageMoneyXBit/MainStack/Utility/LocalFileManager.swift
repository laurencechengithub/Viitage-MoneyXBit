//
//  FileManager.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/12.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init() {
        
    }
    
    func saveImage(image: UIImage, imageName:String, folderName:String) {
        //create folder
        createFolderIfNeeded(folderName: folderName)
        //file:///Users/laurencembp2/Library/Developer/CoreSimulator/Devices/59AFE8D3-72AC-4127-8D02-49323D139807/data/Containers/Data/Application/13BC47C0-69CE-44E1-8487-B69A183E6685/Library/Caches/
        
        //get path for image
        guard
            let data = image.pngData(),
            let url = getUrlForImage(imageName: imageName, folderName: folderName)
        else { return }
        
        //save image to path
        do {
            try data.write(to: url)
        } catch let err {
            print("Error when saving image : \(imageName). \(err)")
        }
    }
    
    
    func getImage(imageName:String, folderName:String) -> UIImage? {
        guard
            let url = getUrlForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil //image not exist
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    
    private func createFolderIfNeeded (folderName:String) {
        
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        if FileManager.default.fileExists(atPath: url.path) == false {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let err {
                print("error to create directory \(folderName), \(err) ")
            }
        }
        
    }
    
    private func getURLForFolder(folderName:String) -> URL? {
        
        // here even though when using cachesDirectory even when it get full load we are still capable of downloading it
        // .first => is the first url
        guard let fileURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
  
        return fileURL.appendingPathComponent(folderName) // return us the folder url that we are looking for
        
    }
    
    private func getUrlForImage(imageName:String, folderName:String) -> URL? {
        
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")

    }
    
}

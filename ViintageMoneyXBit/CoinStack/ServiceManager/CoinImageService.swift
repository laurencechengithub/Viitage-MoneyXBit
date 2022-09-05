//
//  CoinImageService.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/8.
//

import SwiftUI
import Combine

class CoinImageService {
    
    @Published var downLoadedImage:UIImage? = nil
    
//    var urlString : String?
    private var imageSubscription:AnyCancellable?
    private var coin : Coin
    private let localFileManager = LocalFileManager.instance
    private let localFolderName = "coin_images"
    private var imgName : String!
    
    init(with coin:Coin) {
        self.coin = coin
        self.imgName = coin.id
        checkCoinImageExist()
    }
    
    
    private func checkCoinImageExist() {
        if let savedImg = localFileManager.getImage(imageName: coin.id, folderName: localFolderName) {
            self.downLoadedImage = savedImg
//            print("get image from local file manager")
        } else {
            downLoadCoinImage()
//            print("downLoadedImage")
        }
        
    }
    
    
    private func downLoadCoinImage() {
        
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkManager.download(url: url)
            .tryMap({ imgData in
                return UIImage(data: imgData)
            })
            .receive(on: DispatchQueue.main) //receive it on main thread
            .sink { ReceiveCompletion in
                // param: receiveComplete => The closure to execute on completion.
                switch ReceiveCompletion{
                case .finished:
                    print("Publisher recevied complete")
                    break
                case .failure(let err):
                    print("error: \(err)")
                }
            } receiveValue: { [weak self] theImage in
                // param: receiveValue => The closure to execute on receipt of a value.
                guard let self = self,
                      let img = theImage
                else { return }
                self.downLoadedImage = img
                self.imageSubscription?.cancel()
                self.localFileManager.saveImage(image: img, imageName: self.imgName, folderName: self.localFolderName)
            }

           



    }
    
}

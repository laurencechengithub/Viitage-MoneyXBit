//
//  NetworkManager.swift
//  ViitageEX
//
//  Created by LaurenceMBP2 on 2022/7/6.
//

import Foundation
import Combine

class NetworkManager {
    

    static func download(url:URL) -> AnyPublisher<Data,Error> {
        
        return URLSession.shared.dataTaskPublisher(for: url)
            //making sure it's on the background thread although dataTaskPublisher already are
            .subscribe(on: DispatchQueue.global(qos: .default)) //can delete this
            
            //clean code for trymap for returning the response data
            //REMARK#1-A
            //.tryMap({ try handleURLResponse(output: $0)})
            //
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse else {
                    throw VEXerrorMessage.invalidResponse
                }

                switch response.statusCode {
                case 200:
                    return output.data
                default:
                    throw VEXerrorMessage.invalidResponse
                }
            }
            .retry(2) //if url response fail restart
            .eraseToAnyPublisher()
    }
    

    //REMARK#1-B
//    static func handleURLResponse(output:URLSession.DataTaskPublisher.Output) throws -> Data {
//        guard let response = output.response as? HTTPURLResponse else {
//            throw URLError(.badServerResponse)
//        }
//
//        switch response.statusCode {
//        case 200:
//            return output.data
//        default:
//            throw VEXerrorMessage.invalidResponse
//        }
//    }
    
    
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}

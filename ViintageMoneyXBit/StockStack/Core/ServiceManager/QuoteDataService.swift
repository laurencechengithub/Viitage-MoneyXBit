//
//  QuoteDataService.swift
//  ViitageEX
//
//  Created by LaurenceMBP2 on 2022/7/5.
//

import Foundation
import Combine

//struct SomeResponseType {
//   let data: Data
//   let response: HTTPURLResponse
//}

class QuoteDataService {
    
    //publisher have subscriber, subscriber listen to publisher
    @Published var quote:Quote?
    var subcriptionCancellable: AnyCancellable?
    
    init(symbol:String) {
        getQuote(using: symbol)
    }

    
    func getQuote(using symbol:String) {
        
        guard let url = URL(string: "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=\(symbol)&apikey=\(URLManager.stockApiKey)")  else {
            return
        }
        
        subcriptionCancellable = NetworkManager.download(url: url)
            .decode(type: Quote.self, decoder: JSONDecoder())
            //sink => observe values received by the publisher and process them using a closure you specify.
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] returnQuote in
                guard let self = self else { return }
                self.quote = returnQuote
                self.subcriptionCancellable?.cancel()
            }
    }
}




// init
//        gettQuotes(using: [String:String]() ) { [weak self] resultData in
//
//            guard let self = self else { return }
//
//            switch resultData {
//            case .success(let quote):
//                self.firstTenQuote.append(quote)
//            case .failure(let err):
//                #warning("add alertview here")
//                print(err)
//            }
//        }


//func
//    func gettQuotes(using header:[String:String], complete: @escaping(Result<Quote,GFerrorMessage>)->Void) {
//
//        guard let url = URL(string: "https://www.alphavantage.co/query")  else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.allHTTPHeaderFields = ["function":"GLOBAL_QUOTE",
//                                       "symbol":"AAPL",
//                                       "apikey":"\(apiKey)"]
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            print("request : \(request)")
//            if let _ = error { complete(.failure(.invalidResponse))}
//            guard let httpResponse = response as? HTTPURLResponse else {
//                complete(.failure(.invalidResponse))
//                return
//            }
//            switch httpResponse.statusCode {
//            case 200 :
//                guard let data = data else {
//                    complete(.failure(.http200DataValid))
//                    return
//                }
//                do {
//                    let decoder = JSONDecoder()
////                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                    let quote = try decoder.decode(Quote.self, from: data)
//                    complete(.success(quote))
//                } catch {
//                    complete(.failure(.http200JsonFail))
//                }
//
//            case 404 :
//                complete(.failure(.http404))
//            case 400 :
//                complete(.failure(.http400))
//            default:
//                break
//            }
//        }
//        task.resume()

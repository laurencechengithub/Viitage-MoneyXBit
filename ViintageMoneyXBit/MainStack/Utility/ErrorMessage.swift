//
//  ErrorMessage.swift
//  PerroHouse
//
//  Created by LaurenceMBP2 on 2022/5/9.
//

import Foundation

enum VEXerrorMessage:String, Error {

    case invalidURL         = "url false"
    case invalidUserName    = "This user name is invalid, please check and try again"
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from server"
    case invalidData        = "The data received from server was invalid"
    case http200DataValid   = "httpCode:200 Data received was invalid"
    case http200JsonFail    = "Data received was invalid while decoding JSON"
    case http404            = "httpCode:404"
    case http400            = "httpCode:400"
    case unableToFavorite   = "Error when favoriting this follower"
    case alreadyInFavorite  = "Already in Favorites List"
}

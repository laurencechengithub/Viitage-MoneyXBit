//
//  PortfolioDataService.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/21.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container:NSPersistentContainer!
    private let containerName: String = "PortFolioContainer"
    private let entityName:String = "PortFolioEntities"
    
    @Published var savedEntities: [PortFolioEntities] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { storeDesscription, error in
            if let error = error {
                print("Error loading Core data with error : \(error)")
            }
        }
        getPortfolio()
    }
    
    //MARK: PUBLIC
    
    func updatePortfolio(coin:Coin, amount:Double) {
        
//        if let entity = savedEntities.first(where: { (savedEntity) -> Bool in
//            return savedEntity.coinID == coin.id
//        }) {}
//        same as below
//        VV
        
        //check whether coin is already in portfolio => the entity exist
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(entityWith: coin, amount: amount)
        }
    }
    
    
    //MARK: PRIVATE
    private func getPortfolio() {
        let request = NSFetchRequest<PortFolioEntities>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let err {
            print("Error fetching coredata \(err)")
        }
    }
    
    private func add(entityWith coin:Coin, amount:Double) {
        
        let entity = PortFolioEntities(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        
        saveToContainer()
        getPortfolio()//這裡再取一次 是確保 @Published savedEntities 永有最新資料
    }
    
    private func saveToContainer() {
        do {
            try container.viewContext.save()
        } catch let err {
            print("error while saving core data \(err)")
        }
    }
    
    private func update(entity: PortFolioEntities, amount:Double) {
        entity.amount = amount
        saveToContainer()
        getPortfolio()//這裡再取一次 是確保 @Published savedEntities 永有最新資料
    }
    
    private func delete(entity: PortFolioEntities) {
        container.viewContext.delete(entity)
        saveToContainer()
        getPortfolio()
    }
    
    
}

//
//  CoreDataManager.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 17.04.2024.
//

import UIKit
import CoreData

private let entityName = "ProductsInCart"

enum CoreDataError: Error {
    case AppDelegateUnavailable
    case EntityDescriptionError
    case DataConversionError
    case NoMatchingObjectError
}

final class CoreDataManager {
    
    private let application: UIApplication
    
    init(application: UIApplication = UIApplication.shared) {
        self.application = application
    }
    
    func addToCoreData(forProduct product: Product) async throws {
        guard let appDelegate = await application.delegate as? AppDelegate else {
            throw CoreDataError.AppDelegateUnavailable
        }
        let managedContext = await appDelegate.persistentContainer.viewContext
        guard let productEntity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else {
            throw CoreDataError.EntityDescriptionError
        }
        
        let productInCart = NSManagedObject(entity: productEntity, insertInto: managedContext)
        productInCart.setValue(product.id, forKey: "id")
        productInCart.setValue(product.quantity, forKey: "quantity")
        
        do {
            try managedContext.save()
        } catch {
            throw error
        }
    }
    
    func updateProductQuantity(id: String, newQuantity: Int) async throws {
        guard let appDelegate = await application.delegate as? AppDelegate else {
            throw CoreDataError.AppDelegateUnavailable
        }
        let managedContext = await appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let results = try managedContext.fetch(fetchRequest)
            if let productToUpdate = results.first as? NSManagedObject {
                productToUpdate.setValue(newQuantity, forKey: "quantity")
                try managedContext.save()
            } else {
                throw CoreDataError.NoMatchingObjectError
            }
        } catch {
            throw error
        }
    }

    
    func fetchAllCoreData() async throws -> [(id: String, quantity: Int)] {
        guard let appDelegate = await application.delegate as? AppDelegate else {
            throw CoreDataError.AppDelegateUnavailable
        }
        let managedContext = await appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(fetchRequest)
            return try result.compactMap { data in
                guard let data = data as? NSManagedObject,
                      let id = data.value(forKey: "id") as? String,
                      let quantity = data.value(forKey: "quantity") as? Int else {
                    throw CoreDataError.DataConversionError
                }
                return (id, quantity)
            }
        } catch {
            throw error
        }
    }
    
    func deleteCoreData(forProduct product: Product) async throws {
        guard let appDelegate = await application.delegate as? AppDelegate else {
            throw CoreDataError.AppDelegateUnavailable
        }
        let managedContext = await appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", product.id)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            if let objectToDelete = results.first as? NSManagedObject {
                managedContext.delete(objectToDelete)
                try managedContext.save()
            } else {
                throw CoreDataError.NoMatchingObjectError
            }
        } catch {
            throw error
        }
    }
    
    func deleteAllData() async throws {
        guard let appDelegate = await application.delegate as? AppDelegate else {
            throw CoreDataError.AppDelegateUnavailable
        }
        let managedContext = await appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results {
                guard let managedObjectData = managedObject as? NSManagedObject else { continue }
                managedContext.delete(managedObjectData)
            }
            try managedContext.save()
        } catch {
            throw error
        }
    }

}

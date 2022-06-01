//
//  CoreDataService.swift
//  AppLatestPhones
//
//  Created by user214004 on 4/16/22.
//

import Foundation
import CoreData

class CoreDataService {
    
    static var Shared = CoreDataService()
    
    func insertPhoneIntoCoreData(name: String, date: Date, url: String){
        let newPhone = PhoneEntity(context: persistentContainer.viewContext)
        newPhone.date = Date.now
        newPhone.name = name
        newPhone.src = url
        saveContext()
        print(url)
    }
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "AppLatestPhones")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    
    func getAllPhonesFromStorage() -> [PhoneEntity] {
        var result = [PhoneEntity]()
        let phoneFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PhoneEntity")
        do {
                  result = try (persistentContainer.viewContext.fetch(phoneFetch) as? [PhoneEntity])!
                  
                print( result.count)
              }catch {
                  print (error)
                  
              }
              return result
    }
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteMyPref(toDeletePref: PhoneEntity)  {
        persistentContainer.viewContext.delete(toDeletePref)
        saveContext()
    }}

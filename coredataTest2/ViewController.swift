//
//  ViewController.swift
//  coredataTest2
//
//  Created by William Lennartsson on 2020-02-26.
//  Copyright © 2020 William Lennartsson. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // let managedContext = AppDelegate.viewContext
//        let request = NSFetchRequest(entityName: <#T##String#>)
//        let users = context.execute(<#T##request: NSPersistentStoreRequest##NSPersistentStoreRequest#>)
        
        
        loadUser()
        // newDBEntry()
    }
    
    func loadMoviesForUser(user: User) {
        print("User is.. :\(user)")
        let context = AppDelegate.viewContext
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        request.predicate = NSPredicate(format: "owner = %@", user)
        let movies = try? context.fetch(request)
        print("\(movies?.count ?? 0)")
        if let movies = movies {
            for movie in movies {
                print("Movie: ", movie.title ?? "No title")
                print("Owner: \(movie.owner?.name ?? "No owner")")
            }
        }
    }
    
    func deleteUser(context: NSManagedObjectContext, user: User) {
        context.delete(user)
        try? context.save()
    }
    
    func loadUser() {
        let context = AppDelegate.viewContext
        context.perform {
            // Databas grejer här
        
            let request: NSFetchRequest<User> = User.fetchRequest()
            let searchName = "William"
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            request.predicate = NSPredicate(format: "name = %@", searchName)
            do {
                let users = try? context.fetch(request)
                if let users = users {
                    for user in users {
                        print("User name: ", user.name ?? "No name")
                    }
                }
            } catch {
                // Hantera errors
            }
         
        }
    }
    
    // Insert new entry to DB using setValue
    // Not recommended
    
//    func newDBEntry() {
//        let context = AppDelegate.viewContext
//        let movie: NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: context)
//        movie.setValue("Find Nemo", forKeyPath: "title")
//        movie.value(forKey: "title")
//    }
    
    func newDBEntry() {
        let context = AppDelegate.viewContext
        let movie = Movie(context: context)
        movie.title = "The Matrix"
        movie.director = "Lana & Lilly Wachowski"
        movie.identifier = "9asdjasd92jadsdja29"
        let owner = User(context: context)
        movie.owner = owner
        movie.owner?.name = "William"
        do {
            try context.save()
            print("Saved successfully")
        } catch {
            // Hantera errors här
        }
    }


}


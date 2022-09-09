import Foundation
import UIKit
import CoreData

class DatabaseHelper {
    
    static let shareInstance = DatabaseHelper()
    
    // Save
    
    func save(title : String , shortDescription : String , image : Data) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let imageInstance = ImageEntity(context : managedContext)
        imageInstance.image = image
        imageInstance.title = title
        imageInstance.shortDescripiton = shortDescription
        
        do {
            print("Saved")
            try managedContext.save()
        
        }catch let error as NSError{
            
            print("Could not save \(error) , \(error.userInfo)")
        }
        
    }
    
    func fetchImage() ->[ImageEntity] {
        
        var fetchingImage = [ImageEntity]()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return fetchingImage}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ImageEntity")
        
        do {
            print("All data ")
        fetchingImage = try managedContext.fetch(fetchRequest) as! [ImageEntity]
            
        } catch  {
            print("Error")
        }
        return fetchingImage
    }
    
    func deleteData(title : String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ImageEntity")
        fetchRequest.predicate = NSPredicate(format: "title = %@", title)
        
        do {
            let test = try! managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do {
                print("deleted. ")
                try managedContext.save()
            }
            catch{
                print(error)
            }catch {
                print(error)
            }
        }
    }
}



import UIKit
import CoreData

var Groups = [NSManagedObject] ()
var ItemsGroups = [NSManagedObject] ()
var ItemStorage  = [NSManagedObject] ()

func saveItemsStorageGroup (nameGroup : String, icon : String?){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Groupss",in: managedContext)
    let GroupsItem = NSManagedObject(entity: entity!,insertInto: managedContext)
    GroupsItem.setValue(nameGroup, forKeyPath: "nameGroup")
    if icon != nil {GroupsItem.setValue(icon!, forKeyPath: "icon")}
    do { try managedContext.save() }
    catch let error as NSError { print("Could not save. \(error), \(error.userInfo)")  }
    Groups.append(GroupsItem)
}
 
 func saveItemsLStorage (groupName : String, name : String, weight : Double = 0.0, plus : Double = 1.0, minus : Double = 1.0 , measure : String = "KG"){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "GroupItem",in: managedContext)
    let StorageItem = NSManagedObject(entity: entity!,insertInto: managedContext)
    StorageItem.setValue(groupName, forKeyPath: "group")
    StorageItem.setValue(name, forKeyPath: "name")
    StorageItem.setValue(round(weight * 100)/100, forKeyPath: "weight")
    StorageItem.setValue(round(plus * 100)/100, forKeyPath: "plus")
    StorageItem.setValue(round(minus * 100)/100, forKeyPath: "minus")
    StorageItem.setValue(measure, forKeyPath: "measure")
    do { try managedContext.save() }
    catch let error as NSError { print("Could not save. \(error), \(error.userInfo)")  }
    ItemStorage.append(StorageItem)
    
 }

func loadItemsStorageGroup(){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Groupss")
    do { Groups = try managedContext.fetch(fetchRequest) }
    catch let error as NSError { print("Could not fetch. \(error), \(error.userInfo)") }
}
func loadItemsStorage(nameGroup : String){
    ItemsGroups = []
    ItemStorage = []
     guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
     let managedContext = appDelegate.persistentContainer.viewContext
     let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GroupItem")
     do { ItemsGroups = try managedContext.fetch(fetchRequest) }
     catch let error as NSError { print("Could not fetch. \(error), \(error.userInfo)") }
    if ItemsGroups.count > 0{
        //var k = 0
        for i in 0..<ItemsGroups.count{
            if ItemsGroups[i].value(forKey: "group") as! String == nameGroup{
                ItemStorage.append(ItemsGroups[i])
                //k = k + 1
            }
        }
    }
 }

func removeItemStorageGroup (at index : Int){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    if index == -1{
        for i in  (0..<Groups.count).reversed() {
            managedContext.delete(Groups[i])
            Groups.remove(at: i)
        }
    }else{
        managedContext.delete(Groups[index])
        Groups.remove(at: index)
    }
    do { try managedContext.save() }
    catch let error as NSError { print("Could not save. \(error), \(error.userInfo)")  }
}
 
 func removeItemStorage (at index : Int){
     guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
     let managedContext = appDelegate.persistentContainer.viewContext
     if index == -1{
         for i in  (0..<ItemStorage.count).reversed() {
             managedContext.delete(ItemStorage[i])
             ItemStorage.remove(at: i)
         }
     }else{
         managedContext.delete(ItemStorage[index])
         ItemStorage.remove(at: index)
     }
     do { try managedContext.save() }
     catch let error as NSError { print("Could not save. \(error), \(error.userInfo)")  }
 }



//////////////////////////////////
/*func repairItemList (at index : Int, price : Double, _ done : Bool){
    print(index)
    ItemsList[index].setValue(round(price * 100)/100, forKey: "price")
    ItemsList[index].setValue(done, forKey: "done")
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    do { try managedContext.save() }
    catch let error as NSError { print("Could not save. \(error), \(error.userInfo)")  }
}
*/

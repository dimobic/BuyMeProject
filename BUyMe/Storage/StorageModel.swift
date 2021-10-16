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
 
 func saveItemsLStorage (groupName : String, name : String, weight : String?, plus : String?, minus : String?, measure : Int = 1 ){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "GroupItem",in: managedContext)
    let StorageItem = NSManagedObject(entity: entity!,insertInto: managedContext)
     
    StorageItem.setValue(groupName, forKeyPath: "group")
    StorageItem.setValue(name, forKeyPath: "name")
     if weight != nil, let weightM = textToDouble(weight){
         StorageItem.setValue(round(weightM * 100)/100, forKeyPath: "weight")
     }else{StorageItem.setValue(0.0, forKeyPath: "weight")}
     if plus != nil, let plusM = textToDouble(plus){
         StorageItem.setValue(round(plusM * 100)/100, forKeyPath: "plus")
     }else{StorageItem.setValue(1.0, forKeyPath: "plus")}
     if minus != nil, let minusM = textToDouble(minus){
         StorageItem.setValue(round(minusM * 100)/100, forKeyPath: "minus")
     }else{StorageItem.setValue(1.0, forKeyPath: "minus")}
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

func repairItemStorageAdd (at index : Int, groupName : String, name : String, weight : String?, plus : String?, minus : String?, measure : Int = 1 ){
    ItemStorage[index].setValue(name, forKeyPath: "name")
     if weight != nil, let weightM = textToDouble(weight){
         ItemStorage[index].setValue(round(weightM * 100)/100, forKeyPath: "weight")
     }else{ItemStorage[index].setValue(0.0, forKeyPath: "weight")}
     if plus != nil, let plusM = textToDouble(plus){
         ItemStorage[index].setValue(round(plusM * 100)/100, forKeyPath: "plus")
     }else{ItemStorage[index].setValue(1.0, forKeyPath: "plus")}
     if minus != nil, let minusM = textToDouble(minus){
         ItemStorage[index].setValue(round(minusM * 100)/100, forKeyPath: "minus")
     }else{ItemStorage[index].setValue(1.0, forKeyPath: "minus")}
    ItemStorage[index].setValue(measure, forKeyPath: "measure")
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    do { try managedContext.save() }
    catch let error as NSError { print("Could not save. \(error), \(error.userInfo)")  }
}

func repairItemStodagePM (at index :Int, weight : Bool){
    let weightDouble = ItemStorage[index].value(forKey: "weight") as! Double
    if weight == true {
        let plus = ItemStorage[index].value(forKey: "plus") as! Double
        ItemStorage[index].setValue(round((weightDouble + plus) * 100)/100, forKeyPath: "weight")
    }else {
        let minus = ItemStorage[index].value(forKey: "minus") as! Double
        if weightDouble - minus > 0 { ItemStorage[index].setValue(round((weightDouble - minus) * 100)/100, forKeyPath: "weight")
        }else{ItemStorage[index].setValue(0, forKeyPath: "weight")}
    }
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    do { try managedContext.save() }
    catch let error as NSError { print("Could not save. \(error), \(error.userInfo)")  }
}

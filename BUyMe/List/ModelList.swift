import UIKit
import CoreData

var ItemsList = [NSManagedObject] ()
var sum: Double = 0.0

func saveItemsList (name : String, price : Double = 0.0, done : Bool = false){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "ListItems",in: managedContext)
    let ListItems = NSManagedObject(entity: entity!,insertInto: managedContext)
    ListItems.setValue(round(price * 100)/100, forKeyPath: "price")
    ListItems.setValue(name, forKeyPath: "name")
    ListItems.setValue(done, forKeyPath: "done")
    do { try managedContext.save() }
    catch let error as NSError { print("Could not save. \(error), \(error.userInfo)")  }
    ItemsList.append(ListItems)
}

func loadItemsList(){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ListItems")
    do { ItemsList = try managedContext.fetch(fetchRequest) }
    catch let error as NSError { print("Could not fetch. \(error), \(error.userInfo)") }
}

func removeItemList (at index : Int){
    //print(index)
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    if index == -1{
        print(ItemsList.count)
        for i in  (0..<ItemsList.count).reversed() {
            print(i)
            managedContext.delete(ItemsList[i])
            ItemsList.remove(at: i)
        }
    }else{
        managedContext.delete(ItemsList[index])
        ItemsList.remove(at: index)
    }
    do { try managedContext.save() }
    catch let error as NSError { print("Could not save. \(error), \(error.userInfo)")  }
}




func repairItemList (at index : Int, price : Double, _ done : Bool){
    print(index)
    ItemsList[index].setValue(round(price * 100)/100, forKey: "price")
    ItemsList[index].setValue(done, forKey: "done")
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    do { try managedContext.save() }
    catch let error as NSError { print("Could not save. \(error), \(error.userInfo)")  }
}

func ListSum() -> Double{
    sum = 0
    if ItemsList.count > 1{
        for i in 0...ItemsList.count - 1{
            let price: Double = (ItemsList[i].value(forKey: "price") as! Double)
            sum = sum + price}
    }
    return sum
}

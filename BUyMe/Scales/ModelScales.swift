import UIKit
import CoreData

var ItemsScales = [NSManagedObject] ()

func textToDouble( _ text : String?) -> Double?{
    if text != nil {
        if let doubleText = Double(text!){
            return doubleText
        }else{
            let someNumb = NumberFormatter().number(from: text!)
            if let someNumb = someNumb{
                let doubleValue = Double(truncating: someNumb)
                return doubleValue
            }
        }
    }
    return nil
}

func saveItemsScales (_ price : Double, _ weight : Double){
    let averagePrice = price / weight
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "ScalesItemst",in: managedContext)
    let ScalesItemst = NSManagedObject(entity: entity!,insertInto: managedContext)
    ScalesItemst.setValue(round(price * 100)/100, forKeyPath: "price")
    ScalesItemst.setValue(round(weight * 100)/100, forKeyPath: "weight")
    ScalesItemst.setValue(round(averagePrice * 1000)/1000, forKeyPath: "averagePrice")
    do { try managedContext.save() }
    catch let error as NSError { print("Could not save. \(error), \(error.userInfo)")  }
    ItemsScales.append(ScalesItemst)
}

func loadItemsScales(){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ScalesItemst")
    do { ItemsScales = try managedContext.fetch(fetchRequest) }
    catch let error as NSError { print("Could not fetch. \(error), \(error.userInfo)") }
}

func removeItemScales (at index : Int){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    if index == -1{
        print(ItemsScales.count)
        for i in  (0..<ItemsScales.count).reversed() {
            print(i)
            managedContext.delete(ItemsScales[i])
            ItemsScales.remove(at: i)
        }
    }else{
        managedContext.delete(ItemsScales[index])
        ItemsScales.remove(at: index)
    }
    do { try managedContext.save() }
    catch let error as NSError { print("Could not save. \(error), \(error.userInfo)")  }
}




func repairItemScales (at index : Int, price : Double){
    print(index)
    ItemsScales[index].setValue(round(price * 100)/100, forKey: "price")
    let weight = ItemsScales[index].value(forKey: "weight") as! Double
    let averagePrice = price / weight
    ItemsScales[index].setValue(round(averagePrice * 1000)/1000, forKey: "averagePrice")
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    do { try managedContext.save() }
    catch let error as NSError { print("Could not save. \(error), \(error.userInfo)")  }
}

func repairItemScales (at index : Int, weight : Double){
    print(index)
    let price = ItemsScales[index].value(forKey: "price") as! Double
    ItemsScales[index].setValue(round(weight * 100)/100, forKey: "weight")
    let averagePrice = price / weight
    ItemsScales[index].setValue(round(averagePrice * 1000)/1000, forKey: "averagePrice")
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    do { try managedContext.save() }
    catch let error as NSError { print("Could not save. \(error), \(error.userInfo)")  }
}




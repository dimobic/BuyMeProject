import UIKit
import CoreData

class ScalesItem {
    var weight: Double = 0
    var price : Double = 0
    var averagePrice : Double = 0
    init(_ price : Double, _ weight : Double) {
        self.price = price
        self.weight = weight
        self.averagePrice = weight / price
    }
}


var Items = [NSManagedObject] ()

func saveScalesItems (_ price : Double, _ weight : Double){
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
    Items.append(ScalesItemst)
}

func loadScalesItems(){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ScalesItemst")
    do { Items = try managedContext.fetch(fetchRequest) }
    catch let error as NSError { print("Could not fetch. \(error), \(error.userInfo)") }
}

func removeItem (at index : Int){
    //print(index)
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    if index == -1{
        print(Items.count)
        for i in  (0..<Items.count).reversed() {
            print(i)
            managedContext.delete(Items[i])
            Items.remove(at: i)
        }
    }else{
        managedContext.delete(Items[index - 1])
        Items.remove(at: index - 1)
    }
    do { try managedContext.save() }
    catch let error as NSError { print("Could not save. \(error), \(error.userInfo)")  }
}
func repairItem (at index : Int, price : Double){
    print(index)
    Items[index - 1 ].setValue(round(price * 100)/100, forKey: "price")
    let weight = Items[index - 1 ].value(forKey: "weight") as! Double
    let averagePrice = price / weight
    Items[index - 1 ].setValue(round(averagePrice * 1000)/1000, forKey: "averagePrice")
}
func repairItem (at index : Int, weight : Double){
    print(index)
    let price = Items[index - 1 ].value(forKey: "price") as! Double
    Items[index - 1].setValue(round(weight * 100)/100, forKey: "weight")
    let averagePrice = price / weight
    Items[index - 1 ].setValue(round(averagePrice * 1000)/1000, forKey: "averagePrice")
    
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "ScalesItemst",in: managedContext)
    let ScalesItemst = NSManagedObject(entity: entity!,insertInto: managedContext)
    //managedContext
    do { try managedContext.save() }
    catch let error as NSError { print("Could not save. \(error), \(error.userInfo)")  }
}




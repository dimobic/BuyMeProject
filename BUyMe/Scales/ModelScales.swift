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
    let averagePrice = weight / price
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "ScalesItemst",in: managedContext)
    let ScalesItemst = NSManagedObject(entity: entity!,insertInto: managedContext)
    ScalesItemst.setValue(price, forKeyPath: "price")
    ScalesItemst.setValue(weight, forKeyPath: "weight")
    ScalesItemst.setValue(averagePrice, forKeyPath: "averagePrice")
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



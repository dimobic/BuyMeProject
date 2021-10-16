import UIKit
import CoreData

protocol StorageNewElementProtocol :AnyObject{
    func doneAddTapButton (groupName : String, name : String, weight : String?, plus : String?, minus : String? , measure : Int)
    func doneEditTapButton(index: Int, groupName : String, name : String, weight : String?, plus : String?, minus : String? , measure : Int)
    func cancelTapButton()
}

protocol StoragePlusMinusProtocol :AnyObject{
    func plusButton( index: Int)
    func minusButton(index: Int)
}

class StorageItemTable: UITableViewController, UINavigationControllerDelegate, StoragePlusMinusProtocol, StorageNewElementProtocol {
    func plusButton(index: Int) {
        repairItemStodagePM(at: index, weight: true)
        tableView.reloadData()

    }
    
    func minusButton(index: Int) {
        repairItemStodagePM(at: index, weight: false)
        tableView.reloadData()
    }
    
    func doneAddTapButton(groupName : String, name : String, weight : String?, plus : String?, minus : String? , measure : Int) {
        navigationController?.popViewController(animated: true)
        saveItemsLStorage(groupName: nameGroup, name: name, weight: weight, plus: plus, minus: minus, measure: measure)
        tableView.reloadData()
    }
    func doneEditTapButton(index: Int, groupName : String, name : String, weight : String?, plus : String?, minus : String? , measure : Int) {
        navigationController?.popViewController(animated: true)
        repairItemStorageAdd(at: index, groupName: nameGroup, name: name, weight: weight, plus: plus, minus: minus, measure: measure)
        tableView.reloadData()
    }
    func cancelTapButton() {
        navigationController?.popViewController(animated: true)
    }
    
    var nameGroup : String = ""
    @objc func CancelButton(){ dismiss(animated: true, completion: nil)}
    
    @objc func AddButton(){
        let viewController = StorageAddTable()
        viewController.delegate = self
        viewController.nameItem = nil
        viewController.group = nameGroup
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        DispatchQueue.main.async { 
            loadItemsStorage(nameGroup: self.nameGroup)
            self.tableView.reloadData()
        }
        //tableView.allowsSelection = false
        navigationItem.title = nameGroup
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(CancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddButton))
        tableView.register(StorageItemCell.self, forCellReuseIdentifier: "cellDel")

    }

//------------------------------------//
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemStorage.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDel", for: indexPath) as! StorageItemCell
        cell.nameLabel.text = (ItemStorage[indexPath.row].value(forKey: "name") as! String)
        cell.delegete = self
        cell.index = indexPath.row
        let measure: String
        switch (ItemStorage[indexPath.row].value(forKey: "measure") as! Int){
        case 0:
            measure = " Кг"
        case 1:
            measure = " г"
        case 2:
            measure = " Л"
        case 3:
            measure = " мЛ"
        case 4:
            measure = " Шт"
        default:
            measure = " Кг"
        }
        cell.weightLabel.text = String(ItemStorage[indexPath.row].value(forKey: "weight") as! Double) + measure
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = StorageAddTable()
        viewController.nameItem = ItemStorage[indexPath.row]
        viewController.group = nameGroup
        viewController.index = indexPath.row
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return.none
        }else{
            return .delete}
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
            return "Удалить"
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {return false}
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
            removeItemStorage(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)}
}

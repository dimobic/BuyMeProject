import UIKit

class StorageItemTable: UITableViewController {
    
    var nameGroup : String = ""
    var k = 0
    @objc func CancelButton(){ dismiss(animated: true, completion: nil)}
    
    @objc func AddButton(){
        saveItemsLStorage(groupName: nameGroup, name: "Еда № \(k)")
        k = k + 1
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        DispatchQueue.main.async { 
            loadItemsStorage(nameGroup: self.nameGroup)
            self.tableView.reloadData()
        }
        tableView.allowsSelection = false
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
        cell.nameLabel.text = ItemStorage[indexPath.row].value(forKey: "name") as! String  //+ ItemStorage[indexPath.row].value(forKey: "measure")as! String
        cell.weightLabel.text = String(ItemStorage[indexPath.row].value(forKey: "weight") as! Double)
        return cell
    }

    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = StorageItemTable()
        viewController.nameGroup = Groups[indexPath.row].value(forKey: "nameGroup") as! String
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.modalPresentationStyle = .fullScreen
        navigation.modalTransitionStyle = .crossDissolve
        self.present(navigation, animated: true, completion: nil)
    }*/
    
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

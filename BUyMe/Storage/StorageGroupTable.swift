
import UIKit

class StorageTableViewController: UITableViewController {

    @objc func CancelButton(){ dismiss(animated: true, completion: nil)}
    @objc func AddButton(){
         let alert = UIAlertController(title: "Новый элемент", message: "", preferredStyle: .alert)
        alert.addTextField { (textfield1) in textfield1.placeholder = "Введите навание"
            textfield1.autocorrectionType = .default
            textfield1.autocapitalizationType = .sentences}
         let alertaction = UIAlertAction(title: "Добавить", style: .default) { (alertaction) in
             if let name = alert.textFields![0].text{
                saveItemsStorageGroup(nameGroup: name, icon: nil)
                self.tableView.reloadData()}
         }
         let aletactoin2 = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
         alert.addAction(alertaction)
         alert.addAction(aletactoin2)
         present(alert,animated: true,completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        //setupTable()
        DispatchQueue.main.async {
            loadItemsStorageGroup()
            self.tableView.reloadData()
        }
        navigationItem.title = "Список категорий"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(CancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddButton))
      }

    
    //----------------------//
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell" )
        let item = Groups[indexPath.row]
        cell.textLabel?.text = item.value(forKey: "nameGroup") as? String
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = StorageItemTable()
        viewController.nameGroup = Groups[indexPath.row].value(forKey: "nameGroup") as! String
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.modalPresentationStyle = .fullScreen
        navigation.modalTransitionStyle = .crossDissolve
        self.present(navigation, animated: true, completion: nil)
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
        if indexPath.row != ItemsList.count{
            removeItemStorageGroup(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)}}
}

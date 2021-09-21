
import UIKit
import CoreData



class ScalesTableViewController: UITableViewController, UITextFieldDelegate, DeleteDelegate{
    func delAll(_controller: ScalesCellDelete) {
        self.tableView.reloadData()
    }
    @objc func CancelButton(){
        dismiss(animated: true, completion: nil)
    }
   @objc func AddButton(){
        let alert = UIAlertController(title: "Новый элемент", message: "", preferredStyle: .alert)
        alert.addTextField { (textfield1) in textfield1.placeholder = "Введите цену" }
        alert.addTextField { (textfield2) in textfield2.placeholder = "Введите вес" }
        let alertaction = UIAlertAction(title: "Добавить", style: .default) { (alertaction) in
            if alert.textFields![0].text != nil, alert.textFields![1].text != nil{
                if let price = Double(alert.textFields![0].text!), let weight = Double(alert.textFields![1].text!){
                        saveScalesItems( price, weight)
                        self.tableView.reloadData() }
            }
        }
        let aletactoin2 = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(alertaction)
        alert.addAction(aletactoin2)
        present(alert,animated: true,completion: nil)
    }
    override func loadView() {
        super.loadView()
        tableView.allowsSelection = false 
        DispatchQueue.main.async {
            loadScalesItems()
            self.tableView.reloadData()
        }
        view.backgroundColor = .white
        navigationItem.title = "Сравнение цен"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(CancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddButton))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ScalesCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ScalesCellDelete.self, forCellReuseIdentifier: "cellDel")
        tableView.register(ScalesLabel.self, forCellReuseIdentifier: "cellLebel")

        tableView.dataSource = self
        tableView.delegate = self
      }
    /*func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("12345")
        if textField.text == "" {
        /*if textFields![0].text != nil, alert.textFields![1].text != nil{
            if let price = Double(alert.textFields![0].text!), let weight = Double(alert.textFields![1].text!){
                    saveScalesItems( price, weight)
                    self.tableView.reloadData() }
        }*/
        }
        return true
    }*/
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
        return.none
        } else{
            return .delete
        }
    }
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    {
        return "Удалить"
    }
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        removeItem(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Items.count + 2
        }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == Items.count + 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellDel", for: indexPath) as! ScalesCellDelete
            cell.delegate = self
            return cell
        } else if (indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellLebel", for: indexPath) as! ScalesLabel
            cell.LabelPrice.text = "Цена"
            cell.LabelWeight.text = "Вес"
            cell.LabelAvaragePrice.text = "Вес / Цена"
            //cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ScalesCell
            cell.index = indexPath.row
            let item = Items[indexPath.row - 1]
            cell.TextPrice.text = String(item.value(forKey: "price") as! Double)
            cell.TextWeight.text = String(item.value(forKey: "weight") as! Double)
            cell.TextAvaragePrice.text = String(item.value(forKey: "averagePrice") as! Double)
            //cell.selectionStyle = .none
            return cell
        }
    }
}


import UIKit
import CoreData

class ScalesTableViewController: UITableViewController{
    
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
        DispatchQueue.main.async {
            loadScalesItems()
            self.tableView.reloadData()
        }
        view.backgroundColor = .white
        navigationItem.title = "Сравнение цен"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(CancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddButton))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        //tableView.delegate = self
      }

     override   func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        }
            
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Items.count
        }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = Items[indexPath.row]
        cell.textLabel?.text = String(item.value(forKey: "price") as! Double)
        cell.detailTextLabel?.text = String(item.value(forKey: "weight") as! Double)

        return cell
        }
}

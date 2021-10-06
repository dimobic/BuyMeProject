
import UIKit
import CoreData

protocol ReloadDelegateScale : AnyObject {
   func reloadAll()
}

class ScalesViewController: UIViewController, UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource, ReloadDelegateScale{
    func reloadAll() {
        self.tableView.reloadData()
    }
    
    func Label (_ field : UILabel)-> UILabel{
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 17)
        field.textAlignment = .center
        field.clipsToBounds = true
        return field
    }
    
    var tableView = UITableView()
    lazy var LabelPrice : UILabel = {
        let field = UILabel()
        field.text = "Цена"
        return Label(field)
    }()
    lazy var LabelWeight : UILabel = {
        let field = UILabel()
        field.text = "Вес"
        return Label(field)
    }()
    lazy var LabelAvaragePrice : UILabel =  {
        let field = UILabel()
        field.text = "Цена/Вес"
        return Label(field)
    }()
    
    @objc func CancelButton(){
        dismiss(animated: true, completion: nil)
    }
   @objc func AddButton(){
        let alert = UIAlertController(title: "Новый элемент", message: "", preferredStyle: .alert)
       alert.addTextField { (textfield1) in textfield1.placeholder = "Введите цену"; textfield1.keyboardType = .decimalPad}
       alert.addTextField { (textfield2) in textfield2.placeholder = "Введите вес"; textfield2.keyboardType = .decimalPad}
        let alertaction = UIAlertAction(title: "Добавить", style: .default) { (alertaction) in
            if let price = textToDouble(alert.textFields![0].text), let weight = textToDouble(alert.textFields![1].text){
                    saveItemsScales( price, weight)
                    self.tableView.reloadData() }
        }
        let aletactoin2 = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(alertaction)
        alert.addAction(aletactoin2)
        present(alert,animated: true,completion: nil)
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTable()
        DispatchQueue.main.async {
            loadItemsScales()
            self.tableView.reloadData()
        }
        navigationItem.title = "Сравнение цен"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(CancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddButton))
      }
    
    func setupTable (){
        view.addSubview(tableView)
        view.addSubview(LabelPrice)
        view.addSubview(LabelWeight)
        view.addSubview(LabelAvaragePrice)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        LabelPrice.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        LabelPrice.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        LabelPrice.heightAnchor.constraint(equalToConstant: 50).isActive = true
        LabelPrice.widthAnchor.constraint(equalTo: LabelAvaragePrice.widthAnchor).isActive = true
        
        LabelWeight.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        LabelWeight.leftAnchor.constraint(equalTo: LabelPrice.rightAnchor, constant: 10).isActive = true
        LabelWeight.rightAnchor.constraint(equalTo: LabelAvaragePrice.leftAnchor, constant: -10).isActive = true
        LabelWeight.heightAnchor.constraint(equalToConstant: 50).isActive = true
        LabelWeight.widthAnchor.constraint(equalTo: LabelAvaragePrice.widthAnchor).isActive = true
        
        LabelAvaragePrice.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        LabelAvaragePrice.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        LabelAvaragePrice.heightAnchor.constraint(equalToConstant: 50).isActive = true
        LabelAvaragePrice.widthAnchor.constraint(equalTo: LabelPrice.widthAnchor).isActive = true
        
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ScalesCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ScalesCellDelete.self, forCellReuseIdentifier: "cellDel")
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == ItemsScales.count{
            return .none}
        if tableView.isEditing {
            return.none
        }else{
            return .delete}
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{return "Удалить"}
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {return false}
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if indexPath.row != ItemsScales.count{
        removeItemScales(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)}}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return ItemsScales.count + 1}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == ItemsScales.count) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellDel", for: indexPath) as! ScalesCellDelete
            cell.delegate = self
            cell.typeCell = "Scales"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ScalesCell
            cell.index = indexPath.row
            cell.delegate = self
            let item = ItemsScales[indexPath.row]
            cell.TextPrice.text = String(item.value(forKey: "price") as! Double)
            cell.TextWeight.text = String(item.value(forKey: "weight") as! Double)
            cell.TextAvaragePrice.text = String(item.value(forKey: "averagePrice") as! Double)
            return cell
        }
    }
}

//
//  ListTableViewController.swift
//  BuyMe
//
//  Created by Dima Chirukhin on 19.08.2021.
//

import UIKit


protocol ReloadDelegateList : AnyObject {
   func reloadAll()
}

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ReloadDelegateList {
    
    func reloadAll() { self.tableView.reloadData() }
    var tableView = UITableView()
    
    func Label (_ field : UILabel)-> UILabel{
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 20)
        field.textAlignment = .left
        field.clipsToBounds = true
        return field
    }
    lazy var LabelItog : UILabel = {
        let field = UILabel()
        field.text = "Итого: "
        return Label(field)
    }()
    lazy var LabelPrice : UILabel = {
        let field = UILabel()
        return Label(field)
    }()
    
    @objc func CancelButton(){ dismiss(animated: true, completion: nil)}
    @objc func AddButton(){
         let alert = UIAlertController(title: "Новый элемент", message: "", preferredStyle: .alert)
        alert.addTextField { (textfield1) in textfield1.placeholder = "Введите навание"
            textfield1.autocorrectionType = .default
            textfield1.autocapitalizationType = .sentences}
        alert.addTextField { (textfield2) in textfield2.placeholder = "Введите цену (при наличии)"; textfield2.keyboardType = .decimalPad}
         let alertaction = UIAlertAction(title: "Добавить", style: .default) { (alertaction) in
             if let name = alert.textFields![0].text{
                 if let price = textToDouble(alert.textFields![1].text!){
                     saveItemsList(name: name, price: price, done: true)
                     self.LabelPrice.text = String(ListSum())
                     self.tableView.reloadData()
                 }else{
                 saveItemsList(name: name)
                 self.LabelPrice.text = String(ListSum())
                 self.tableView.reloadData() }
             }
         }
         let aletactoin2 = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
         alert.addAction(alertaction)
         alert.addAction(aletactoin2)
         present(alert,animated: true,completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTable()
        DispatchQueue.main.async {
            loadItemsList()
            self.LabelPrice.text = String(ListSum())
            self.tableView.reloadData()
        }
        navigationItem.title = "Список покупок"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(CancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddButton))
      }

    func setupTable (){
        view.addSubview(tableView)
        view.addSubview(LabelItog)
        view.addSubview(LabelPrice)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        LabelPrice.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        LabelPrice.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        LabelPrice.heightAnchor.constraint(equalToConstant: 50).isActive = true
        LabelPrice.widthAnchor.constraint(equalTo: LabelItog.widthAnchor).isActive = true
        LabelPrice.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        LabelPrice.leftAnchor.constraint(equalTo: LabelItog.rightAnchor, constant: -10).isActive = true
        
        LabelItog.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        LabelItog.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        LabelItog.heightAnchor.constraint(equalToConstant: 50).isActive = true
        LabelItog.widthAnchor.constraint(equalTo: LabelPrice.widthAnchor).isActive = true
        LabelItog.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ScalesCellDelete.self, forCellReuseIdentifier: "cellDel")
    }

    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == ItemsList.count{
            return .none}
        if tableView.isEditing {
            return.none
        }else{
            return .delete}
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
        if indexPath.row == ItemsList.count{
            return "Не Трогай"
        }else{
            return "Удалить"}
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {return false}
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if indexPath.row != ItemsList.count{
        removeItemList(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)}}
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return ItemsList.count + 1}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        if ItemsList[indexPath.row].value(forKey: "done") as! Bool == false{
            let alert1 = UIAlertController(title: "Сколько стоило?", message: "", preferredStyle: .alert)
            alert1.addTextField { (textfield) in textfield.placeholder = "Введите цену"; textfield.keyboardType = .decimalPad}
            let alertaction = UIAlertAction(title: "Готово", style: .default) { (alertaction) in
                if alert1.textFields![0].text! != "" {
                    if  let price = textToDouble(alert1.textFields![0].text!){
                        repairItemList(at: indexPath.row, price: price, true)
                        self.LabelPrice.text = String(ListSum())
                        tableView.reloadData()}
                }else{
                    repairItemList(at: indexPath.row, price: 0.0, true)
                    self.LabelPrice.text = String(ListSum())
                    tableView.reloadData() }
            }
            /*let aletactoin2 = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)*/
            let aletactoin2 = UIAlertAction(title: "Отмена", style: .default, handler: { (UIAlertAction) in
                repairItemList(at: indexPath.row, price: 0.0, true)
                self.LabelPrice.text = String(ListSum())
                tableView.reloadData()})
            alert1.addAction(alertaction)
            alert1.addAction(aletactoin2)
            present(alert1,animated: true,completion: nil)
        }else {
            repairItemList(at: indexPath.row, price: 0.0, false)}
            LabelPrice.text = String(ListSum())
            tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == ItemsList.count) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellDel", for: indexPath) as! ScalesCellDelete
            cell.typeCell = "List"
            cell.delegate2 = self
            return cell
        }else{
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell" )
            //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            //cell.index = indexPath.row
            //cell.delegate = self
            let item = ItemsList[indexPath.row]
            cell.textLabel?.text = String(item.value(forKey: "name") as! String)
            if  String((item.value(forKey: "price") as! Double)) != "0.0" {
                cell.detailTextLabel?.text = String((item.value(forKey: "price") as! Double)) }
            if item.value(forKey: "done") as! Bool {
                cell.imageView?.image = .checkmark
            } else{
                cell.imageView?.image = .none
            }
            return cell
        }
    }
}

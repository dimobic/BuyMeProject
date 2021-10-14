import UIKit
import CoreData

class StorageAddTable: UITableViewController, EditTextProtocol, UITextFieldDelegate{
    
    func nameEdit(text : String?) {
        if text != nil , text!.trimmingCharacters(in: .whitespaces) != "" {
            navigationItem.rightBarButtonItem?.isEnabled = true
            //print("true")
        }else{
            navigationItem.rightBarButtonItem?.isEnabled = false
            //print("false")
        }
    }
    
    
    var nameItem: NSManagedObject? = nil
    var group : String = ""
    var index : Int  = -1
    weak var delegate :  StorageNewElementProtocol?
    
    @objc func CancelButton(){
        self.navigationController?.popViewController(animated: true)
        delegate?.cancelTapButton( )}
    
    @objc func AddButton(){
        if nameItem == nil{
            var cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))  as! StorageAddCell
            let name = cell.textName.text!
            print(name)
            let weight = cell.textWeight.text
            cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0))  as! StorageAddCell
            let plus = cell.textName.text
            let minus = cell.textWeight.text
            let cellM = tableView.cellForRow(at: IndexPath(row: 2, section: 0))  as! StorageItemCellMeasure
            let measure = cellM.Segment.selectedSegmentIndex
            print(measure)
            delegate?.doneAddTapButton(groupName: group, name: name, weight: weight, plus: plus, minus: minus, measure: measure)
        }else{
            var cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))  as! StorageAddCell
            let name = cell.textName.text!
            let weight = cell.textWeight.text
            cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0))  as! StorageAddCell
            let plus = cell.textName.text
            let minus = cell.textWeight.text
            let cellM = tableView.cellForRow(at: IndexPath(row: 2, section: 0))  as! StorageItemCellMeasure
            let measure = cellM.Segment.selectedSegmentIndex
            print(measure)
            delegate?.doneEditTapButton(index: index, groupName: group, name: name, weight: weight, plus: plus, minus: minus, measure: measure)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        tableView.allowsSelection = false
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(CancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(AddButton))
        if nameItem != nil{
            navigationItem.title = (nameItem?.value(forKey: "name") as! String)
        }else{
            navigationItem.title = "Новый элемент"
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        tableView.register(StorageAddCell.self, forCellReuseIdentifier: "cell")
        tableView.register(StorageItemCellMeasure.self, forCellReuseIdentifier: "cellM")
        
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: IndexPath.init(row: 0, section: 0)) as! StorageAddCell
        cell.textName.delegate = self
        cell.textName.becomeFirstResponder()*/
    }
//-----------------------------------//
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellM", for: indexPath) as! StorageItemCellMeasure
            if nameItem == nil{
                cell.Segment.selectedSegmentIndex = 0
            }else{
                switch (nameItem?.value(forKey: "measure") as! Int){
                case 0:
                    cell.Segment.selectedSegmentIndex = 0
                case 1:
                    cell.Segment.selectedSegmentIndex = 1
                case 2:
                    cell.Segment.selectedSegmentIndex = 2
                case 3:
                    cell.Segment.selectedSegmentIndex = 3
                case 4:
                    cell.Segment.selectedSegmentIndex = 4
                default:
                    break
                }
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StorageAddCell
            cell.delegete = self
            if nameItem == nil{
                switch indexPath.row{
                case 0:
                    cell.index = 0
                    cell.nameLabel.text = "Имя:"
                    cell.textName.placeholder = "Введите имя"
                    cell.weightLabel.text = "Вес:"
                    cell.textWeight.placeholder = "Введите вес"
                case 1:
                    cell.index = 1
                    cell.nameLabel.text = "Увеличивать на:"
                    cell.textName.placeholder = "Сколько единиц"
                    cell.weightLabel.text = "Уменьшать на:"
                    cell.textWeight.placeholder = "Сколько единиц"
                default:
                    break
                }
            }else{
                switch indexPath.row{
                case 0:
                    cell.index = 0
                    cell.nameLabel.text = "Имя:"
                    cell.textName.text = (nameItem?.value(forKey: "name") as! String)
                    cell.weightLabel.text = "Вес:"
                    cell.textWeight.text = String((nameItem?.value(forKey: "weight") as! Double))
                case 1:
                    cell.index = 1
                    cell.nameLabel.text = "Увеличивать на:"
                    cell.textName.text = String((nameItem?.value(forKey: "plus") as! Double))
                    cell.weightLabel.text = "Уменьшать на:"
                    cell.textWeight.text = String((nameItem?.value(forKey: "minus") as! Double))
                default:
                    break
                }
            }
            return cell
        }
    }
}


//
//  ScalesCell.swift
//  BuyMe
//
//  Created by Dima Chirukhin on 19.08.2021.
//

import UIKit

class ScalesCell: UITableViewCell, UITextFieldDelegate {
    
    weak var delegate :  ReloadDelegateScale?
    var index : Int = 0
    
    func SetDoneToolbar(field:UITextField) {
        let doneToolbar:UIToolbar = UIToolbar()
        doneToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissKeyboard))
        ]
        doneToolbar.sizeToFit()
        field.inputAccessoryView = doneToolbar
    }
    @objc func dismissKeyboard(){
        TextPrice.endEditing(true)
        TextWeight.endEditing(true)
        delegate?.reloadAll()
    }
    
    func text (_ field : UITextField)-> UITextField{
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 17)
        field.returnKeyType = .done
        field.autocapitalizationType = .sentences
        field.backgroundColor = .systemGray6
        field.textAlignment = .center
        field.borderStyle = .roundedRect
        field.clipsToBounds = true
        field.autocorrectionType = .no
        field.enablesReturnKeyAutomatically = true
        field.keyboardType = .decimalPad
        return field
    }
    lazy var TextPrice : UITextField = {
         let field = UITextField()
        field.addTarget(self, action: #selector(TextPriceFieldDidGange), for: .editingChanged)
         return text(field)
     }()
    lazy var TextWeight : UITextField = {
        let field = UITextField()
        field.addTarget(self, action: #selector(TextWeightFieldDidGange), for: .editingChanged)
        return text(field)
     }()
    lazy var TextAvaragePrice : UILabel = {
        let field = UILabel()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 17)
        field.textAlignment = .center
        field.clipsToBounds = true
        return field
     }()
    
    @objc func TextPriceFieldDidGange(){
        if let text = textToDouble(TextPrice.text){
            repairItemScales(at: index, price: text)
        }
    }

    @objc func TextWeightFieldDidGange(){
        if let text = textToDouble(TextWeight.text){
            repairItemScales(at: index, weight: text)
        }
    }
      
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        SetDoneToolbar(field: TextPrice)
        SetDoneToolbar(field: TextWeight)
        initConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override func setSelected(_ selected: Bool, animated: Bool) { super.setSelected(selected, animated: animated) }
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        delegate?.reloadAll()
        return true
    }
    
    func initConstraints(){
        self.contentView.addSubview(TextPrice)
        self.contentView.addSubview(TextWeight)
        self.contentView.addSubview(TextAvaragePrice)
        
        TextPrice.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        TextPrice.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        TextPrice.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 9/10, constant: -20).isActive = true
        TextPrice.widthAnchor.constraint(equalTo: self.TextAvaragePrice.widthAnchor).isActive = true

        TextWeight.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        TextWeight.leftAnchor.constraint(equalTo: self.TextPrice.rightAnchor, constant: 10).isActive = true
        TextWeight.rightAnchor.constraint(equalTo: self.TextAvaragePrice.leftAnchor, constant: -10).isActive = true
        TextWeight.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 9/10,  constant: -20).isActive = true
        TextWeight.widthAnchor.constraint(equalTo: self.TextAvaragePrice.widthAnchor).isActive = true

        TextAvaragePrice.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        TextAvaragePrice.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        TextAvaragePrice.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 9/10 ,  constant: -20).isActive = true
        TextAvaragePrice.widthAnchor.constraint(equalTo: self.TextPrice.widthAnchor).isActive = true
        
        TextWeight.delegate = self
    }
}

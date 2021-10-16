//
//  StorageAddCell.swift
//  BuyMe
//
//  Created by Dima Chirukhin on 19.08.2021.
//

protocol EditTextProtocol : AnyObject {
    func nameEdit(text:String?)
}

import UIKit

class StorageAddCell: UITableViewCell {
    
    var index : Int = -1
    weak var delegete : EditTextProtocol?
    
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
        return field
    }
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    lazy var weightLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()

    lazy var textName : UITextField = {
         let field = UITextField()
        field.addTarget(self, action: #selector(TextFieldDidGange), for: .editingChanged)
         return text(field)
     }()
    lazy var textWeight : UITextField = {
        let field = UITextField()
        return text(field)
     }()
       
   @objc func TextFieldDidGange(){
       if index == 0 { delegete?.nameEdit(text: textName.text)}
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initConstraints()}
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override func setSelected(_ selected: Bool, animated: Bool) { super.setSelected(selected, animated: animated) }
    
    
    func initConstraints(){
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(weightLabel)
        self.contentView.addSubview(textName)
        self.contentView.addSubview(textWeight)
        
        nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.weightLabel.widthAnchor).isActive = true

        weightLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10).isActive = true
        weightLabel.leftAnchor.constraint(equalTo: self.nameLabel.rightAnchor, constant: 10).isActive = true
        weightLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        weightLabel.widthAnchor.constraint(equalTo: self.nameLabel.widthAnchor).isActive = true

        textName.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor,constant: 10).isActive = true
        textName.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -10).isActive = true
        textName.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        textName.rightAnchor.constraint(equalTo: self.textWeight.leftAnchor, constant: -10).isActive = true
        textName.widthAnchor.constraint(equalTo: self.nameLabel.widthAnchor).isActive = true
        
        textWeight.topAnchor.constraint(equalTo: self.weightLabel.bottomAnchor,constant: 10).isActive = true
        textWeight.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -10).isActive = true
        textWeight.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        textWeight.widthAnchor.constraint(equalTo: self.nameLabel.widthAnchor).isActive = true
        
    }
}

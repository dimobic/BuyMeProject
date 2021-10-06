//
//  StorageItemCell.swift
//  BuyMe
//
//  Created by Dima Chirukhin on 19.08.2021.
//

import UIKit

class StorageItemCell: UITableViewCell {

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
    lazy var plusMinus : UIStepper = {
       let step = UIStepper()
        step.translatesAutoresizingMaskIntoConstraints = false
        return step
    }()
       
    override func awakeFromNib() {
        super.awakeFromNib()}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initConstraints()}
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override func setSelected(_ selected: Bool, animated: Bool) { super.setSelected(selected, animated: animated) }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        return true
    }
    
    func initConstraints(){
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(weightLabel)
        self.contentView.addSubview(plusMinus)
        
        nameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, constant: -20).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.weightLabel.widthAnchor).isActive = true

        weightLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        weightLabel.leftAnchor.constraint(equalTo: self.nameLabel.rightAnchor, constant: 10).isActive = true
        weightLabel.rightAnchor.constraint(equalTo: self.plusMinus.leftAnchor, constant: -10).isActive = true
        weightLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor,constant: -20).isActive = true
        weightLabel.widthAnchor.constraint(equalTo: self.nameLabel.widthAnchor).isActive = true

        plusMinus.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        plusMinus.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        plusMinus.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, constant: -20).isActive = true
        plusMinus.widthAnchor.constraint(equalTo: self.nameLabel.widthAnchor).isActive = true
        
    }
}

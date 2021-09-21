//
//  ScalesLabel.swift
//  BuyMe
//
//  Created by Dima Chirukhin on 18.09.2021.
//

import UIKit

class ScalesLabel: UITableViewCell {
       
    func Label (_ field : UILabel)-> UILabel{
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 17)
        field.backgroundColor = .white
        field.textAlignment = .center
        field.clipsToBounds = true
        return field
    }
    lazy var LabelPrice : UILabel = {
        let field = UILabel()
        return Label(field)
    }()
    lazy var LabelWeight : UILabel = {
        let field = UILabel()
        return Label(field)
    }()
    lazy var LabelAvaragePrice : UILabel =  {
        let field = UILabel()
        return Label(field)
    }()
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
        
    func initConstraints(){
        self.contentView.addSubview(LabelPrice)
        self.contentView.addSubview(LabelWeight)
        self.contentView.addSubview(LabelAvaragePrice)

        LabelPrice.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        LabelPrice.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        LabelPrice.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 9/10).isActive = true
        LabelPrice.widthAnchor.constraint(equalTo: self.LabelAvaragePrice.widthAnchor).isActive = true
        
        LabelWeight.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        LabelWeight.leftAnchor.constraint(equalTo: self.LabelPrice.rightAnchor, constant: 10).isActive = true
        LabelWeight.rightAnchor.constraint(equalTo: self.LabelAvaragePrice.leftAnchor, constant: -10).isActive = true
        LabelWeight.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 9/10).isActive = true
        LabelWeight.widthAnchor.constraint(equalTo: self.LabelAvaragePrice.widthAnchor).isActive = true
        
        LabelAvaragePrice.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        LabelAvaragePrice.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        LabelAvaragePrice.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 9/10).isActive = true
        LabelAvaragePrice.widthAnchor.constraint(equalTo: self.LabelPrice.widthAnchor).isActive = true
            
        //TextEnter.delegate = self
    }
}

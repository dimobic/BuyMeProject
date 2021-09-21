//
//  ScalesCellDelete.swift
//  BuyMe
//
//  Created by Dima Chirukhin on 18.09.2021.
//


import UIKit

protocol DeleteDelegate : AnyObject {
    func delAll( _controller: ScalesCellDelete)
}

class ScalesCellDelete: UITableViewCell {
    
    weak var delegate :  DeleteDelegate?

    lazy var DeleteButton: UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Удалить всё", for: .normal)
        Button.backgroundColor = .red
        Button.imageView?.contentMode = .scaleAspectFit
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.layer.cornerRadius = 10
        Button.layer.borderWidth = 2
        Button.setTitleColor(.black, for: .normal)
        Button.addTarget(self, action: #selector(DeleteButtonTouchUpInside), for: .touchUpInside)
        return Button
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
   
    @objc func DeleteButtonTouchUpInside(){
        removeItem(at: -1)
        delegate?.delAll(_controller: self)
            
    }
    
    func initConstraints(){
        self.contentView.addSubview(DeleteButton)
        DeleteButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        DeleteButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        DeleteButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        DeleteButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        DeleteButton.widthAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 9/10).isActive = true
    }
}

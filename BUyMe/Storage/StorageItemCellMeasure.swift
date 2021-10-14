//
//  StorageItemCellMeasure.swift
//  BuyMe
//
//  Created by Dima Chirukhin on 07.10.2021.
//

import UIKit

class StorageItemCellMeasure: UITableViewCell {

    lazy var Segment : UISegmentedControl = {
        let segment  = UISegmentedControl(items: ["Кг","г","Л","мл","Уп."])
        //segment.addTarget(self, action: #selector(selectSegment), for: .allEvents)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initConstraints()}
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override func setSelected(_ selected: Bool, animated: Bool) { super.setSelected(selected, animated: animated) }
    
    
    
    func initConstraints(){
        self.contentView.addSubview(Segment)
        
        Segment.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        Segment.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        Segment.widthAnchor.constraint(equalTo: self.contentView.widthAnchor,constant: -20).isActive = true
        Segment.heightAnchor.constraint(equalTo: self.contentView.heightAnchor,multiplier: 1/2).isActive = true
    }
}

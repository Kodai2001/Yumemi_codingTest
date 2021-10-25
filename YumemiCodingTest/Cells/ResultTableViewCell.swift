//
//  ResultTableViewCell.swift
//  YumemiCodingTest
//
//  Created by system on 2021/10/25.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    static let identifier = "ResultTableViewCell"
    
    let label: UILabel = {
       let label = UILabel()
        label.text = "Title"
        label.tintColor = .secondaryLabel
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 25, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
    
}

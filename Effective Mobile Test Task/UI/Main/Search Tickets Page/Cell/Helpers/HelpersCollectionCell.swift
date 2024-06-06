//
//  HelpersCollectionCell.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 03.06.24.
//

import UIKit

class HelpersCollectionCell: CollectionViewCell {
//    MARK: Views
    @IBOutlet private var image: UIImageView!
    @IBOutlet private var backView: UIView!
    @IBOutlet private var titleLabel: UILabel!

//    MARK: Properties
    static let height: CGFloat = 90
}

//    MARK: setupUI
extension HelpersCollectionCell {
    override func setupUI() {
        backView.layer.cornerRadius = 10
    }
}

//    MARK: setData
extension HelpersCollectionCell {
    func setData(_ item: Helpers) {
        image.image = item.image
        titleLabel.text = item.title
        backView.backgroundColor = item.color
    }
}

//
//  CollectionViewCell.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 31.05.24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultStartup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        defaultStartup()
    }
}

extension CollectionViewCell {
    private func defaultStartup() {
        contentView.backgroundColor = .clear
        setupUI()
        startup()
        setupBinding()
    }

    @objc func setupUI() {}
    @objc func startup() {}
    @objc func setupBinding() {}
}

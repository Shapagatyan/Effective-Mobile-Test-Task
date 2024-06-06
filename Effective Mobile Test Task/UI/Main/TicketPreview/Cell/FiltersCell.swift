//
//  FiltersCell.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 05.06.24.
//

import UIKit

protocol FiltersCellDelegate: NSObjectProtocol {
    func filtersCellReturnDateChanged(to date: Date)
}

class FiltersCell: CollectionViewCell {
    // MARK: Views
    @IBOutlet private var title: UILabel!
    @IBOutlet private var icon: UIImageView!
    @IBOutlet private var datePicker: UIDatePicker!

    // MARK: Properties
    let calendar = Calendar(identifier: .gregorian)

    weak var delegate: FiltersCellDelegate?

    // MARK: layout Subviews
    override func layoutSubviews() {
        contentView.layer.cornerRadius = 15
        datePicker.layer.cornerRadius = 15
        datePicker.datePickerMode = .date
    }
}

// MARK: SetupUI
extension FiltersCell {
    override func setupUI() {
        contentView.backgroundColor = .appGrey2
        datePicker.tintColor = .appText
        datePicker.tintColorDidChange()
        datePicker.isSelected = true
        datePicker.addTarget(self, action: #selector(pickerAction(_:)), for: .primaryActionTriggered)
    }

    @objc func pickerAction(_ sender: UIDatePicker) {
        delegate?.filtersCellReturnDateChanged(to: sender.date)
    }
}

extension FiltersCell {
    func setData(_ item: Filters) {
        title.text = item.title

        switch item {
        case .returnDate:
            icon.hideFromStack = true
            title.hideFromStack = true
            datePicker.hideFromStack = false
        default:
            datePicker.hideFromStack = true
            title.hideFromStack = false
            icon.hideFromStack = false
            icon.image = item.image
        }
    }
}

//
//  MusicalCell.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 31.05.24.
//

import UIKit

class MusicalCell: CollectionViewCell {
    // MARK: Views
    @IBOutlet private var townLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var smallImageView: UIImageView!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
}

// MARK: Set Data
extension MusicalCell {
    func setData(_ offer: Offer) {
        townLabel.text = offer.town
        titleLabel.text = offer.title
        imageView.image = UIImage(named: offer.imageName)
        priceLabel.text = "от \(offer.price.value.string) ₽"
        smallImageView.image = UIImage(named: "AviaTicketsIcon")
    }
}

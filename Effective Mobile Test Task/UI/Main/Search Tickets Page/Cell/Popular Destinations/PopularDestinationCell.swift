//
//  PopularDestinationCell.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 02.06.24.
//

import UIKit

class PopularDestinationCell: CollectionViewCell {
    // MARK: Views
    @IBOutlet private var image: UIImageView!
    @IBOutlet private var popularDestinationLabel: UILabel!
    @IBOutlet private var titleLAbel: UILabel!

    // MARK: - Properties
    static let height: CGFloat = 84
}

extension PopularDestinationCell {
    override func startup() {
        super.startup()
        contentView.backgroundColor = .appGrey3
    }
}

// MARK: SetData
extension PopularDestinationCell {
    func setdata(_ item: PopularDestinations, location: ProgramCollectionCellLocation) {
        image.image = item.image
        titleLAbel.text = item.title

        switch location {
        case .top:
            roundCorners(radius: 30, corners: [.topLeft, .topRight])
        case .middle:
            roundCorners(radius: 0, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
        case .bottom:
            roundCorners(radius: 30, corners: [.bottomLeft, .bottomRight])
        }
    }
}

// MARK: - Helpers
enum ProgramCollectionCellLocation {
    case top
    case middle
    case bottom
}

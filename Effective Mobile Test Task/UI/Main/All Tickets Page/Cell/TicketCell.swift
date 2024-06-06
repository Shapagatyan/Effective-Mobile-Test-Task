//
//  TicketCell.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 04.06.24.
//

import UIKit

class TicketCell: CollectionViewCell {
    // MARK: Views
    @IBOutlet private var badgeView: UIView!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var ticketsView: UIView!
    @IBOutlet private var flightTime: UILabel!
    @IBOutlet private var badgeLabel: UILabel!
    @IBOutlet private var backgrountView: UIView!
    @IBOutlet private var arrivalAirport: UILabel!
    @IBOutlet private var departureAirport: UILabel!
    @IBOutlet private var arrivalDateLabel: UILabel!
    @IBOutlet private var departureDateLabel: UILabel!
}

extension TicketCell {
    override func setupUI() {
        super.setupUI()
    }

    override func layoutSubviews() {
        badgeLabel.layer.masksToBounds = true
        backgrountView.layer.cornerRadius = 20
        badgeLabel.layer.cornerRadius = badgeLabel.frame.height / 2
        ticketsView.layer.cornerRadius = ticketsView.frame.height / 2
    }
}

extension TicketCell {
    func setData(_ item: Ticket) {
        priceLabel.text = "\(item.price.value.string) ₽"
        arrivalAirport.text = item.arrival.airport.rawValue
        departureAirport.text = item.departure.airport.rawValue
        guard let departureDate = item.departure.date.getDate(),
              let arrivalDate = item.arrival.date.getDate() else { return }
        arrivalDateLabel.text = arrivalDate.string(format: "HH:mm")
        departureDateLabel.text = departureDate.string(format: "HH:mm")

        var duration: Double {
            return Double(arrivalDate.timeIntervalSince1970 - departureDate.timeIntervalSince1970)
        }

        if item.hasTransfer {
            flightTime.text = "\(duration.timeString) ч в пути"
        } else {
            flightTime.text = "\(duration.timeString) ч в пути / Без пересадок"
        }

        if let badge = item.badge {
            badgeLabel.text = item.badge
            badgeLabel.hideFromStack = false
        } else {
            badgeLabel.hideFromStack = true
        }
    }
}

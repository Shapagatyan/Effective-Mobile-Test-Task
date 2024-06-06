//
//  TicketPreviewView.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 05.06.24.
//

import UIKit

class TicketPreviewView: UIView {
    // MARK: Views
    @IBOutlet private var title: UILabel!
    @IBOutlet private var price: UIButton!
    @IBOutlet private var ticketView: UIView!
    @IBOutlet private var flightTimesLAbel: UILabel!
}

// MARK: layout Subviews
extension TicketPreviewView {
    override func layoutSubviews() {
        ticketView.layer.cornerRadius = ticketView.frame.height / 2
    }
}

// MARK: SetData
extension TicketPreviewView {
    func setData(_ item: TicketsOffer) {
        title.text = item.title
        ticketView.backgroundColor = item.color
        price.setTitle("\(item.price.value.string) ₽", for: .normal)
        flightTimesLAbel.text = item.timeRange.joined(separator: ", ")
    }
}

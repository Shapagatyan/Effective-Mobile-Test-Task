//
//  SearchTicketsHeader.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 02.06.24.
//

import Combine
import UIKit

protocol SearchTicketsHeaderDelegate: NSObjectProtocol {
    func pushViewControllerThenDidEndEditingTextField(arrivalCity: String)
}

class SearchTicketsHeader: UICollectionReusableView {
    //    MARK: - Views
    @IBOutlet private var backgroundView: UIView!
    @IBOutlet private var searchIcon: UIImageView!
    @IBOutlet private var arrivalIcon: UIImageView!
    @IBOutlet private var clearTextButton: UIButton!
    @IBOutlet private var arrivalCityTextField: TextField!
    @IBOutlet private var departureCityTextField: TextField!

    //    MARK: - Properties
    static let height: CGFloat = 100
    var cancellable: Set<AnyCancellable> = []
    weak var delegate: SearchTicketsHeaderDelegate?
    var arrivalCity: String?
}

extension SearchTicketsHeader {
    override func layoutSubviews() {
        backgroundView.layer.cornerRadius = 20
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        defaultStartup()
    }

    func defaultStartup() {
        setupBinding()
        arrivalCityTextField.delegate = self
        departureCityTextField.delegate = self
    }
}

extension SearchTicketsHeader {
    func setupBinding() {
        clearTextButton.subscribe(for: .touchUpInside).sink { [weak self] _ in
            self?.arrivalCityTextField.text = ""
        }.store(in: &cancellable)

        arrivalCityTextField.textPublisher.receive(on: RunLoop.main).sink { [weak self] text in
            guard let self else { return }

            self.arrivalCity = text
        }.store(in: &cancellable)
    }
}

extension SearchTicketsHeader {
    func setData(departureCity: String, arrivalCity: String) {
        departureCityTextField.text = departureCity
        arrivalCityTextField.text = arrivalCity
    }
}

// MARK: UITextField Delegate
extension SearchTicketsHeader: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard textField == departureCityTextField else { return true }
        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard
            textField == arrivalCityTextField,
            let city = textField.text,
            !city.isEmpty
        else { return }

        delegate?.pushViewControllerThenDidEndEditingTextField(arrivalCity: arrivalCity ?? "")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let cyrillicPattern = "[ЁёА-я, ,-]"
        let regex = try! NSRegularExpression(pattern: cyrillicPattern)
        let range = NSRange(location: 0, length: string.utf16.count)
        let matches = regex.matches(in: string, options: [], range: range)
        return string.isEmpty || matches.count == string.utf16.count
    }
}

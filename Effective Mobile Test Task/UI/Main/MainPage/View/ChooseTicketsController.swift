//
//  ChooseTicketsController.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 31.05.24.
//

import UIKit

class ChooseTicketsController: ViewController {
//    MARK: Views
    @IBOutlet private var searchBarFirstBackView: UIView!
    @IBOutlet private var arrivalCityTextField: TextField!
    @IBOutlet private var searchBarSecondBackView: UIView!
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var departureСityTextField: TextField!

    // MARK: Properties
    private var viewModel = ChooseTicketsViewModel()
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Offer>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Offer>

    // MARK: DataSource
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicalCell.name, for: indexPath) as! MusicalCell
            cell.setData(item)
            return cell
        }
        return dataSource
    }()
}

// MARK: Start up
extension ChooseTicketsController {
    override func startup() {
        super.startup()
        viewModel.addOffers()
    }
}

// MARK: Setup UI
extension ChooseTicketsController {
    override func setupUI() {
        super.setupUI()
        setupViews()
        setupCollectionView()
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.registerCell(cell: MusicalCell.self)
    }

    func setupViews() {
        arrivalCityTextField.delegate = self
        departureСityTextField.delegate = self
        searchBarFirstBackView.layer.cornerRadius = 20
        searchBarSecondBackView.layer.cornerRadius = 20
        departureСityTextField.text = UserDefaults.standard.string(forKey: "departure_city") ?? "Минск"
        searchBarSecondBackView.setShadow(opacity: 0.25, x: 0, y: 4, blur: 4)
    }
}

// MARK: Setup Bindings
extension ChooseTicketsController {
    override func setupBindings() {
        super.setupBindings()
        viewModel.$offers.dropFirst().sink { [weak self] models in
            guard let self else { return }
            var snapshot = Snapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(models)
            self.dataSource.apply(snapshot, animatingDifferences: false)

        }.store(in: &cancellable)
    }
}

// MARK: CollectionView Delegate Flow Layout
extension ChooseTicketsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        return CGSize(width: height * 0.6, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 68
    }
}

// MARK: UITextField Delegate
extension ChooseTicketsController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard textField == arrivalCityTextField else { return true }
        let controller = SearchTicketsController(from: departureСityTextField.text ?? "Минск", to: arrivalCityTextField.text ?? " ")
        controller.delegate = self
        present(controller, animated: true)
        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard
            textField == departureСityTextField,
            let city = textField.text,
            !city.isEmpty
        else { return }
        UserDefaults.standard.set(city, forKey: "departure_city")
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

extension ChooseTicketsController: SearchTicketsControllerDelegate {
    func pushTicketPreviewController(from: String, to: String) {
        arrivalCityTextField.text = from
        let controller = TicketPreviewController(from: from, to: to)
        navigationController?.pushViewController(controller, animated: true)
    }
}

enum Section {
    case main
}

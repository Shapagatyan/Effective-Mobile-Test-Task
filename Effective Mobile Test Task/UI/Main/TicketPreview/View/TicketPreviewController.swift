//
//  TicketPreviewController.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 05.06.24.
//

import UIKit

class TicketPreviewController: ViewController {
//     MARK: Views
    @IBOutlet private var cellsView: UIView!
    @IBOutlet private var fromToView: UIView!
    @IBOutlet private var backButton: UIButton!
    @IBOutlet private var subscribeButton: UIView!
    @IBOutlet private var changeIconsButton: UIButton!
    @IBOutlet private var cellsBackgroundView: UIView!
    @IBOutlet private var showAllTicketsButton: UIButton!
    @IBOutlet private var clearTextFieldButton: UIButton!
    @IBOutlet private var arrivalCityTextFied: TextField!
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var departureCityTextField: TextField!
    @IBOutlet private var ticketPreviewSuperview: UIStackView!

    // MARK: Properties
    let arrivalsCity: String
    var departureCity: String

    private let viewModel = TicketPreviewViewModel()
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Filters>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Filters>

    // MARK: DataSource
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FiltersCell.name, for: indexPath) as! FiltersCell
            cell.setData(item)
            cell.delegate = self
            return cell
        }
        return dataSource
    }()

    // MARK: Init
    init(from: String, to: String) {
        self.departureCity = from
        self.arrivalsCity = to
        super.init()
    }

    required init() {
        fatalError("init() has not been implemented")
    }
}

// MARK: Setup UI
extension TicketPreviewController {
    override func setupUI() {
        super.setupUI()
        setData()
        setupViews()
        setupCollectionView()
    }

    func setupViews() {
        arrivalCityTextFied.delegate = self
        departureCityTextField.delegate = self
        cellsView.layer.cornerRadius = 15
        fromToView.layer.cornerRadius = 15
        subscribeButton.layer.cornerRadius = 15
        showAllTicketsButton.layer.cornerRadius = 15
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.registerCell(cell: FiltersCell.self)
    }

    func setData() {
        arrivalCityTextFied.text = arrivalsCity
        departureCityTextField.text = departureCity
    }
}

// MARK: LayoutSubviews
extension TicketPreviewController {
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

//    MARK: Startup
extension TicketPreviewController {
    override func startup() {
        super.startup()
        viewModel.addOffers()
    }
}

//    MARK: SetupBindings
extension TicketPreviewController {
    override func setupBindings() {
        viewModel.$ticketsOffer.receive(on: RunLoop.main).sink { [weak self] models in
            guard let self else { return }
            let models = models.prefix(3)
            ticketPreviewSuperview.arrangedSubviews.forEach { $0.removeFromSuperview() }

            for model in models {
                let view = TicketPreviewView.xibFile
                view.translatesAutoresizingMaskIntoConstraints = false
                ticketPreviewSuperview.addArrangedSubview(view)
                view.setData(model)
                view.heightAnchor.constraint(equalToConstant: 56).isActive = true
            }
        }.store(in: &cancellable)

        viewModel.$filters.sink { [weak self] models in
            guard let self else { return }
            var snapshot = Snapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(models)
            self.dataSource.apply(snapshot, animatingDifferences: false)

        }.store(in: &cancellable)

        clearTextFieldButton.subscribe(for: .touchUpInside).sink { [weak self] _ in
            guard let self else { return }
            self.departureCityTextField.text = ""
            self.departureCity = ""

        }.store(in: &cancellable)

        changeIconsButton.subscribe(for: .touchUpInside).sink { [weak self] _ in
            if self?.arrivalCityTextFied.text == self?.departureCity {
                self?.arrivalCityTextFied.text = self?.arrivalsCity
                self?.departureCityTextField.text = self?.departureCity
            } else {
                self?.arrivalCityTextFied.text = self?.departureCity
                self?.departureCityTextField.text = self?.arrivalsCity
            }

        }.store(in: &cancellable)

        backButton.subscribe(for: .touchUpInside).sink { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }.store(in: &cancellable)

        showAllTicketsButton.subscribe(for: .touchUpInside).sink { [weak self] _ in
            guard let self else { return }
            let controller = AllTicketsController(from: self.departureCity, to: self.arrivalsCity, date: viewModel.returnDate)
            self.navigationController?.pushViewController(controller, animated: true)
        }.store(in: &cancellable)
    }
}

//    MARK: Collection View Delegate
extension TicketPreviewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = viewModel.filters[indexPath.item].title.widthOfString(usingFont: SystemFontType.bold.font.withSize(14)) + 65
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataSource.itemIdentifier(for: indexPath)

        switch item {
        case .returnDate:
            break
        default:
            break
        }
    }
}

// MARK: FiltersCellDelegate
extension TicketPreviewController: FiltersCellDelegate {
    func filtersCellReturnDateChanged(to date: Date) {
        viewModel.changeReturnDate(to: date)
    }
}

// MARK: Actions
extension TicketPreviewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}

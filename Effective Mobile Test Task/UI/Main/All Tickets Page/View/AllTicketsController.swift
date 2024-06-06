//
//  AllTicketsController.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 03.06.24.
//

import UIKit

class AllTicketsController: ViewController {
    // MARK: Views
    @IBOutlet private var headerView: UIView!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var buttonsView: UIView!
    @IBOutlet private var fromToLabel: UILabel!
    @IBOutlet private var backButton: UIButton!
    @IBOutlet private var collectionView: UICollectionView!

    // MARK: Properties
    let arrivalCiy: String
    let departureCity: String
    let returnDate: Date

    private var viewModel = AllTicketsViewModel()
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Ticket>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Ticket>

    // MARK: DataSource
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketCell.name, for: indexPath) as! TicketCell
            cell.setData(item)
            return cell
        }
        return dataSource
    }()

    init(from: String, to: String, date: Date) {
        self.departureCity = from
        self.arrivalCiy = to
        self.returnDate = date
        super.init()
    }

    required init() {
        fatalError("init() has not been implemented")
    }
}

// MARK: Layout Subviews
extension AllTicketsController {
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK: Setup UI
extension AllTicketsController {
    override func startup() {
        super.startup()
        viewModel.addAllTickets()
    }
}

// MARK: Setup UI
extension AllTicketsController {
    override func setupUI() {
        super.setupUI()
        setData()
        setupViews()
        setupCollectionView()
    }

    func setupViews() {
        buttonsView.layer.cornerRadius = buttonsView.frame.height / 2
        headerView.layer.cornerRadius = 4
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.registerCell(cell: TicketCell.self)
    }

    func setData() {
        fromToLabel.text = "\(arrivalCiy) - \(departureCity)"
        dateLabel.text = returnDate.string(format: "dd MMMM yyyy")
    }
}

// MARK: Setup Bindings
extension AllTicketsController {
    override func setupBindings() {
        super.setupBindings()
        viewModel.$tickets.sink { [weak self] models in
            guard let self else { return }
            var snapshot = Snapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(models)
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }.store(in: &cancellable)

        backButton.subscribe(for: .touchUpInside).sink { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }.store(in: &cancellable)
    }
}

// MARK: CollectionView Delegate Flow Layout
extension AllTicketsController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 151)
    }
}

//
//  SearchTicketsController.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 02.06.24.
//

import UIKit

protocol SearchTicketsControllerDelegate: NSObjectProtocol {
    func pushTicketPreviewController(from: String, to: String)
}

class SearchTicketsController: ViewController {
    //    MARK: Views
    @IBOutlet var collectionView: UICollectionView!

    // MARK: Properties
    var arrivalsCity: String
    var departureCity: String
    @IBOutlet var slider: UIView!
    private var viewModel = SearchTicketsViewModel()
    weak var delegate: SearchTicketsControllerDelegate?
    typealias Snapshot = NSDiffableDataSourceSnapshot<SearchTicketsPageSectionModel, SearchTicketsPageModel>
    typealias DataSource = UICollectionViewDiffableDataSource<SearchTicketsPageSectionModel, SearchTicketsPageModel>

    init(from: String, to: String) {
        self.departureCity = from
        self.arrivalsCity = to
        super.init()
    }

    required init() {
        fatalError("init() has not been implemented")
    }

    // MARK: DataSource
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            switch item {
            case .helpers(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HelpersCollectionCell.name, for: indexPath) as! HelpersCollectionCell
                cell.setData(item)
                return cell
            case .popularDestinations(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularDestinationCell.name, for: indexPath) as! PopularDestinationCell
                var items: [PopularDestinations] = []
                var location: ProgramCollectionCellLocation = .middle
                let row = indexPath.row

                if row == 0 {
                    location = .top
                } else if row == 2 {
                    location = .bottom
                }

                cell.setdata(item, location: location)
                return cell
            }
        }

        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchTicketsHeader.name, for: indexPath) as! SearchTicketsHeader
            header.setData(departureCity: self?.departureCity ?? "", arrivalCity: self?.arrivalsCity ?? "")
            header.delegate = self
            return header
        }
        return dataSource
    }()
}

extension SearchTicketsController {
    override func startup() {
        super.startup()
        viewModel.configureData()
    }
}

extension SearchTicketsController {
    override func setupUI() {
        super.setupUI()
        setupViews()
        setupCollectionView()
    }

    func setupViews() {
        view.backgroundColor = .appGrey2
        slider.layer.cornerRadius = 2
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.registerCell(cell: HelpersCollectionCell.self)
        collectionView.registerCell(cell: PopularDestinationCell.self)
        collectionView.registerSectionHeader(view: SearchTicketsHeader.self)
    }
}

extension SearchTicketsController {
    override func setupBindings() {
        super.setupBindings()

        viewModel.$models.dropFirst().delay(for: 0.1, scheduler: RunLoop.main).sink { [weak self] models in
            guard let self else { return }
            var snapshot = Snapshot()
            snapshot.appendSections(models)
            models.forEach { snapshot.appendItems($0.items, toSection: $0) }
            self.dataSource.apply(snapshot)
        }.store(in: &cancellable)
    }
}

// MARK: - Collection layout
extension SearchTicketsController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: 0, height: 0)

        let width = collectionView.safeAreaLayoutGuide.layoutFrame.width - 32
        let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]

        switch section {
        case .helpers:
            let width = (collectionView.frame.width - 48) / 4
            size = CGSize(width: width, height: HelpersCollectionCell.height)
        case .popularDestinations:
            size = CGSize(width: width, height: PopularDestinationCell.height)
        }

        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let section = section
        switch section {
        case 0:
            let width = collectionView.safeAreaLayoutGuide.layoutFrame.width - 32
            return CGSize(width: width, height: SearchTicketsHeader.height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let section = dataSource.snapshot().sectionIdentifiers[section]

        switch section {
        case .popularDestinations:
            return 16
        case .helpers:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
        let model = dataSource.snapshot().itemIdentifiers(inSection: section)[indexPath.row]

        switch model {
        case .helpers(let item):
            switch item {
            case .anywhere:
                arrivalsCity = item.title ?? ""
                let snapshot = dataSource.snapshot()
                dataSource.applySnapshotUsingReloadData(snapshot)
                dismiss(animated: true) {
                    self.delegate?.pushTicketPreviewController(from: self.arrivalsCity, to: self.departureCity)
                }

            default:
                let controller = ViewController()
                present(controller, animated: true)
            }
        case .popularDestinations(let item):
            arrivalsCity = item.title ?? ""
            let snapshot = dataSource.snapshot()
            dataSource.applySnapshotUsingReloadData(snapshot)
            dismiss(animated: true) {
                self.delegate?.pushTicketPreviewController(from: self.arrivalsCity, to: self.departureCity)
            }
        }
    }
}

extension SearchTicketsController: SearchTicketsHeaderDelegate {
    func pushViewControllerThenDidEndEditingTextField(arrivalCity: String) {
        dismiss(animated: true) {
            self.delegate?.pushTicketPreviewController(from: arrivalCity, to: self.departureCity)
        }
    }
}

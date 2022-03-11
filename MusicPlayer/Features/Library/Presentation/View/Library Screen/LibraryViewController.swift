//
//  LibraryViewController.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

import UIKit
import RxSwift

final class LibraryViewController: ViewController {
    
    private lazy var searchController = UISearchController().then {
        $0.obscuresBackgroundDuringPresentation = false
        $0.searchBar.placeholder = "Search Music"
        $0.searchBar.keyboardType = .alphabet
        $0.searchBar.delegate = self
    }
    private lazy var tableView = UITableView().then {
        $0.register(cell: MusicTrackTableViewCell.self)
        $0.separatorStyle = .none
        $0.refreshControl = refreshControl
        $0.dataSource = self
        $0.delegate = self
    }
    private lazy var refreshControl = UIRefreshControl().then {
        $0.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        $0.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
    }
    private lazy var emptyLabel = UILabel().then {
        $0.text = emptyRemoteDataStr
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
        $0.isHidden = true
    }
    
    private let viewModel: LibraryViewModel = Resolver.resolve()
    private let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.syncronizeData()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        observeDataChanged()
        view.showLoadingIndicator()
        viewModel.getTrackList()
    }
    
    private func configureUI() {
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.title = musicLibraryStr
        self.navigationItem.searchController = searchController
        view.backgroundColor = .white
        view.addSubviews(tableView, emptyLabel)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        emptyLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    private func resetSearchData() {
        viewModel.currentSearchPage = 0
        viewModel.searchTrackListModel.trackList.removeAll()
        viewModel.searchTrackListModel.header.available = -1
        tableView.reloadData()
        validateEmptyLabel()
    }
    
    private func resetData() {
        viewModel.currentPage = 0
        viewModel.trackListModel.trackList.removeAll()
        viewModel.trackListModel.header.available = -1
        tableView.reloadData()
        validateEmptyLabel()
    }
    
    private func validateEmptyLabel() {
        if viewModel.isFetchInProgress {
            emptyLabel.isHidden = true
            return
        }
        
        if viewModel.artistKeyword.isEmpty {
            emptyLabel.isHidden = !viewModel.trackListModel.trackList.isEmpty
        } else {
            emptyLabel.isHidden = !viewModel.searchTrackListModel.trackList.isEmpty
        }
    }
    
    private func saveToFavorite(trackModel: TrackModel) {
        let item = MusicTrackLocalDataModel(
            trackId: trackModel.trackId,
            trackName: trackModel.trackName,
            artistName: trackModel.artistName)
        viewModel.saveToLocal(item: item)
        tableView.reloadData()
    }
    
    // MARK: - Network Observer
    
    private func observeDataChanged() {
        viewModel.baseStateProperty
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] state in
                    switch state {
                    case .loading:
                        self?.view.showLoadingIndicator()
                    case .notLoad, .finished, .failed:
                        self?.view.removeLoadingIndicator()
                    }
                })
            .disposed(by: disposeBag)
        
        viewModel.trackListSubject
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] result in
                    switch result {
                    case .Success:
                        self?.tableView.reloadData()
                        self?.validateEmptyLabel()
                    case .Failure(let error):
                        self?.showError(error: error)
                    }
                })
            .disposed(by: disposeBag)
    }
    
    @objc private func refreshPage() {
        refreshControl.endRefreshing()
        if viewModel.artistKeyword.isEmpty {
            resetData()
        } else {
            resetSearchData()
        }
        view.showLoadingIndicator()
        viewModel.getTrackList()
    }
    
}

extension LibraryViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        viewModel.artistKeyword = text
        viewModel.getTrackList()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.artistKeyword = ""
        resetSearchData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else {
            return
        }
        
        if text.isEmpty {
            viewModel.artistKeyword = ""
            resetSearchData()
        }
    }
    
}

extension LibraryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.artistKeyword.isEmpty {
            return viewModel.trackListModel.trackList.count
        }
        return viewModel.searchTrackListModel.trackList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cell: MusicTrackTableViewCell.self)
        let trackListModel = viewModel.trackListModel.trackList
        let searchTrackListModel = viewModel.searchTrackListModel.trackList
        let trackList: [TrackModel] = viewModel.artistKeyword.isEmpty ? trackListModel : searchTrackListModel
        cell.cellModel = trackList[indexPath.row]
        cell.selectionStyle = .none
        
        cell.onTapCtaButton = { [weak self] trackModel in
            self?.saveToFavorite(trackModel: trackModel)
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let hasReachedBottom = scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
        if hasReachedBottom {
            viewModel.getTrackList()
        }
    }
    
}

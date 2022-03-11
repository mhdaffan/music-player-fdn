//
//  FavoriteViewController.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

import UIKit

final class FavoriteViewController: ViewController {
    
    private let viewModel: FavoriteViewModel = Resolver.resolve()
    
    private lazy var tableView = UITableView().then {
        $0.register(cell: FavoriteTrackTableViewCell.self)
        $0.separatorStyle = .none
        $0.dataSource = self
    }
    private lazy var emptyLabel = UILabel().then {
        $0.text = emptyFavoriteDataStr
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllLocalTracks()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.title = favoriteStr
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
    
    private func removeFromFavorite(item: MusicTrackLocalDataModel) {
        viewModel.removeFromLocal(item: item)
        getAllLocalTracks()
    }
    
    private func getAllLocalTracks() {
        viewModel.getAllLocalTracks()
        tableView.reloadData()
        validateEmptyLabel()
    }
    
    private func validateEmptyLabel() {
        emptyLabel.isHidden = !viewModel.localData.isEmpty
    }
    
}

extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.localData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cell: FavoriteTrackTableViewCell.self)
        cell.cellModel = viewModel.localData[indexPath.row]
        cell.selectionStyle = .none
        
        cell.onTapCtaButton = { [weak self] trackModel in
            self?.removeFromFavorite(item: trackModel)
        }
        return cell
    }
    
}

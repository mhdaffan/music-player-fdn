//
//  FavoriteTrackTableViewCell.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 11/03/22.
//

import UIKit

final class FavoriteTrackTableViewCell: UITableViewCell {
    
    var cellModel: MusicTrackLocalDataModel? {
        didSet {
            updateUI()
        }
    }
    
    var onTapCtaButton: ((MusicTrackLocalDataModel) -> Void)?
    
    private let artistNameLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 14)
    }
    private let trackNameLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12)
    }
    private let ctaButton = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle(removeStr, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
        $0.addTarget(self, action: #selector(tapCtaButton), for: .touchUpInside)
    }
    private let lineView = UIView().then {
        $0.backgroundColor = .lightGray.withAlphaComponent(0.5)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        contentView.addSubviews(artistNameLabel, trackNameLabel, ctaButton, lineView)
        artistNameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(12)
            $0.trailing.equalTo(ctaButton.snp_leading).inset(-8)
        }
        trackNameLabel.snp.makeConstraints {
            $0.top.equalTo(artistNameLabel.snp_bottom).offset(4)
            $0.leading.trailing.equalTo(artistNameLabel)
            $0.bottom.equalToSuperview().inset(12)
        }
        ctaButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
            $0.height.equalTo(24)
            $0.width.equalTo(105)
        }
        lineView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    private func updateUI() {
        guard let cellModel = cellModel else {
            return
        }
        
        artistNameLabel.text = cellModel.artistName
        trackNameLabel.text = cellModel.trackName
    }
    
    @objc private func tapCtaButton() {
        guard let cellModel = cellModel else {
            return
        }
        
        onTapCtaButton?(cellModel)
    }
    
}

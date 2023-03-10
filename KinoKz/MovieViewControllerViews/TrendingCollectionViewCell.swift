//
//  TrendingCollectionViewCell.swift
//  KinoKz
//
//  Created by Aknar Assanov on 02.02.2023.
//

import UIKit

final class TrendingCollectionViewCell: UICollectionViewCell {
    
    private lazy var trendingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with backdrop_path: String) {
        guard let url = URL(string: Constants.Links.image + backdrop_path) else { fatalError("Incorrect configure!")
        }
        DispatchQueue.main.async {
            self.trendingImageView.kf.setImage(with: url)
        }
    }
}

//MARK: - Setup views and constraints methods

private extension TrendingCollectionViewCell {
    
    func setupViews() {
        contentView.addSubview(trendingImageView)
    }
    
    func setupConstraints() {
        trendingImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

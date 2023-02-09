//
//  MovieCollectionViewCell.swift
//  KinoKz
//
//  Created by Aknar Assanov on 02.02.2023.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    
    private let wholeView = UIView()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "knives")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    private lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Knives out 2: Glass Onion"
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.textColor = .label
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.text = "Comedy, drama, thriller"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemGray2
        label.sizeToFit()
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: MovieModel) {
        guard let url = URL(string: "\(Constants.Links.image)\(model.posterPath)") else { fatalError("Incorrect configure!") }
        let stringGenres = model.genreIds.map{ String($0) }
        DispatchQueue.main.async {
            self.posterImageView.kf.setImage(with: url)
            self.movieNameLabel.text = model.title
            self.genresLabel.text = stringGenres.joined(separator: ", ")
        }
    }
}

//MARK: - Setup views and constraints methods

private extension MovieCollectionViewCell {
    
    func setupViews() {
        contentView.addSubview(wholeView)
        wholeView.addSubview(posterImageView)
        wholeView.addSubview(movieNameLabel)
        wholeView.addSubview(genresLabel)
    }
    
    func setupConstraints() {
        wholeView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        posterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        genresLabel.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

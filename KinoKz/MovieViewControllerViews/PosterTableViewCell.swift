//
//  PosterTableViewCell.swift
//  KinoKz
//
//  Created by Aknar Assanov on 01.03.2023.
//

import UIKit

class PosterTableViewCell: UITableViewCell {

    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    private var labelView = UILabel()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.textColor = .label
        label.numberOfLines = 0

        return label
    }()
    
    private lazy var taglineLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: DetailedMovieModel) {
        let urlString = "\(Constants.Links.image)\(model.posterPath)"
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.main.async {
            self.posterImageView.kf.setImage(with: url)
            self.titleLabel.text = model.title
            self.taglineLabel.text = model.tagline
            self.overviewLabel.text = model.overview
        }
    }
}

//MARK: - Setup views and constraints methods

private extension PosterTableViewCell {
    
    func setupViews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(labelView)
        labelView.addSubview(titleLabel)
        labelView.addSubview(taglineLabel)
        labelView.addSubview(overviewLabel)
    }
    
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(10)
            make.width.equalToSuperview().multipliedBy(0.35)
        }
        labelView.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
            make.top.trailing.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        taglineLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(taglineLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

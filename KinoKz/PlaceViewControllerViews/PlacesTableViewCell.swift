//
//  PlacesTableViewCell.swift
//  KinoKz
//
//  Created by Aknar Assanov on 09.02.2023.
//

import UIKit

class PlacesTableViewCell: UITableViewCell {

    private lazy var placeImageView: UIImageView = {
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let imageView = UIImageView()
        imageView.image = UIImage(named: "knives")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Knives out 2: Glass Onion"
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.textColor = .label
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Comedy, drama, thriller"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemGray2
        label.sizeToFit()
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
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
    
    func configure(with model: PlaceModel) {
        guard let url = URL(string: model.smallPoster) else { fatalError("Incorrect configure!") }
        DispatchQueue.main.async {
            self.placeImageView.kf.setImage(with: url)
            self.nameLabel.text = model.name
            self.addressLabel.text = model.address
        }
    }
}

//MARK: - Setup views and constraints methods

private extension PlacesTableViewCell {
    
    func setupViews() {
        contentView.addSubview(placeImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
    }
    
    func setupConstraints() {
        placeImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(10)
            make.width.equalTo(placeImageView.snp.height)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(placeImageView.snp.trailing).offset(10)
            make.height.equalToSuperview().multipliedBy(0.4)
            
        }
        addressLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.leading.equalTo(placeImageView.snp.trailing).offset(10)
            make.top.equalTo(nameLabel.snp.bottom).inset(30)
        }
    }
}
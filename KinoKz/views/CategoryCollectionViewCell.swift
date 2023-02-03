//
//  CategoryCollectionViewCell.swift
//  KinoKz
//
//  Created by Aknar Assanov on 02.02.2023.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    private lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
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
    
    func setText(with text: String) {
        categoryNameLabel.text = text
    }
}


//MARK: - Setup views and constraints methods

private extension CategoryCollectionViewCell {
    func setupViews() {
        contentView.addSubview(categoryNameLabel)
    }
    
    func setupConstraints() {
        categoryNameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

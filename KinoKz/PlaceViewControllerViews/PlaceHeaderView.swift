//
//  PlaceHeaderView.swift
//  KinoKz
//
//  Created by Aknar Assanov on 09.02.2023.
//

import UIKit

class PlaceHeaderView: UIView {

    private let contentView = UIView()
    
    private let categoryList = Category.allCases
    
    private lazy var movieSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.layer.cornerRadius = 20
        searchBar.clipsToBounds = true
        return searchBar
    }()

    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifiers.categoryCollectionViewCell)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Category collection view data sourse methods

extension PlaceHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.categoryCollectionViewCell, for: indexPath) as! CategoryCollectionViewCell
            cell.configure(with: categoryList[indexPath.row].rawValue)
            cell.backgroundColor = .systemGray6
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            return cell
        }
        return UICollectionViewCell()
    }
}

//MARK: - Category collection view delegate methods

extension PlaceHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            let label = UILabel()
            label.text = categoryList[indexPath.row].rawValue
            label.sizeToFit()
            return CGSize(width: label.frame.width + 30, height: collectionView.frame.height)
        }
        let height = collectionView.frame.height
        return CGSize(width: frame.width * 0.75, height: height )
    }
}

//MARK: - Setup views and constraints methods

private extension PlaceHeaderView {
    
    func setupViews() {
        addSubview(contentView)
        contentView.addSubview(movieSearchBar)
        contentView.addSubview(categoryCollectionView)
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(self).inset(15)
        }
        movieSearchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        movieSearchBar.searchTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(movieSearchBar.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(36)
        }
    }
}

//
//  MovieViewController.swift
//  KinoKz
//
//  Created by Aknar Assanov on 02.02.2023.
//

import UIKit
import SnapKit

final class MovieViewController: UIViewController {
    
    var apiCaller = APICaller()
    var movieList: [MovieModel] = []
    
    private let scrollView = UIScrollView()
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
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: Constans.Identifiers.categoryCollectionViewCell)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var trendingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TrendingCollectionViewCell.self, forCellWithReuseIdentifier: Constans.Identifiers.trendingCollectionViewCell)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var categoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: Constans.Identifiers.categoryTableViewCell)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        trendingCollectionView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        apiCaller.delegate = self
        
        apiCaller.fetchRequest()
        
        setupViews()
        setupConstraints()
        print(movieList)
    }
    
    
}

//MARK: - API Caller delegate methods

extension MovieViewController: ApiCallerDelegate {
    func didUpdateMovieList(with movieList: [MovieModel]) {
        self.movieList = movieList
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    
}

//MARK: - Collection view data sourse methods

extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return categoryList.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constans.Identifiers.categoryCollectionViewCell, for: indexPath) as! CategoryCollectionViewCell
            cell.setText(with: categoryList[indexPath.row].rawValue)
            cell.backgroundColor = .systemGray6
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constans.Identifiers.trendingCollectionViewCell, for: indexPath) as! TrendingCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
}

//MARK: - Collection view delegate methods

extension MovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            let label = UILabel()
            label.text = categoryList[indexPath.row].rawValue
            label.sizeToFit()
            return CGSize(width: label.frame.width + 30, height: collectionView.frame.height)
        }
        let height = collectionView.frame.height
        return CGSize(width: view.frame.width * 0.75, height: height )
    }
}

//extension MovieViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.isSelected = true
//    }
//}

//MARK: - Table view data source methods

extension MovieViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryList.count - 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constans.Identifiers.categoryTableViewCell, for: indexPath) as! CategoryTableViewCell
        
        return cell
    }
    
}

//MARK: - Table view delegate methods

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderView()
        let title = String(categoryList[section + 1].rawValue.dropFirst())
        view.setText(with: title, number: 6)
        return view
    }
}

//MARK: - Setup views and constraints methods

private extension MovieViewController {
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(movieSearchBar)
        contentView.addSubview(categoryCollectionView)
        contentView.addSubview(trendingCollectionView)
        contentView.addSubview(categoryTableView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view).inset(15)
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
        trendingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view).multipliedBy(0.2)
        }
        categoryTableView.snp.makeConstraints { make in
            make.top.equalTo(trendingCollectionView.snp.bottom).offset(10)
            make.height.equalTo(view)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

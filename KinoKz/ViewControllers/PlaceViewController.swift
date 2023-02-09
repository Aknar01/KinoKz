//
//  PlaceViewController.swift
//  KinoKz
//
//  Created by Aknar Assanov on 02.02.2023.
//

import UIKit

class PlaceViewController: UIViewController {
    
    var apiCaller = PlaceAPICaller()
    var allPlacesList: [PlaceModel] = []
    
//    private let scrollView = UIScrollView()
//    private let contentView = UIView()
    
    private let categoryList = Category.allCases
    
//    private lazy var movieSearchBar: UISearchBar = {
//        let searchBar = UISearchBar()
//        searchBar.searchBarStyle = .minimal
//        searchBar.placeholder = "Search"
//        searchBar.layer.cornerRadius = 20
//        searchBar.clipsToBounds = true
//        return searchBar
//    }()
    
//    private lazy var categoryCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifiers.categoryCollectionViewCell)
//        collectionView.showsHorizontalScrollIndicator = false
//        return collectionView
//    }()
    
    private lazy var placesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PlacesTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.placesTableViewCell)
        //        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
//        categoryCollectionView.dataSource = self
//        categoryCollectionView.delegate = self
        placesTableView.dataSource = self
        placesTableView.delegate = self
        
        setupViews()
        setupConstraints()
        
        apiCaller.delegate = self
        apiCaller.fetchRequerst()
    }
    
}

//MARK: - API Caller delegate methods

extension PlaceViewController: PlaceApiCallerDelegate {
    func didUpdateMovieList(with placeList: [PlaceModel]) {
        self.allPlacesList.append(contentsOf:placeList)
        DispatchQueue.main.async {
            self.placesTableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print("Failer with, error: ", error)
    }
}

//MARK: - Category collection view data sourse methods

//extension PlaceViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return categoryList.count
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == categoryCollectionView {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.categoryCollectionViewCell, for: indexPath) as! CategoryCollectionViewCell
//            cell.configure(with: categoryList[indexPath.row].rawValue)
//            cell.backgroundColor = .systemGray6
//            cell.layer.cornerRadius = 10
//            cell.clipsToBounds = true
//            return cell
//        }
//        return UICollectionViewCell()
//    }
//}

//MARK: - Category collection view delegate methods

//extension PlaceViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == categoryCollectionView {
//            let label = UILabel()
//            label.text = categoryList[indexPath.row].rawValue
//            label.sizeToFit()
//            return CGSize(width: label.frame.width + 30, height: collectionView.frame.height)
//        }
//        let height = collectionView.frame.height
//        return CGSize(width: view.frame.width * 0.75, height: height )
//    }
//}

//MARK: - Table view data source methods

extension PlaceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPlacesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.placesTableViewCell, for: indexPath) as! PlacesTableViewCell
        cell.configure(with: allPlacesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            
            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
            label.text = "Notification Times"
            label.font = .systemFont(ofSize: 16)
            label.textColor = .black
            
            headerView.addSubview(label)
            
            return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
    }
    
}

//MARK: - Table view delegate methods

extension PlaceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.15
    }
}

//MARK: - Setup views and constraints methods

private extension PlaceViewController {
    
    func setupViews() {
        view.addSubview(placesTableView)
//        scrollView.addSubview(contentView)
//        contentView.addSubview(movieSearchBar)
//        contentView.addSubview(categoryCollectionView)
//        contentView.addSubview(placesTableView)
    }
    
    func setupConstraints() {
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        contentView.snp.makeConstraints { make in
//            make.top.bottom.equalToSuperview()
//            make.leading.trailing.equalTo(view).inset(15)
//        }
//        movieSearchBar.snp.makeConstraints { make in
//            make.top.leading.trailing.equalToSuperview()
//            make.height.equalTo(50)
//        }
//        movieSearchBar.searchTextField.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        categoryCollectionView.snp.makeConstraints { make in
//            make.top.equalTo(movieSearchBar.snp.bottom).offset(15)
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(36)
//        }
//        placesTableView.snp.makeConstraints { make in
//            make.top.equalTo(categoryCollectionView.snp.bottom).offset(10)
//            make.height.equalTo(view).multipliedBy(1.6)
//            make.leading.trailing.bottom.equalToSuperview()
//        }
        placesTableView.snp.makeConstraints { make in
            make.margins.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.1)
        }
    }
}

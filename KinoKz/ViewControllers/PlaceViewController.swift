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
    
    private let categoryList = Category.allCases

    private lazy var placesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(PlacesTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.placesTableViewCell)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = PlaceHeaderView()
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
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
    }
    
    func setupConstraints() {
        placesTableView.snp.makeConstraints { make in
            make.margins.equalToSuperview()
            make.height.equalTo(view)
        }
    }
}

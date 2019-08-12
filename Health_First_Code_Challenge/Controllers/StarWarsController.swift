//
//  ViewController.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/10/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

enum DataState {
    case characters
    case planets
    
    public mutating func switchState() {
        switch self {
        case .characters:
            self = .planets
        case .planets:
            self = .characters
        }
    }
}

class StarWarsController: UIViewController {

    @IBOutlet weak var starWarsTableView: UITableView!
    @IBOutlet weak var starWarsSearchBar: UISearchBar!
    private var refreshControl: UIRefreshControl!
    
    // Whenever we switch between characters and planets we want to reload tableview
    private var dataState = DataState.characters {
        didSet {
            DispatchQueue.main.async {
                self.starWarsTableView.reloadData()
            }
        }
    }
    private var searching = false
    private var charactersViewModel: CharactersViewModel!
    private var planetsViewModel: PlanetsViewModel!
    
    // TODO: Add refresh control to reset
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupSearchBar()
        setupViewModelsAndFetchData()
        setupRefreshControl()
    }
    
    private func configureTableView() {
        starWarsTableView.delegate = self
        starWarsTableView.dataSource = self
        starWarsTableView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        starWarsTableView.register(UINib(nibName: "PlanetCell", bundle: nil), forCellReuseIdentifier: "PlanetCell")
    }
    
    private func setupSearchBar() {
        starWarsSearchBar.delegate = self
        changeSearchBarPlaceholder()
    }
    
    private func setupViewModelsAndFetchData() {
        planetsViewModel = PlanetsViewModel(delegate: self)
        charactersViewModel = CharactersViewModel(delegate: self)
        charactersViewModel.fetchCharacters()
        planetsViewModel.fetchPlanets()
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        starWarsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(resetTableView), for: .valueChanged)
    }
    @objc private func resetTableView() {
        refreshControl.beginRefreshing()
        searching = false
        starWarsTableView.reloadData()
        refreshControl.endRefreshing()
    }

    @IBAction func changeDataState(_ sender: UISegmentedControl) {
        searching = false
        dataState.switchState()
        changeSearchBarPlaceholder()
    }
    
    private func changeSearchBarPlaceholder() {
        switch dataState {
        case .characters:
            starWarsSearchBar.placeholder = Constants.charSearchPlaceholder
        case .planets:
            starWarsSearchBar.placeholder = Constants.peopleSearchPlaceHolder
        }
    }
}

// MARK: TableView Methods
extension StarWarsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataState {
        case .characters:
            if searching { return charactersViewModel.searchCount }
            return charactersViewModel.currentArrCount
        case .planets:
            if searching { return planetsViewModel.searchCount }
            return planetsViewModel.currentArrCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataState {
        case .characters:
            guard let cell = starWarsTableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharacterCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            let currentChar = searching ? charactersViewModel.searchChar(at: indexPath.row) : charactersViewModel.character(at: indexPath.row)
            cell.configureCell(char: currentChar, index: indexPath.row)
            return cell
            
        case .planets:
            guard let cell = starWarsTableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath) as? PlanetCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            let currentPlanet = searching ? planetsViewModel.searchPlanet(at: indexPath.row) : planetsViewModel.planet(at: indexPath.row)
            cell.configureCell(planet: currentPlanet, index: indexPath.row)
            return cell
        }
    }
    
    // MARK: Infinite Scroll Setup
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard searching == false else { return }
        
        switch dataState {
        case .characters:
            if indexPath.row == charactersViewModel.currentArrCount - 1 {
                charactersViewModel.fetchCharacters()
            }
        case .planets:
            if indexPath.row == planetsViewModel.currentArrCount - 1 {
                planetsViewModel.fetchPlanets()
            }
        }
    }
    
}
extension StarWarsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataState {
        case .characters:
            return 180
        case .planets:
            return 160
        }
    }
}

// MARK: Search Bar Methods
extension StarWarsController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searching = true
        switch dataState {
        case .characters:
            charactersViewModel.searchCharacters(keyword: searchText)
        case .planets:
            planetsViewModel.searchPlanets(keyword: searchText)
        }
    }
}

// MARK: View Model Delegates
extension StarWarsController: CharactersViewModelDelegate {
    func fetchCharactersComplete() {
        DispatchQueue.main.async {
            self.starWarsTableView.reloadData()
        }
    }
    func fetchCharactersFail(error: AppError) {
        showAlert(title: "App Error", message: error.errorMessage())
    }
}
extension StarWarsController: PlanetsViewModelDelegate {
    func fetchPlanetsComplete() {
        DispatchQueue.main.async {
            self.starWarsTableView.reloadData()
        }
    }
    func fetchPlanetsFail(error: AppError) {
        showAlert(title: "App Error", message: error.errorMessage())
    }
}

// MARK: Cell Delegates
extension StarWarsController: CharacterCellDelegate {
    func addCharToFlash(tag: Int) {
        // TODO: add to flash
        print("Button Pressed")
    }
}
extension StarWarsController: PlanetCellDelegate {
    func addPlanetToFlash(tag: Int) {
        // TODO: add to flash
        print("button pressed")
    }
}

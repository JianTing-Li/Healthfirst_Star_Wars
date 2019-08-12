//
//  ViewController.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/10/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

enum DataState {
    case people
    case planets
    
    public mutating func switchState() {
        switch self {
        case .people:
            self = .planets
        case .planets:
            self = .people
        }
    }
}

class StarWarsController: UIViewController {

    @IBOutlet weak var starWarsTableView: UITableView!
    @IBOutlet weak var starWarsSearchBar: UISearchBar!
    private var refreshControl: UIRefreshControl!
    
    // Whenever we switch between characters and planets we want to reload tableview
    private var dataState = DataState.people {
        didSet {
            DispatchQueue.main.async {
                self.starWarsTableView.reloadData()
            }
        }
    }
    private var searching = false
    private var charactersViewModel: PeopleViewModel!
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
        charactersViewModel = PeopleViewModel(delegate: self)
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
        case .people:
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
        case .people:
            if searching { return charactersViewModel.searchCount }
            return charactersViewModel.currentArrCount
        case .planets:
            if searching { return planetsViewModel.searchCount }
            return planetsViewModel.currentArrCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataState {
        case .people:
            guard let cell = starWarsTableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharacterCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            let currentChar = searching ? charactersViewModel.searchPerson(at: indexPath.row) : charactersViewModel.person(at: indexPath.row)
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
        case .people:
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
        case .people:
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
        case .people:
            charactersViewModel.searchCharacters(keyword: searchText)
        case .planets:
            planetsViewModel.searchPlanets(keyword: searchText)
        }
    }
}

// MARK: ViewModel Delegates
extension StarWarsController: PeopleViewModelDelegate, PlanetsViewModelDelegate {
    func fetchPeopleComplete() {
        DispatchQueue.main.async {
            self.starWarsTableView.reloadData()
        }
    }
    func fetchCharactersFail(error: AppError) {
        showAlert(title: "App Error", message: error.errorMessage())
    }
    func fetchPlanetsComplete() {
        DispatchQueue.main.async {
            self.starWarsTableView.reloadData()
        }
    }
    func fetchPlanetsFail(error: AppError) {
        showAlert(title: "App Error", message: error.errorMessage())
    }
}

// MARK: Cell Delegates: add char / planet to flashcard
extension StarWarsController: CharacterCellDelegate, PlanetCellDelegate {
    func addCharToFlash(tag: Int) {
        addToFlash(index: tag)
    }
    func addPlanetToFlash(tag: Int) {
        // TODO: add to flash
        print("button pressed")
    }
    private func addToFlash(index: Int) {
        switch dataState {
        case .people:
            let person = searching ? charactersViewModel.searchPerson(at: index) : charactersViewModel.person(at: index)
            guard !FlashcardsDataManager.isFlashExist(name: person.name) else {
                showAlert(title: "Already Exist", message: "This Star Wars character already exist in your flashcard.")
                return
            }
            let flashDescription = person.flashcardDiscription
            let newFlashcard = Flashcard(type: Category.character.rawValue, name: person.name, description: flashDescription)
            FlashcardsDataManager.addNewFlashcard(flashcard: newFlashcard)
        case .planets:
            break
        }
    }
}

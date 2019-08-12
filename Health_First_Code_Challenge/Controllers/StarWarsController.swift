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
    
    // Whenever we switch between characters and planets we want to reload tableview
    private var state = DataState.characters {
        didSet {
            DispatchQueue.main.async {
                self.starWarsTableView.reloadData()
            }
        }
    }
    
    private var searching = false
    private var charactersViewModel: CharactersViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        charactersViewModel = CharactersViewModel(delegate: self)
        charactersViewModel.fetchCharacters()
    }
    
    private func configureTableView() {
        starWarsTableView.delegate = self
        starWarsTableView.dataSource = self
        starWarsTableView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        starWarsTableView.register(UINib(nibName: "PlanetCell", bundle: nil), forCellReuseIdentifier: "PlanetCell")
    }

    @IBAction func changeDataState(_ sender: UISegmentedControl) {
        state.switchState()
        searching = false
    }
}


extension StarWarsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .characters:
            return charactersViewModel.currentArrCount
        case .planets:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .characters:
            guard let cell = starWarsTableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharacterCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.configureCell(char: charactersViewModel.character(at: indexPath.row), index: indexPath.row)
            return cell
        case .planets:
            break
        }
        return UITableViewCell()
    }
    
    // Infinite Scroll Setup
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard searching == false else { return }
        
        switch state {
        case .characters:
            if indexPath.row == charactersViewModel.currentArrCount - 1 {
                charactersViewModel.fetchCharacters()
            }
        case .planets:
            break
        }
    }
    
}
extension StarWarsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch state {
        case .characters:
            return 180
        case .planets:
            return 160
        }
    }
}


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


extension StarWarsController: CharacterCellDelegate {
    func addCharToFlash(tag: Int) {
        print("Button Pressed")
    }
}

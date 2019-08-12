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
    private var state = DataState.characters
    private var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureTableView() {
        starWarsTableView.delegate = self
        starWarsTableView.dataSource = self
        starWarsTableView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        starWarsTableView.register(UINib(nibName: "PlanetCell", bundle: nil), forCellReuseIdentifier: "PlanetCell")
    }

    @IBAction func changeDataState(_ sender: UISegmentedControl) {
        state.switchState()
    }
}

extension StarWarsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .characters:
            break
        case .planets:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .characters:
            break
        case .planets:
            break
        }
    }
    
    // Infinite Scroll Setup
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard searching == false else { return }
        
        switch state {
        case .characters:
            break
        case .planets:
            break
        }
    }
    
}

extension StarWarsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

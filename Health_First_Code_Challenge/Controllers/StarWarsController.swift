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
    var state = DataState.characters
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func changeDataState(_ sender: UISegmentedControl) {
        state.switchState()
        print(state)
    }
    
}


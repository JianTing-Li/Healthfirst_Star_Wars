//
//  PlanetCell.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/11/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

protocol PlanetCellDelegate: AnyObject {
    func addPlanetToFlash(tag: Int) -> Void
}

class PlanetCell: UITableViewCell {
    
    weak var delegate: PlanetCellDelegate?
    
    @IBOutlet weak var planetNameLabel: UILabel!
    @IBOutlet weak var climateLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var addToFlashButton: UIButton!
    
    public func configureCell(planet: StarWarsPlanet, index: Int) {
        addToFlashButton.tag = index
        planetNameLabel.text = planet.name
        climateLabel.text = "Climate: \(planet.climate)"
        populationLabel.text = "Population: \(planet.population)"
        creationDateLabel.text = "Date Created: \(planet.formattedCreationDate)"
    }
    
    @IBAction func addToFlashAction(_ sender: UIButton) {
        delegate?.addPlanetToFlash(tag: sender.tag)
    }
}

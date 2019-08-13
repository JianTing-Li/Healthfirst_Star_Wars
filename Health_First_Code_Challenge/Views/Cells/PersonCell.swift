//
//  CharacterCell.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/11/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

protocol PersonCellDelegate: AnyObject {
    func addCharToFlash(tag: Int) -> Void
}

class PersonCell: UITableViewCell {
    
    weak var delegate: PersonCellDelegate?
    
    @IBOutlet weak var charName: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var addToFlashButton: UIButton!
    
    public func configureCell(char: StarWarsPerson, index: Int) {
        addToFlashButton.tag = index
        charName.text = char.name
        birthYearLabel.text = "Birth Year: \(char.birthYear)"
        hairColorLabel.text = "Hair Color: \(char.hairColor)"
        eyeColorLabel.text = "Eye Color: \(char.eyeColor)"
        dateCreatedLabel.text = "Date Created: \(char.formattedCreationDate)"
    }
    
    @IBAction func addToFlashAction(_ sender: UIButton) {
        delegate?.addCharToFlash(tag: sender.tag)
    }
}

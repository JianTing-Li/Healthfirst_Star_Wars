//
//  CharacterCell.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/11/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

protocol CharacterCellDelegate: AnyObject {
    func addCharToFlash(tag: Int) -> Void
}

class CharacterCell: UITableViewCell {
    
    weak var delegate: CharacterCellDelegate?
    
    @IBOutlet weak var charName: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var addToFlashButton: UIButton!
    
    public func configureCell(char: StarWarCharacter, index: Int) {
        addToFlashButton.tag = index
        charName.text = char.name
        birthYearLabel.text = "Birth Year: \(char.birthYear)"
        hairColorLabel.text = "Hair Color: \(char.hairColor)"
        eyeColorLabel.text = "Eye Color: \(char.eyeColor)"
        let modifyDateString = char.created.components(separatedBy: ".").joined(separator: "+")
        dateCreatedLabel.text = "Date Created: \(modifyDateString.formatISODateString(dateFormat: "MMM d, yyyy"))"
    }
    
    @IBAction func addToFlashAction(_ sender: UIButton) {
        delegate?.addCharToFlash(tag: sender.tag)
    }
}

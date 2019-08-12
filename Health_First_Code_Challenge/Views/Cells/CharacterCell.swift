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
    
    private weak var delegate: CharacterCellDelegate?
    
    @IBOutlet weak var charName: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var addToFlashButton: UIButton!
    
    public func configureCell(char: StarWarCharacter, index row: Int) {
        addToFlashButton.tag = row
        charName.text = char.name
        birthYearLabel.text = char.birthYear
        hairColorLabel.text = char.hairColor
        eyeColorLabel.text = char.eyeColor
        dateCreatedLabel.text = char.created.formatISODateString(dateFormat: "E, MMM d yyyy, h:mm a")
    }
    
    @IBAction func addToFlash(_ sender: UIButton) {
        delegate?.addCharToFlash(tag: sender.tag)
    }
}

//
//  FlashcardCell.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/12/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

protocol FlashcardCellDelegate: AnyObject {
    func moreOptionsButtonPressed(index: Int)
}

class FlashcardCell: UICollectionViewCell {
    
    weak var delegate: FlashcardCellDelegate?
    
    @IBOutlet weak var moreOptionsButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    public func configureCell(flashcard: Flashcard, index: Int) {
        moreOptionsButton.tag = index
        nameLabel.text = flashcard.name
        layer.cornerRadius = 2
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
    }
    
    @IBAction func moreOptions(_ sender: UIButton) {
        delegate?.moreOptionsButtonPressed(index: sender.tag)
    }
}

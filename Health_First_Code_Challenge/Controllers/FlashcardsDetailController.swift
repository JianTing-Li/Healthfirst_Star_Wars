//
//  FlashcardsDetailController.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/12/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

class FlashcardsDetailController: UIViewController {
    
    @IBOutlet weak var flipCardButton: UIButton!
    @IBOutlet weak var flashcardView: UIView!
    @IBOutlet weak var flashcardLabel: UILabel!
    var flashcard: Flashcard!
    var currentFlashText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        currentFlashText = flashcard.name
    }
    
    private func setupUI() {
        setupFlashcardView()
        flipCardButton.backgroundColor = .white
        flashcardLabel.text = flashcard.name
    }
    
    private func setupFlashcardView() {
        flashcardView.layer.cornerRadius = 2
        flashcardView.layer.borderColor = UIColor.black.cgColor
        flashcardView.layer.borderWidth = 2
    }
    
    @IBAction func flipFlashcard(_ sender: UIButton) {
        if currentFlashText == flashcard.name {
            UIView.transition(with: flashcardView, duration: 1.8, options: [.transitionFlipFromRight], animations: {
                self.flashcardLabel.text = ""
            }) { (finish) in
                self.flashcardLabel.text = self.flashcard.description
                self.currentFlashText = self.flashcard.description
            }
        } else {
            UIView.transition(with: flashcardView, duration: 1.8, options: [.transitionFlipFromLeft], animations: {
                self.flashcardLabel.text = ""
            }) { (finish) in
                self.flashcardLabel.text = self.flashcard.name
                self.currentFlashText = self.flashcard.name
            }
        }
    }
}

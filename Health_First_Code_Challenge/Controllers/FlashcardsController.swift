//
//  FlashcardsController.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/12/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

class FlashcardsController: UIViewController {
    @IBOutlet weak var flashcardsCollectionView: UICollectionView!
    private var flashCards = [Flashcard]() {
        didSet {
            DispatchQueue.main.async {
                self.flashcardsCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        flashcardsCollectionView.register(UINib(nibName: "FlashcardCell", bundle: nil), forCellWithReuseIdentifier: "FlashcardCell")
        flashcardsCollectionView.dataSource = self
        flashcardsCollectionView.delegate = self
    }
}

// MARK: CollectionView Methods
extension FlashcardsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = flashcardsCollectionView.dequeueReusableCell(withReuseIdentifier: "FlashcardCell", for: indexPath) as? FlashcardCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        let flashcard = flashCards[indexPath.row]
        cell.configureCell(flashcard: flashcard, index: indexPath.row)
        return cell
    }
}

extension FlashcardsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: Segue to Detail
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 272*1.2, height: 360*1.2)
    }
}

// MARK: More options button via FlashcardCellDelegate
extension FlashcardsController: FlashcardCellDelegate {
    func moreOptionsButtonPressed(index: Int) {
        // TODO: Action sheet to delete selected flashcard
    }
}

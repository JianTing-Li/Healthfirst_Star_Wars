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

extension FlashcardsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = flashcardsCollectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: <#T##IndexPath#>)
    }
}

extension FlashcardsController: UICollectionViewDelegateFlowLayout {
    
}

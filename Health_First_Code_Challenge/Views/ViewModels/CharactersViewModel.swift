//
//  CharactersViewModel.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/11/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

protocol CharactersViewModelDelegate: AnyObject {
    func fetchCharactersComplete()
    func fetchCharactersFail(error: AppError)
}

final class CharactersViewModel {
    private weak var delegate: CharactersViewModelDelegate?
    
    private var starWarsCharacters = [StarWarCharacter]() {
        didSet {
            delegate?.fetchCharactersComplete()
        }
    }
    private var nextURL: String? = nil
    private var isFetchInProgress = false
    private var firstAPICall = true
    
    init(delegate: CharactersViewModelDelegate) {
        self.delegate = delegate
    }
    
    public var currentArrCount: Int {
        return starWarsCharacters.count
    }
    
    public var isNextPageExist: Bool {
        if let _ = nextURL { return true }
        return false
    }
    
    public func character(at index: Int) -> StarWarCharacter {
        return starWarsCharacters[index]
    }
    
    public func fetchCharacters() {
        guard !isFetchInProgress else { return }
        guard isNextPageExist || firstAPICall else { return }
        firstAPICall = false 
        isFetchInProgress = true
        
        StarWarsAPIClient.getStarWarsCharacters(nextPageURL: nextURL, searchKey: nil) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.isFetchInProgress = false
                self?.delegate?.fetchCharactersFail(error: error)
            case .success(let charactersData):
                self?.isFetchInProgress = false
                self?.nextURL = charactersData.next
                let characters = charactersData.results
                self?.starWarsCharacters.append(contentsOf: characters)
            }
        }
    }
}

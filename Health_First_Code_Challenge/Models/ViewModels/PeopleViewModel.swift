//
//  CharactersViewModel.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/11/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

protocol PeopleViewModelDelegate: AnyObject {
    func fetchPeopleComplete()
    func fetchCharactersFail(error: AppError)
}

final class PeopleViewModel {
    private weak var delegate: PeopleViewModelDelegate?
    
    private var starWarsPeople = [StarWarsPerson]() {
        didSet {
            delegate?.fetchPeopleComplete()
        }
    }
    private var searchPersonResults = [StarWarsPerson]() {
        didSet {
            delegate?.fetchPeopleComplete()
        }
    }
    
    private var nextURL: String? = nil
    private var isFetchInProgress = false
    private var firstAPICall = true
    
    init(delegate: PeopleViewModelDelegate) {
        self.delegate = delegate
    }
    
    public var currentArrCount: Int {
        return starWarsPeople.count
    }
    public var searchCount: Int {
        return searchPersonResults.count
    }
    
    public var isNextPageExist: Bool {
        if let _ = nextURL { return true }
        return false
    }
    
    public func person(at index: Int) -> StarWarsPerson {
        return starWarsPeople[index]
    }
    public func searchPerson(at index: Int) -> StarWarsPerson {
        return searchPersonResults[index]
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
                self?.starWarsPeople.append(contentsOf: characters)
            }
        }
    }
    public func searchCharacters(keyword: String) {
        guard !isFetchInProgress else { return }
        isFetchInProgress = true
        
        StarWarsAPIClient.getStarWarsCharacters(nextPageURL: nil, searchKey: keyword) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.isFetchInProgress = false
                self?.delegate?.fetchCharactersFail(error: error)
            case .success(let charactersData):
                self?.isFetchInProgress = false
                let characters = charactersData.results
                self?.searchPersonResults = characters
            }
        }
    }
}

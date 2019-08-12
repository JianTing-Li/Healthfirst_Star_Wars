//
//  PlanetsViewModel.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/11/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

protocol PlanetsViewModelDelegate: AnyObject {
    func fetchPlanetsComplete()
    func fetchPlanetsFail(error: AppError)
}

final class PlanetsViewModel {
    private weak var delegate: PlanetsViewModelDelegate?
    
    private var starWarsPlanets = [StarWarsPlanet]() {
        didSet {
            delegate?.fetchPlanetsComplete()
        }
    }
    private var searchPlanetResults = [StarWarsPlanet]() {
        didSet {
            delegate?.fetchPlanetsComplete()
        }
    }
    
    private var nextURL: String? = nil
    private var isFetchingInProgress = false
    private var firstAPICall = true
    
    init(delegate: PlanetsViewModelDelegate) {
        self.delegate = delegate
    }
    
    public var currentArrCount: Int {
        return starWarsPlanets.count
    }
    public var searchCount: Int {
        return searchPlanetResults.count
    }
    
    public var isNextPageExist: Bool {
        if let _ = nextURL { return true }
        return false
    }
    
    public func planet(at index: Int) -> StarWarsPlanet {
        return starWarsPlanets[index]
    }
    public func searchPlanet(at index: Int) -> StarWarsPlanet {
        return searchPlanetResults[index]
    }
    
    public func fetchPlanets() {
        guard !isFetchingInProgress else { return }
        guard isNextPageExist || firstAPICall else { return }
        firstAPICall = false
        isFetchingInProgress = true
        
        StarWarsAPIClient.getStarWarsPlanets(nextPageURL: nextURL, searchKey: nil) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.isFetchingInProgress = false
                self?.delegate?.fetchPlanetsFail(error: error)
            case .success(let planetsData):
                self?.isFetchingInProgress = false
                self?.nextURL = planetsData.next
                let planets = planetsData.results
                self?.starWarsPlanets.append(contentsOf: planets)
            }
        }
    }
    public func searchPlanets(keyword: String) {
        guard !isFetchingInProgress else { return }
        isFetchingInProgress = true
        
        StarWarsAPIClient.getStarWarsPlanets(nextPageURL: nil, searchKey: keyword) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.isFetchingInProgress = false
                self?.delegate?.fetchPlanetsFail(error: error)
            case .success(let planetsData):
                self?.isFetchingInProgress = false
                let planets = planetsData.results
                self?.searchPlanetResults = planets
            }
        }
    }
}

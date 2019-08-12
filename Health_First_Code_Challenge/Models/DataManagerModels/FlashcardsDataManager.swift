//
//  FlashcardsDataManager.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/12/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

final class FlashcardsDataManager {
    private init() { }
    
    private static let filename = Constants.flashCardsPListName
    private static var flashCards = [Flashcard]()
    
    public static func fetchFlashcards() -> [Flashcard] {
        let path = DataPersistenceManager.filepathToDocumentsDiretory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    flashCards =  try PropertyListDecoder().decode([Flashcard].self, from: data)
                } catch {
                    print(AppError.propertyListDecodingError(error).errorMessage())
                }
            } else {
                print("Data is nil")
            }
        } else {
            print("\(filename) does not exist")
        }
        return flashCards
    }
    
    private static func save() {
        let path = DataPersistenceManager.filepathToDocumentsDiretory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(flashCards)
            try data.write(to: path, options: .atomic)
        } catch {
            print(AppError.propertyListEncodingError(error).errorMessage())
        }
    }

    public static func addNewFlashcard(flashcard: Flashcard) {
        flashCards.append(flashcard)
        save()
    }

    public static func deleteFlashcard(atIndex index: Int) {
        flashCards.remove(at: index)
        save()
    }
}

//
//  String+Ext.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 12/01/2025.
//

import Foundation

extension String {
    var trimmed: Self {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func getAcronym() -> String {
        guard !self.trimmed.isEmpty else { return "" }

        let array = self.trimmed.components(separatedBy: .whitespaces)
        
        let result = array.reduce("") { (acronym, word) -> String in
            guard let firstCharacter = word.first else { return acronym }
            return acronym + String(firstCharacter)
        }
        
        return String(result.prefix(3)).uppercased()
    }
}

//
//  DataParser.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 08/01/2025.
//

import Foundation

struct DataParser {
    private var jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
    }
    
    func parse<T: Decodable>(data: Data) throws -> T {
        try jsonDecoder.decode(T.self, from: data)
    }
}

//
//  URLExtension.swift
//  Marshal
//
//  Created by Christopher Perkins on 12/29/18.
//
// Taken directly from http://basememara.com/updating-query-string-parameters-in-swift/
// Big thank you to Basem Emara!

import Foundation

extension URL {
    
    /**
     Add, update, or remove a query string parameters from the URL
     
     - parameter url:   the URL
     - parameter values: the dictionary of query string parameters to replace
     
     - returns: the URL with the mutated query string
     */
    internal func withQueryItems(_ contentsOf: [String: Any?]) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString), !contentsOf.isEmpty else {
            return URL(string: absoluteString)!
        }
        
        let keys = contentsOf.keys.map { $0.lowercased() }
        
        urlComponents.queryItems = urlComponents.queryItems?
            .filter { !keys.contains($0.name.lowercased()) } ?? []
        
        urlComponents.queryItems?.append(contentsOf: contentsOf.compactMap {
            guard let value = $0.value else { return nil } //Skip if nil
            return URLQueryItem(name: $0.key, value: "\(value)")
        })
        
        return URL(string: urlComponents.string ?? absoluteString)!
    }
}

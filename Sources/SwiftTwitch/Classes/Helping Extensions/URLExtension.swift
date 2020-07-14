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
    internal func withQueryItems(_ items: [String: Any?]) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString), !items.isEmpty else {
            return URL(string: absoluteString)!
        }

        urlComponents.queryItems = []
        var queryItems = [URLQueryItem]()
        for item in items {
            guard let value = item.value else { continue }
            if let valueArray = value as? [Any] {
                queryItems.append(contentsOf: valueArray.map {
                    URLQueryItem(name: item.key, value: "\($0)")
                })
            }  else {
                queryItems.append(URLQueryItem(name: item.key, value: "\(value)"))
            }
        }
        urlComponents.queryItems = queryItems

        return URL(string: urlComponents.string ?? absoluteString)!
    }
}

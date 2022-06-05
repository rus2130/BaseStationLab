//
//  ParserHelper.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation
import SwiftSoup

class ParserHelper {
    private func getHtmlFor(url: URL) async -> String? {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpShouldHandleCookies = false
        let session = URLSession.init(configuration: URLSessionConfiguration.default)
        return await withUnsafeContinuation { continuation in
            session.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    continuation.resume(returning: nil)
                    return
                }
                
                guard let contents = String(data: data, encoding: .utf8) else {
                    continuation.resume(returning: nil)
                    return
                }
                
                continuation.resume(returning: contents)
            }
            .resume()
        }
    }
    
    public func parseBases(url: URL) async -> [[String]] {
        guard let htmlData = await getHtmlFor(url: url) else { return [] }
        
        do {
            var preparedBasesString = [[String]]()
            let doc = try SwiftSoup.parse(htmlData)
            let tableData = try doc.select("tbody").select("tr")
            
            for tableRow in tableData {
                var prepareTableRow = [String]()
                for tableCell in try tableRow.select("td") {
                    prepareTableRow.append(try tableCell.text())
                }
                preparedBasesString.append(prepareTableRow)
            }
            return preparedBasesString
        } catch {
            return []
        }
    }
    
    public func parsePagesCount(url: URL) async -> Int? {
        guard let htmlData = await getHtmlFor(url: url) else { return nil }
        
        do {
            let doc = try SwiftSoup.parse(htmlData)
            let rowData = try doc.select("ul.pagination").select("li")
            for (cellIndex, rowCell) in rowData.enumerated() {
                 if cellIndex == rowData.count - 2 {
                     if let pagesCount = Int(try rowCell.text()) {
                         return pagesCount
                     } else {
                         return nil
                     }
                 }
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
        return nil
    }
}

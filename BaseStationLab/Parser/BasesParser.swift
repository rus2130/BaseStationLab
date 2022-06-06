//
//  BasesParser.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation

class BasesParser {
    private var technology: DetailTechnolody
    private var urlStart = "https://www.ucrf.gov.ua/ua/services/centralized-registries?permission_num=&region=&technology="
    private var urlEnd = "&search=&per_page=200&page="
    
    private var parsedTableData = [[String]]()
    
    private var parserHelper = ParserHelper()
    
    init(detailTechnolody: DetailTechnolody) {
        self.technology = detailTechnolody
    }
    
    public func startParse() async -> [[String]] {
        return await withCheckedContinuation { continuation in
            Task {
                guard let startURL = getParseUrl(currentPage: 1) else { return }
                guard let pagesCount = await parserHelper.parsePagesCount(url: startURL) else { return }
                
                var preparedBases = [[String]]()
                print("[Parser][\(technology)] starting parse...")
                
                await (1...pagesCount).concurrentForEach { currentPage in
                    guard let currentURL = self.getParseUrl(currentPage: currentPage) else { return }
                    let bases = await self.parserHelper.parseBases(url: currentURL)
                    preparedBases.append(contentsOf: bases)
                    debugPrint("[Parser][\(self.technology.rawValue)] parsing: \(currentPage)")
                }
                
                print("[Parser][\(technology)] parse finished, bases count: \(preparedBases.count)")
                continuation.resume(returning: preparedBases)
            }
        }
    }
    
    private func getParseUrl(currentPage: Int) -> URL? {
        let prepareUrlString = urlStart + technology.rawValue + urlEnd + "\(currentPage)"
        let returnUrl = URL(string: prepareUrlString)
        
        return returnUrl
    }
}

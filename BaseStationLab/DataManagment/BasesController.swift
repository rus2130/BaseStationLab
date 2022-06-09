//
//  BasesController.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation

class LoadingState: ObservableObject {
    static let shared = LoadingState()
    
    private init() { }
    
    @Published var pagesParsed = 0
    @Published var pagesCount = 0
    @Published var loadingProgress = -1
    
    let parseGroup = DispatchGroup()
    
    public func incrementParsedPages() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.parseGroup.enter()
            self.pagesParsed += 1
            self.calculateProgress()
            self.parseGroup.leave()
        }
    }
    
    public func setupPagesCount(completion: @escaping () -> ()) {
        Task {
            await DetailTechnolody.allCases.concurrentForEach { technolody in
                let parser = BasesParser(detailTechnolody: technolody)
                let pagesCount = await parser.pagesCount()
                self.incrementPagesCount(pagesCount)
            }
            completion()
        }
    }
    
    private func incrementPagesCount(_ count: Int) {
        parseGroup.enter()
        pagesCount += count
        parseGroup.leave()
    }
    
    private func calculateProgress() {
        loadingProgress = Int((Double(pagesParsed) / Double(pagesCount)) * 100)
    }
}

class BasesController {
    let database = Database()
    let loadingState = LoadingState.shared
    
    public func checkBasesStatus(completion: @escaping () -> ()) {
        database.getBasesCount { basesCount in
            if basesCount == 0 {
                self.loadingState.setupPagesCount {
                    self.startParse(completion: completion)
                }
            } else {
                completion()
            }
        }
    }
    
    private func startParse(completion: @escaping () -> ()) {
        Task.detached(priority: .userInitiated) {
            var bases = [[String]]()
            
            for detailTechonoly in Technolody.all.detailTechologies {
                let parser = BasesParser(detailTechnolody: detailTechonoly)
                
                bases.append(contentsOf: await parser.startParse())
            }
            
            self.updateDatabase(data: bases, completion: completion)
        }
    }
    
    private func updateDatabase(data: [[String]], completion: @escaping () -> ()) {
        let bases = ParseMapper.getBaseStationsFrom(data: data)
        database.save(baseStations: bases, completion: completion)
    }
}

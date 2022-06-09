//
//  StartViewModel.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation
import RealmSwift
import Combine

class StartViewModel: ObservableObject {
    @Published var providerModels = [StartCellModel]()
    @Published var currentTechnolody = Technolody.lte { didSet {
        updateCurrentTechnolody()
    }}
    @Published var currentDetailTechnolody = DetailTechnolody.all
    @Published var showingFilterSheet = false
    @Published var isLoading = true
    @Published var loadingProgress = -1
    
    private let loadingState = LoadingState.shared
    private var cancellables = Set<AnyCancellable>()
    
    private var currentTecholodyFilter: String {
        guard currentDetailTechnolody != .all else { return currentTechnolody.filterValue }
        
        return currentDetailTechnolody.rawValue
    }
    
    private let database = Database()
    
    init() {
        setupLoading()
    }
    
    public func updateDetailTechnolody(technolody: DetailTechnolody) {
        currentDetailTechnolody = technolody
        getProviderModels()
    }
    
    public func getProviderModels() {
        DispatchQueue.main.async { self.isLoading = true }
        
        database.getBases { [weak self] bases in
            guard let self = self, !bases.isEmpty else { return }
            let filteredBases = bases.filteredBy(technology: self.currentTecholodyFilter)
            
            let availableProviders = filteredBases.getAvailableProviders()
            let preparedProviderModels = availableProviders
                .compactMap { self.createProviderModel($0, bases: bases) }
                .sorted { $0.baseStationsCount > $1.baseStationsCount }
            
            DispatchQueue.main.async {
                self.providerModels = preparedProviderModels
                self.isLoading = false
            }
        }
    }
    
    public func getNavigationTitle() -> String {
        guard loadingProgress == -1 || loadingProgress == 100 else {
            return "Завантаженя... \(loadingProgress)%"
        }
        guard currentDetailTechnolody != .all else { return currentTechnolody.rawValue }
        return currentDetailTechnolody.title
    }
    
    private func createProviderModel(_ provider: Provider, bases: Results<BaseStation>) -> StartCellModel? {
        guard provider != .invalid else { return nil }
        
        let filteredBases = bases.filteredBy(
            provider: provider.rawValue,
            technology: currentTecholodyFilter
        )
        
        let cellModel = DataMapper.basesToStartViewCellModel(bases: filteredBases)
        
        return cellModel
    }
    
    private func updateCurrentTechnolody() {
        NavigationController.shared.filters.update(technolody: currentTechnolody)
        currentDetailTechnolody = .all
        getProviderModels()
    }
    
    private func setupLoading() {
        loadingState.$loadingProgress
            .assign(to: \.loadingProgress, on: self)
            .store(in: &cancellables)
    }
}

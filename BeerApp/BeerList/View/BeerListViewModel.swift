//
//  BeerListViewModel.swift
//  BeerApp
//
//  Created by Joaquín Corugedo Rodríguez on 18/8/23.
//

import Foundation


final class BeerListViewModel: ObservableObject {
    
    private var networkModel: NetworkModel
    
    @Published var beerList: [BeerModel] = []
    
    init(networkModel: NetworkModel = NetworkModel()) {
        self.networkModel = networkModel
    }
    
    func getBeers(beerName: String? = nil) {
        
        networkModel.getBeers(beerName: beerName) { [weak self] beerList, error in
            
            if let error {
                print(error.localizedDescription)
            }else {
                self?.beerList = beerList
            }

        }
    }
    
}

//
//  HomeViewModel.swift
//  Listen24-7
//
//  Created by IREM SEVER on 21.03.2024.
//

import Foundation

class HomeViewModel {
    private var homeWebservice = HomeWebservice()
    private var home: [HomeModel] = []
    
    func fetchHomeData(completion: @escaping() -> ()) {
        homeWebservice.getHomeData { [weak self] result in
            switch result {
            case .success(let homeData):
                self?.home = homeData.data
                completion()
            case .failure(let error):
                print("Error processing JSON data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return home.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> HomeModel
    {
        return home[indexPath.row]
    }
}

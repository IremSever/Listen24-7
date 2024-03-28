//
//  HomeViewModel.swift
//  Listen24-7
//
//  Created by IREM SEVER on 21.03.2024.
//

import Foundation

class HomeViewModel {
    private var homeWebservice = HomeWebservice()
    private var isHomeDataFetched = false
    
    var home: [Response] = []
    
    func fetchHomeData(completion: @escaping () -> ()) {
        homeWebservice.postHomeData { [weak self] result in
            switch result {
            case .success(let homeData):
                self?.home = homeData.data.list?.response ?? []
                self?.isHomeDataFetched = true
                if self?.isHomeDataFetched == true {
                    completion()
                }
            case .failure(let error):
                print("Error processing home JSON data: \(error)")
            }
        }
    }

    
    func numberOfRowsInSection(section: Int) -> Int {
        print(home.count)
        return home.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Response {
        return home[indexPath.row]
    }
}

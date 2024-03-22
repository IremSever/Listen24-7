//
//  HomeViewModel.swift
//  Listen24-7
//
//  Created by IREM SEVER on 21.03.2024.
//

import Foundation

class HomeViewModel {
    private var homeWebservice = HomeWebservice()
    private var headerWebservice = HeaderWebservice()
    private var home: [Response] = []
    private var header: [HeaderResponse] = []
    
    func fetchHomeData(completion: @escaping () -> ()) {
        homeWebservice.getHomeData { [weak self] result in
            switch result {
            case .success(let homeData):
                self?.home = homeData.data.list.response
                completion()
            case .failure(let error):
                print("Error processing home JSON data: \(error)")
            }
        }
    }
    
    func fetchHeaderData(completion: @escaping () -> ()) {
        headerWebservice.getHeaderData { [weak self] result in
            switch result {
            case .success(let headerData):
                self?.header = headerData.data.news.response
                completion()
            case .failure(let error):
                print("Error processing header JSON data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return home.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Response {
        return home[indexPath.row]
    }
}

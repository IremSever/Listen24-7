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
    private var isHeaderDataFetched = false
    private var isHomeDataFetched = false
    
    var home: [Response] = []
    var header: [HeaderResponse] = []
    
    func fetchData(completion: @escaping () -> ()) {
        headerWebservice.getHeaderData { [weak self] result in
            switch result {
            case .success(let headerData):
                self?.header = headerData.data.news.response ?? []
                self?.isHeaderDataFetched = true
                if self?.isHomeDataFetched == true {
                    completion()
                }
            case .failure(let error):
                print("Error processing header JSON data: \(error)")
            }
        }
        
        homeWebservice.getHomeData { [weak self] result in
            switch result {
            case .success(let homeData):
                self?.home = homeData.data.list.response
                self?.isHomeDataFetched = true
                if self?.isHeaderDataFetched == true {
                    completion()
                }
            case .failure(let error):
                print("Error processing home JSON data: \(error)")
            }
        }
    }
}

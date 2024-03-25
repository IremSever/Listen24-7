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
    var home: [Response] = []
    var header: [HeaderResponse] = []
    
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
                self?.header = headerData.data.news.response ?? []
                completion()
            case .failure(let error):
                print("Error processing header JSON data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if section == 0 {
            return header.count
        } else {
            return home.count
        }
    }
    
    func headerTitle() -> String {
        if let title = header.first?.title {
            return title
        } else {
            return "No Title"
        }
    }
    
    func homeName() -> String {
        if let name = home.first?.name {
            return name
        } else {
            return "No Name"
        }
    }
    
    func titleForHeaderInSection(section: Int) -> String? {
        if section == 0 {
            return headerTitle()
        } else {
            return homeName()
        }
    }
    
    func numberOfSections() -> Int {
        return 2
    }
}

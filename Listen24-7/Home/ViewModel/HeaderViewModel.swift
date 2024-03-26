//
//  HeaderViewModel.swift
//  Listen24-7
//
//  Created by İrem Sever on 26.03.2024.
//

import Foundation

class HeaderViewModel {
    private var headerWebservice = HeaderWebservice()
    private var isHeaderDataFetched = false
    
    var header: [HeaderResponse] = []
    
    func fetchHeaderData(completion: @escaping () -> ()) {
        headerWebservice.getHeaderData { [weak self] result in
            switch result {
            case .success(let headerData):
                self?.header = headerData.data.news.response ?? []
                self?.isHeaderDataFetched = true
                if self?.isHeaderDataFetched == true {
                    completion()
                }
            case .failure(let error):
                print("Error processing header JSON data: \(error)")
            }
        }
       
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return header.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> HeaderResponse {
        return header[indexPath.row]
    }
}

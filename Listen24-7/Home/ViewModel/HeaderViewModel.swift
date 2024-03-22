//
//  HeaderViewModel.swift
//  Listen24-7
//
//  Created by IREM SEVER on 21.03.2024.
//

import Foundation

class HeaderViewModel {
    private var headerWebservice = HeaderWebservice()
    private var header: [HeaderResponse] = []
    
    func fetchHeaderData(completion: @escaping() -> ()) {
        headerWebservice.getHeaderData { [weak self] result in
            switch result {
            case .success(let headerData):
                self?.header = headerData.data
                completion()
            case .failure(let error):
                print("Error processing JSON data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return header.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> HeaderModel
    {
        return header[indexPath.row]
    }
}

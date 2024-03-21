//
//  HomeViewModel.swift
//  Listen24-7
//
//  Created by İrem Sever on 10.03.2024.
//

import Foundation

/*class HomeViewModel {
    var responseData = [Response]()
    
    func parseJSON(_ name: String, completion: @escaping (Bool) -> Void) {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {
            print("Not found json file")
            completion(false)
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(AppModel.self, from: data)
            
            handleResponse(response)
            completion(true)
        } catch {
            print("JSON conversion error: \(error)")
            completion(false)
        }
    }
    
    func handleResponse(_ response: AppModel) {
        self.responseData = response.app.response
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return cellData(forSection: section).count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Response {
        return cellData(forSection: indexPath.section)[indexPath.row]
    }
    
    func cellData(forSection section: Int) -> [Response] {
        guard section < responseData.count else {
            return []
        }
        return [responseData[section]]
    }
}*/


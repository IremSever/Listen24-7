//
//  HeaderWebservice.swift
//  Listen24-7
//
//  Created by IREM SEVER on 21.03.2024.
//

import Foundation

class HeaderWebservice {
    func getHeaderData(completion: @escaping (Result<HeaderModel, Error>) -> Void) {
        let headerURL = "https://api.tmgrup.com.tr/v1/link/1073"
        guard let url = URL(string: headerURL) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Header Response")
                return
            }
            
            print("Header Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Header Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(HeaderModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}

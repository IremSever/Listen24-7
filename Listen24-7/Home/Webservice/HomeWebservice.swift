//
//  HomeWebService.swift
//  Listen24-7
//
//  Created by IREM SEVER on 21.03.2024.
//

import Foundation

class HomeWebservice {
    func getHomeData(completion: @escaping (Result<HomeModel, Error>) -> Void) {
        let homeURL = "https://api.tmgrup.com.tr/v1/link/1068"
        guard let url = URL(string: homeURL) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Home Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Home Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(HomeModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}

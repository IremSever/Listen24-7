//
//  PlaylistWebservice.swift
//  Listen24-7
//
//  Created by İrem Sever on 3.04.2024.
//

import Foundation

class PlaylistWebservice {
    func postPlaylistData(playlistId: String, completion: @escaping (Result<PlaylistModel, Error>) -> Void) {
        let playlistURL = "https://.....id=\(playlistId)"
        guard let url = URL(string: playlistURL) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Playlist Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Playlist Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PlaylistModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}

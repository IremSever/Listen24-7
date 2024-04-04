//
//  PlaylistViewModel.swift
//  Listen24-7
//
//  Created by İrem Sever on 3.04.2024.
//

import Foundation
class PlaylistViewModel {
    private var playlistWebservice = PlaylistWebservice()
    private var isPlaylistDataFetched = false
    
    var playlist: [PlaylistResponse] = []
    
    func fetchPlaylistData(completion: @escaping ([PlaylistResponse]?) -> ()) {
        playlistWebservice.postHomeData { [weak self] result in
            switch result {
            case .success(let playlistData):
                self?.playlist = playlistData.data.list.response ?? []
                self?.isPlaylistDataFetched = true
                if self?.isPlaylistDataFetched == true {
                    completion(self?.playlist)
                }
            case .failure(let error):
                print("Error processing home JSON data: \(error)")
                completion(nil)
            }
        }
    }
    
    
    func numberOfRowsInSection(section: Int) -> Int {
        return playlist.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> PlaylistResponse {
        return playlist[indexPath.row]
    }
}

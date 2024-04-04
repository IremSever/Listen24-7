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
    
    func fetchPlaylistData(completion: @escaping () -> ()) {
        playlistWebservice.postHomeData { [weak self] result in
            switch result {
            case .success(let playlisData):
                self?.playlist = playlisData.data.list.response
                self?.isPlaylistDataFetched = true
                if self?.isPlaylistDataFetched == true {
                    completion()
                }
            case .failure(let error):
                print("Error processing home JSON data: \(error)")
            }
        }
    }

    
    func numberOfRowsInSection(section: Int) -> Int {
        print(playlist.count)
        return playlist.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> PlaylistResponse {
        return playlist[indexPath.row]
    }
}

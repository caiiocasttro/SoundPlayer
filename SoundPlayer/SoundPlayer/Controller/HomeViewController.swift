//
//  HomeViewController.swift
//  SoundPlayer
//
//  Created by Caio Chaves on 26.07.23.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: Properties
    var SongTableViewCellIdentifier = "SongTableViewCell"
    
    var songs: [MusicModel] = []
    
    var tracks: [MusicModel] = []
    
    private lazy var songsTableView: UITableView = {
        let table = UITableView()
        table.register(SongTableViewCell.self, forCellReuseIdentifier: SongTableViewCellIdentifier)
        table.separatorStyle = .none
        return table
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureArray()
        songsTableView.delegate = self
        songsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        songsTableView.frame = view.bounds
    }
    
    //MARK: Configuring
    private func configureLayout() {
        view.backgroundColor = .systemBackground
        
        self.title = "My Songs"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(songsTableView)
    }
    
    //MARK: Adding the songs to the array
    private func configureArray() {
        songs.append(contentsOf:
                        [MusicModel(title: "MTV VMA Medley", image: "cover", singer: "Rihanna", track: "Medley"),
                         MusicModel(title: "Rude Boy VMA 2016", image: "cover", singer: "Rihanna", track: "RudeBoy")
                        ])
        
        tracks.append(contentsOf: [
        MusicModel(title: nil, image: nil, singer: nil, track: "Medley"),
        MusicModel(title: nil, image: nil, singer: nil, track: "RudeBoy")
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCellIdentifier, for: indexPath) as? SongTableViewCell else {
            return UITableViewCell() }
        cell.image = songs[indexPath.row].image
        cell.title = songs[indexPath.row].title
        cell.singerName = songs[indexPath.row].singer
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let track = indexPath.row
        
        let vc = PlayerViewController()
        vc.image = songs[indexPath.row].image
        vc.music = songs[indexPath.row].title
        vc.track = track
        vc.tracks = songs
        vc.sheetPresentationController?.prefersGrabberVisible = true
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
    
}

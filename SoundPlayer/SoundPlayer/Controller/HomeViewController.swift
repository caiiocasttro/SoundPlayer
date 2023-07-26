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
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCellIdentifier, for: indexPath) as? SongTableViewCell else {
            return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = PlayerViewController()
        vc.sheetPresentationController?.prefersGrabberVisible = true
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
        
        
    }
    
}

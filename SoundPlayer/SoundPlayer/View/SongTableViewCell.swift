//
//  SongTableViewCell.swift
//  SoundPlayer
//
//  Created by Caio Chaves on 26.07.23.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    //MARK: Properties
    var identifier = "SongTableViewCell"
    
    var image: String? {
        didSet {
            guard let string = image else { return }
            cover.image = UIImage(named: string)
        }
    }
    
    var title: String? {
        didSet {
            guard let string = title else { return }
            titleSong.text = string
        }
    }
    
    var singerName: String? {
        didSet {
            guard let string = singerName else { return }
            singer.text = string
        }
    }
    
    private lazy var shadow: UIView = {
        let shadow = UIView()
        shadow.layer.shadowColor = UIColor(red: 0.078, green: 0.129, blue: 0.239, alpha: 0.25).cgColor
        shadow.layer.shadowRadius = 4
        shadow.layer.shadowOpacity = 0.5
        shadow.layer.shadowOffset = CGSize(width: 0, height: 0)
        return shadow
    }()
    
    private lazy var cover: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cover")
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var titleSong: UILabel = {
        let label = UILabel()
        label.text = "MTV VMA Medley"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.label
        return label
    }()
    
    private lazy var singer: UILabel = {
        let singer = UILabel()
        singer.text = "Rihanna"
        singer.font = .systemFont(ofSize: 16, weight: .regular)
        singer.textColor = UIColor.label
        return singer
    }()
    
    //MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: configuring layout
    private func configureLayout() {
        
        //Adding subview
        addSubview(shadow)
        shadow.addSubview(cover)
        addSubview(titleSong)
        addSubview(singer)
        
        shadow.translatesAutoresizingMaskIntoConstraints = false
        cover.translatesAutoresizingMaskIntoConstraints = false
        titleSong.translatesAutoresizingMaskIntoConstraints = false
        singer.translatesAutoresizingMaskIntoConstraints = false
        
        //Adding constraints
        NSLayoutConstraint.activate([
            
            shadow.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            shadow.widthAnchor.constraint(equalToConstant: 60),
            shadow.heightAnchor.constraint(equalToConstant: 60),
            
            cover.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cover.widthAnchor.constraint(equalToConstant: 60),
            cover.heightAnchor.constraint(equalToConstant: 60),
            
            titleSong.topAnchor.constraint(equalTo: cover.topAnchor, constant: 10),
            titleSong.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: 10),
            
            singer.topAnchor.constraint(equalTo: titleSong.bottomAnchor, constant: 5),
            singer.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: 10)
            
        ])
        
    }
    
}

//
//  ViewController.swift
//  SoundPlayer
//
//  Created by Caio Chaves on 25.07.23.
//

// Download the songs
// Model with the songs
// Model (name, image, singer)
// AVFoundation
// Create the UI Design
// Create the cell
// Create the viewController

import UIKit

class PlayerViewController: UIViewController {
    
    //MARK: Proprieties
    private var background: UIImageView = {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let background = UIImageView()
        background.image = UIImage(named: "Background")
        background.frame = .init(x: 0, y: 0, width: width, height: height)
        background.contentMode = .scaleAspectFill
        return background
    }()
    
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
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var titleSong: UILabel = {
        let label = UILabel()
        label.text = "MTV VMA Medley"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.white
        return label
    }()
    
    private lazy var singer: UILabel = {
        let singer = UILabel()
        singer.text = "Rihanna"
        singer.font = .systemFont(ofSize: 20, weight: .regular)
        singer.textColor = UIColor.white
        return singer
    }()
    
    private lazy var plus: UIButton = {
        let button = UIButton()
        button.frame = .init(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "Ellipsis")?.withTintColor(UIColor.white), for: .normal)
        button.setTitleColor(UIColor.systemGray6, for: .normal)
        //
        return button
    }()
    
    private var progressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = UIColor.systemGray6.withAlphaComponent(0.3)
        view.progressTintColor = UIColor.white
        view.progressViewStyle = .bar
        view.setProgress(0.5 / 60, animated: true)
        view.layer.cornerRadius = 1
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backward"), for: .normal)
        return button
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.setImage(UIImage(named: "pause"), for: .selected)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "forward"), for: .normal)
        return button
    }()
    
    private lazy var volumeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "speaker.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.systemGray6.withAlphaComponent(0.3))
//        image.frame = .init(x: 0, y: 0, width: 5, height: 5)
        return image
    }()
    
    private lazy var volumeProgress: UIProgressView = {
        let progress = UIProgressView()
        progress.trackTintColor = UIColor.systemGray6.withAlphaComponent(0.3)
        progress.progressTintColor = UIColor.white
        progress.progressViewStyle = .bar
        progress.setProgress(0.5 / 60, animated: true)
        progress.layer.cornerRadius = 1
        progress.clipsToBounds = true
        return progress
    }()
    
    private lazy var volumeImageII: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "speaker.wave.3.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.systemGray6.withAlphaComponent(0.3))
//        image.frame = .init(x: 0, y: 0, width: 5, height: 5)
        return image
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: Configuring layout
    private func configureLayout() {
        
        //Adding subview
        view.addSubview(background)
        view.sendSubviewToBack(background)
        view.addSubview(shadow)
        shadow.addSubview(cover)
        view.addSubview(titleSong)
        view.addSubview(singer)
        view.addSubview(plus)
        view.addSubview(progressView)
        view.addSubview(backButton)
        view.addSubview(playButton)
        view.addSubview(nextButton)
        view.addSubview(volumeImage)
        view.addSubview(volumeProgress)
        view.addSubview(volumeImageII)
        
        shadow.translatesAutoresizingMaskIntoConstraints = false
        cover.translatesAutoresizingMaskIntoConstraints = false
        titleSong.translatesAutoresizingMaskIntoConstraints = false
        singer.translatesAutoresizingMaskIntoConstraints = false
        plus.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        volumeImage.translatesAutoresizingMaskIntoConstraints = false
        volumeProgress.translatesAutoresizingMaskIntoConstraints = false
        volumeImageII.translatesAutoresizingMaskIntoConstraints = false
        
        //Adding constraints
        NSLayoutConstraint.activate([
            
            //Shadow
            shadow.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            shadow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shadow.widthAnchor.constraint(equalToConstant: 350),
            shadow.heightAnchor.constraint(equalToConstant: 350),
            
            //Cover
            cover.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            cover.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cover.widthAnchor.constraint(equalToConstant: 350),
            cover.heightAnchor.constraint(equalToConstant: 350),
            
            //Title song
            titleSong.topAnchor.constraint(equalTo: shadow.bottomAnchor, constant: 40),
            titleSong.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            //Singer
            singer.topAnchor.constraint(equalTo: titleSong.bottomAnchor, constant: 0),
            singer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            //Plus button
            plus.topAnchor.constraint(equalTo: cover.bottomAnchor, constant: 50),
            plus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            //ProgressView
            progressView.topAnchor.constraint(equalTo: singer.bottomAnchor, constant: 30),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressView.heightAnchor.constraint(equalToConstant: 2),
            
            // Backward button
            backButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 50),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            // Play / Pause
            playButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Forward button
            nextButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 50),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            //Volume image
            volumeImage.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 50),
            volumeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            volumeImage.widthAnchor.constraint(equalToConstant: 15),
            volumeImage.heightAnchor.constraint(equalToConstant: 15),
            
            //Volume Progress bar
            volumeProgress.centerYAnchor.constraint(equalTo: volumeImage.centerYAnchor),
            volumeProgress.leadingAnchor.constraint(equalTo: volumeImage.trailingAnchor, constant: 5),
            volumeProgress.trailingAnchor.constraint(equalTo: volumeImageII.leadingAnchor, constant: -5),
            
            //Volume image II
            volumeImageII.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 50),
            volumeImageII.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            volumeImageII.widthAnchor.constraint(equalToConstant: 20),
            volumeImageII.heightAnchor.constraint(equalToConstant: 15)
            
            
        ])
        
    }
    
}

extension UIImage
{
    func scale(newWidth: CGFloat) -> UIImage
    {
        guard self.size.width != newWidth else{return self}
        
        let scaleFactor = newWidth / self.size.width
        
        let newHeight = self.size.height * scaleFactor
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
}


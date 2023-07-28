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

import AVFoundation
import UIKit

class PlayerViewController: UIViewController {
    
    //MARK: Proprieties
    var image: String? {
        didSet {
            guard let string = image else { return }
            cover.image = UIImage(named: string)
        }
    }
    
    var music: String? {
        didSet {
            guard let string = music else { return }
            titleSong.text = string
        }
    }
    
    var singerName: String? {
        didSet {
            guard let string = singerName else { return }
            singer.text = string
        }
    }
    
    var player: AVAudioPlayer?
    
    var currentTimeP: Float = 0.0
    
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
        view.setProgress( 0.5 / 60, animated: true)
        view.layer.cornerRadius = 1
        view.clipsToBounds = true
        return view
    }()
    
    private var duration: UILabel = {
        let label = UILabel()
        label.text = "0:00"
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = UIColor.white
        return label
    }()
    
    private var currentTime: UILabel = {
        let label = UILabel()
        label.text = "0:00"
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = UIColor.white
        return label
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
    
    private lazy var volumeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = UIColor.systemGray6.withAlphaComponent(0.3)
        slider.minimumValueImage = UIImage(systemName: "speaker.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.systemGray6.withAlphaComponent(0.3))
        slider.maximumValueImage = UIImage(systemName: "speaker.wave.3.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.systemGray6.withAlphaComponent(0.3))
        slider.tintColor = UIColor.white
        slider.thumbTintColor = UIColor.clear
        slider.layer.cornerRadius = 1
        slider.clipsToBounds = true
        return slider
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
        configureButton()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        if let player = player {
            player.stop()
        }
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
        view.addSubview(duration)
        view.addSubview(currentTime)
        view.addSubview(backButton)
        view.addSubview(playButton)
        view.addSubview(nextButton)
        view.addSubview(volumeSlider)
        
        shadow.translatesAutoresizingMaskIntoConstraints = false
        cover.translatesAutoresizingMaskIntoConstraints = false
        titleSong.translatesAutoresizingMaskIntoConstraints = false
        singer.translatesAutoresizingMaskIntoConstraints = false
        plus.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        duration.translatesAutoresizingMaskIntoConstraints = false
        currentTime.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
        
        //Adding constraints
        NSLayoutConstraint.activate([
            
            //Shadow
            shadow.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            shadow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shadow.widthAnchor.constraint(equalToConstant: 350),
            shadow.heightAnchor.constraint(equalToConstant: 350),
            
            //Cover
            cover.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
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
            
            //Durantion
            duration.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 5),
            duration.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            //CurrentTime
            currentTime.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 5),
            currentTime.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Backward button
            backButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 80),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            // Play / Pause
            playButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Forward button
            nextButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 80),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            //Volume Progress bar
            volumeSlider.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 80),
            volumeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            volumeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
    }
    
    private func configureButton() {
        
        //Play button
        playButton.addTarget(self, action: #selector(playDidTapped), for: .touchUpInside)
        
        // Slider
        volumeSlider.addTarget(self, action: #selector(sliderDidSet), for: .valueChanged)
        
    }
    
    //MARK: Configuring player
    public func configurePlayer(song name: String) {
        
        
        let urlString = Bundle.main.path(forResource: name, ofType: ".mp3")
        
        do {
            
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let url = urlString else { print("Something wrong with url")
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: url)!)
            
            guard let player = player else { print("Player not found")
                return
            }
            
            volumeSlider.value = 0.5
            player.volume = volumeSlider.value
            player.play()
            playButton.isSelected = true
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    //MARK: Buttons action
    @objc func playDidTapped() {
        
        if player?.isPlaying == true {
            player?.pause()
            playButton.isSelected = false
        } else {
            player?.play()
            playButton.isSelected = true
            
        }
        
    }
    
    @objc func sliderDidSet(_ slider: UISlider) {
        let value = slider.value
        player?.volume = value
        
    }
}



//
//  ProfileViewController.swift
//  chpark
//
//  Created by comsoft on 2017. 12. 1..
//  Copyright © 2017년 comsoft. All rights reserved.
//

import UIKit
import AVFoundation

var imageViewBackGround: UIImage?

class ProfileViewController: UIViewController, EditDelegate, AVAudioPlayerDelegate {
    var musicName : String = "01"
    var audioPlayer : AVAudioPlayer!
    var audioFile : URL!
    var progressTimer : Timer!
    let MAX_VOLUME : Float = 10.0
    let timePlayerSelector : Selector = #selector(ProfileViewController.updatePlayTime)
    
    @IBOutlet weak var imgViewBackGround: UIImageView!
    @IBOutlet weak var imgViewLandscape: UIImageView!
    @IBOutlet weak var imgViewPortrait: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNameEng: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var pvProgressPlay: UIProgressView!
    @IBOutlet weak var slVolume: UISlider!
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
    }
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
    }
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(true, pause: false, stop: false)
        progressTimer.invalidate()
    }
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        audioFile = Bundle.main.url(forResource: musicName, withExtension: "mp3")
        initPlay()
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
        if let img = imageViewBackGround {
            imgViewBackGround.image = img
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate()
        setPlayButtons(true, pause: false, stop: false)
    }
    
    func updatePlayTime() {
        lblCurrentTime.text = convertNSTimeInterval2String(audioPlayer.currentTime)
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
    
    func initPlay() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile) } catch let error as NSError {
                print("Error-initPlay : \(error)")
        }
        slVolume.maximumValue = MAX_VOLUME
        slVolume.value = 1.0
        pvProgressPlay.progress = 0
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = 1.5
        
        lblEndTime.text = convertNSTimeInterval2String(audioPlayer.duration)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
    }
    
    func setPlayButtons(_ play:Bool, pause:Bool, stop:Bool) {
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    func convertNSTimeInterval2String(_ time:TimeInterval) -> String {
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editProfileViewController = segue.destination as! EditProfileViewController
        
        editProfileViewController.imageLandscape = imgViewLandscape.image!
        editProfileViewController.imagePortrait = imgViewPortrait.image!
        editProfileViewController.textName = lblName.text!
        editProfileViewController.textNameEng = lblNameEng.text!
        editProfileViewController.textEmail = lblEmail.text!
        editProfileViewController.delegate = self
    }
    
    func didProfileEditDone(_ controller: EditProfileViewController, name: String, nameEng: String, email: String, profileMusic: String, landscape: UIImage, portrait:UIImage) {
        lblName.text = name
        lblNameEng.text = nameEng
        lblEmail.text = email
        musicName = profileMusic
        imgViewLandscape.image = landscape
        imgViewPortrait.image = portrait
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

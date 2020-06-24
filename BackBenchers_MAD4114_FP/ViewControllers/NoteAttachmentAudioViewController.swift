//
//  NoteAttachmentAudioViewController.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Kashyap Jhaveri on 2020-06-24.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//

import UIKit
import AVFoundation
class NoteAttachmentAudioViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var audioNoteTitle: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    var attachment:Attachment!
    
    var player:AVAudioPlayer!
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func initAudioPlayer() {
        do {
            print(attachment.filePath!)
            player = try AVAudioPlayer(contentsOf: attachment.filePath!)
            player.delegate = self
            player.prepareToPlay()
            player.volume = 1.0
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioNoteTitle.text = Date.getStringDate(dateFormate: "HH:mm E, d MMM y", date: attachment.timeStamp!)
        initAudioPlayer()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func playPauseButtonClick(_ sender: Any) {
        if player.isPlaying{
            player.pause()
            self.playPauseButton.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        }
        else{
            player.play()
            self.playPauseButton.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag{
            print("finish")
            self.playPauseButton.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        }
    }
}

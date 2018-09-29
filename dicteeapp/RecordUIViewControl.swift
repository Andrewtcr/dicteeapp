//
//  RecordUIViewControl.swift
//  demoone
//
//  Created by Yu Sun on 7/3/18.
//  Copyright © 2018 Yu Sun. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseDatabase
import FirebaseStorage

class RecordUIViewControl: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    @IBOutlet weak var numTextView: UILabel!
    @IBOutlet weak var answerTextView: UITextField!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    let storage = Storage.storage()
    var ref: DatabaseReference!
    var index: Int = 1

    
    var soundRecorder : AVAudioRecorder!
    var recordingSession: AVAudioSession!
    var SoundPlayer : AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        recordingSession = AVAudioSession.sharedInstance()
        ref = Database.database().reference()
        let storageRef = storage.reference()

        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord, mode: AVAudioSessionModeSpokenAudio, options: [])
            try recordingSession.setActive(true)
                recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        //
                        print("OK Ready to record")
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
        //setupRecorder()
    }
    
    @IBAction func onPlayClicked(_ sender: UIButton) {
        if sender.titleLabel?.text == "Play" {
            recordButton.isEnabled = false
            sender.setTitle("Stop", for: UIControlState.normal)
            preparePlayer()
            SoundPlayer.play()
        }
        else {
            SoundPlayer.stop()
            sender.setTitle("Play", for: UIControlState.normal)
        }
    }
    
    @IBAction func onRecordClicked(_ sender: UIButton) {
        if sender.titleLabel?.text == "Record"{
            setupRecorder()
            //soundRecorder.record()
            sender.setTitle("Stop", for: UIControlState.normal)
            playButton.isEnabled = false
        }
        else {
            soundRecorder.stop()
            sender.setTitle("Record", for: UIControlState.normal)
            playButton.isEnabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupRecorder() {
        let recordSettings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        do {
            soundRecorder = try AVAudioRecorder(url: audioFilename, settings: recordSettings)
            soundRecorder.delegate = self
            soundRecorder.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        soundRecorder.stop()
        soundRecorder = nil
        
        if success {
            recordButton.setTitle("Tap to Re-record", for: .normal)
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
            // recording failed :(
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func preparePlayer() {
        var error : NSError?
        do {
            let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
            SoundPlayer = try AVAudioPlayer(contentsOf: audioFilename)
        } catch {
            print("Failed to play")
        }
        if let err = error {
            NSLog("Failed to play")
        } else {
            SoundPlayer.delegate = self
            SoundPlayer.prepareToPlay()
            SoundPlayer.volume = 1.0
        }
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playButton.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
        playButton.setTitle("Play", for:UIControlState.normal)
    }
    
    
    @IBAction func onSubmitClicked(_ sender: UIButton) {
        // Create a root reference
        let storageRef = storage.reference()

        // Create a reference to "mountains.jpg"
        //let mountainsRef = storageRef.child("mountains.jpg")
        
        // Create a reference to 'images/mountains.jpg'
        //let mountainImagesRef = storageRef.child("images/mountains.jpg")
        
        // While the file names are the same, the references point to different files
        //mountainsRef.name == mountainImagesRef.name;            // true
        //mountainsRef.fullPath == mountainImagesRef.fullPath;    // false
        
        // File located on disk
        // let localFile = URL(string: "path/to/image")!
        let localFile = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("tests-audio/recording" + UUID().uuidString + ".m4a")
        
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putFile(from: localFile, metadata: nil)
        
        uploadTask.observe(.success) { snapshot in
            // Upload completed successfully
            print("Successfully uploaded!")
            riversRef.downloadURL { (url, error) in
                print(url)
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    print("Error in here")
                    return
                }
                print(downloadURL.absoluteString)
                var title = self.title!
                self.ref.child("myfirstios/" + title + "/" + String(self.index) + "/title").setValue(NSDate().timeIntervalSince1970)
                self.ref.child("myfirstios/" + title + "/" + String(self.index) + "/answer").setValue(self.answerTextView.text)
                self.ref.child("myfirstios/" + title + "/" + String(self.index) + "/url").setValue(downloadURL.absoluteString)
                self.index += 1
                self.numTextView.text = "Question " + String(self.index)
                // resetup all text
                self.answerTextView.text = ""
            }
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

}

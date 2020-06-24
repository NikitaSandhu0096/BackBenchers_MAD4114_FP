//
//  NewNoteViewController.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Nikita Sandhu on 2020-06-13.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation

class NewNoteViewController: UIViewController {
    
    let appDelegate = AppDelegate.getDelegate()
    var selectedSubject:Subjects?
    var selectedNote:Notes?
    
    private var selectedImages = [UIImage]()
    private var selectedAttachments = [Attachment]()
    
    
    var locationManager = CLLocationManager()
    var locationCoords : CLLocationCoordinate2D?
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteData: UITextView!
    
    @IBOutlet weak var recordButton: UIBarButtonItem!
    func initLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func checkForCamera() {
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            let alertController = UIAlertController.init(title: nil, message: "No camera available.", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setToolbarHidden(false, animated: true)
        noteData.becomeFirstResponder()
        // Do any additional setup after loading the view.
        //checkForCamera()
        initLocation()
    }
    
    func createNewNote() {
        let newNote = Notes(context: appDelegate.persistentContainer.viewContext)
        newNote.title = noteTitle.text
        newNote.data = noteData.text
        newNote.timestamp = Date()
        newNote.subject = selectedSubject
        newNote.lat = (locationCoords?.latitude ?? 0.0) as Double
        newNote.long = (locationCoords?.longitude ?? 0.0) as Double
        
        
        for image in selectedImages {
            let instance = Attachment(context: appDelegate.persistentContainer.viewContext)
                instance.data = image.pngData()
                instance.note = newNote
            newNote.addAttachment(a:instance)
        }
        
        appDelegate.saveContext()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let note = selectedNote{
            noteTitle.text = note.title
            noteData.text = note.data
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let note = selectedNote, let title = noteTitle.text, let data = noteData.text{
            note.title = title
            note.data = data
            note.timestamp = Date()
            
            appDelegate.saveContext()
        }
        else if selectedNote == nil{
            if !noteTitle.text!.isEmpty || !noteData.text!.isEmpty || !selectedImages.isEmpty{
                createNewNote()
            }
        }
    }
    
    @IBAction func choosePicture(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
                
        alert.addAction(.init(title: "Take a Picture", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .camera
                self.present(picker, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(.init(title: "Choose from Library", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .savedPhotosAlbum
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
            }
            
        }))
        
        alert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func initRecorder() {
        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { allowed in
                DispatchQueue.main.async {
                    if allowed {
                        
                    } else {
                       print("User declined the recorder permission")
                    }
                }
            }
        } catch {
            print("Failed to initialize recorder")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func startRecording(filePath:URL) {
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: filePath, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()

            recordButton.image = UIImage(systemName: "stop.circle.fill")
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil

        if success {
            recordButton.image = UIImage(systemName: "mic.fill")
        }
    }
    
    @IBAction func recoardAudio(_ sender: UIBarButtonItem) {
        initRecorder()
        if audioRecorder == nil {
            let audioFilename = getDocumentsDirectory().appendingPathComponent(UUID().uuidString.trimmingCharacters(in: .whitespacesAndNewlines) + ".m4a")
            startRecording(filePath: audioFilename)
        } else {
            if let note = selectedNote{
                let instance = Attachment(context: appDelegate.persistentContainer.viewContext)
                instance.filePath = audioRecorder.url
                instance.timeStamp = Date()
                instance.note = note
                note.addAttachment(a: instance)
            }
            else{
                let instance = Attachment(context: appDelegate.persistentContainer.viewContext)
                instance.filePath = audioRecorder.url
                selectedAttachments.append(instance)
            }
            
            finishRecording(success: true)
        }
    }
    
    
    @IBAction func attachmentsClick(_ sender: UIBarButtonItem) {
        if let note = selectedNote{
            let NoteAttachmentsVC = UIStoryboard.getViewController(identifier: "NotesAttachementCollectionViewController") as! NotesAttachementCollectionViewController
            if let atts = note.getAttachments()
            {
                NoteAttachmentsVC.attachments = atts
            }
            self.present(NoteAttachmentsVC, animated: true, completion: nil)
        }
        
    }
}

extension NewNoteViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userPickedImage = info[.editedImage] as? UIImage else { return }
        
        if let note = selectedNote{
            let instance = Attachment(context: appDelegate.persistentContainer.viewContext)
                instance.data = userPickedImage.pngData()
                instance.note = note
                instance.timeStamp = Date()
            note.addAttachment(a: instance)
        }
        else{
            selectedImages.append(userPickedImage)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}


extension NewNoteViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else {
            return
        }
        self.locationCoords = location
    }
}


extension NewNoteViewController: AVAudioRecorderDelegate{
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}

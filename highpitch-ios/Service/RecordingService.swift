//
//  RecordingService.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/12/24.
//

import Foundation
import AVFoundation

protocol RecorderDelegate {
    func recordingDidStart()
    func recordingDidEnd()
    func recordingCurrentTiming(_: String)
    func recordingDidPauseed()
    func recordingDidContinued()
}

protocol PlayerDelegate {
    func playerDidStart()
    func playerDidEnd()
}


class RecordingService {
    typealias RecorderVCD = AVAudioRecorderDelegate & RecorderDelegate
    typealias PlayerVCD = AVAudioPlayerDelegate & PlayerDelegate
    
    public static let audiosDirectoryName = "audio"
    // MARK: Merge용
    public static let recordingInitAudioURL = URL(
        string: "your_voice_is_recording.mp3",
        relativeTo: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    )!
    
    private var audioRecorder: AVAudioRecorder!
    private var audioPlayer : AVAudioPlayer!
    private var meterTimer: Timer!
    private var isAudioRecordingGranted: Bool!
    private var isRecording = false
    private var isPausedRecording = false
    private var isPlaying = false
    private var recorderDelegate: (any RecorderVCD)?
    private var playerDelegate: (any PlayerVCD)?
    var currentURL: URL?
    
    init() {
        // Check permissions
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSession.RecordPermission.granted:
            isAudioRecordingGranted = true
            break
        case AVAudioSession.RecordPermission.denied:
            isAudioRecordingGranted = false
            break
        case AVAudioSession.RecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { allowed in
                self.isAudioRecordingGranted = allowed
            }
            break
        default:
            break
        }
    }
    
    public func setupRecorderDelegate(_ delegate: any RecorderVCD) {
        if recorderDelegate != nil {
            fatalError("There may be just one recorder")
        }
        recorderDelegate = delegate
    }
    
    public func setupPlayerDelegate(_ delegate: any PlayerVCD) {
        if isPlaying {
            stopPlaying()
        }
        playerDelegate = delegate
    }
    
    
    private func getFileUrl(byName filename: String) -> URL {
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentsDir
            .appendingPathComponent(RecordingService.audiosDirectoryName, conformingTo: .directory)
            .appendingPathComponent(filename)
        print(filePath)
        currentURL = filePath
        return filePath
    }
    
    // MARK: - Recorder
    private func setupRecorder() {
        guard isAudioRecordingGranted else {
            print("Error in isAudioRecordingGranted")
            return
        }
        
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker)
            try session.setActive(true)
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.timeZone = .current
            dateFormatter.dateFormat = "yyyy.MM.dd, HH:mm:ss"
            let audioName = dateFormatter.string(from: Date())
            guard let audioExtension = AppropriateFormats.getFirstExtension(byKey: kAudioFormatMPEG4AAC) else {
                fatalError("Unsupported type format")
            }
            
            audioRecorder = try AVAudioRecorder(
                url: getFileUrl(byName: audioName + "." + audioExtension),
                settings: settings
            )
            audioRecorder.delegate = recorderDelegate
            audioRecorder.isMeteringEnabled = true
            audioRecorder.updateMeters()
            audioRecorder.prepareToRecord()
        } catch {
            print("Error in setupRecorder")
        }
    }
    
    public func startRecording() {
        if isRecording {
            pauseRecording()
//            finishAudioRecording(success: true)
//            recorderDelegate?.recordingDidEnd()
//            isRecording = false
        } else {
            setupRecorder()

            audioRecorder.record()
            meterTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
                self.updateAudioMeter(timer: timer)
            })
            recorderDelegate?.recordingDidStart()
            isRecording = true
        }
    }
    
    // swiftlint: disable identifier_name
    private func updateAudioMeter(timer: Timer) {
        guard audioRecorder.isRecording else { return }
        
        let hr = Int((audioRecorder.currentTime / 60) / 60)
        let min = Int(audioRecorder.currentTime / 60)
        let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
        let totalTimeString = String(format: "%02d:%02d:%02d", hr, min, sec)
        recorderDelegate?.recordingCurrentTiming(totalTimeString)
        audioRecorder.updateMeters()
    }
    // swiftlint: enable identifier_name
    
    public func finishAudioRecording(success: Bool) {
        guard success else {
            print("Error in finishAudioRecording")
            return
        }
        audioRecorder.stop()
        meterTimer.invalidate()
        audioRecorder = nil
        isRecording = false
        print("END!")
    }
    
    public func pauseRecording() {
        guard isRecording else { return }
        if isPausedRecording {
            isPausedRecording = false
            audioRecorder.record()
            recorderDelegate?.recordingDidContinued()
        } else {
            isPausedRecording = true
            audioRecorder.pause()
            recorderDelegate?.recordingDidPauseed()
        }
    }
    
    private func mergeRecordingWithRecInit(forURL recordingURL: URL) async {
        // Recording track
        let recAsset = AVURLAsset(url: recordingURL)
        let recTrack: AVAssetTrack
        let originTimeRange: CMTimeRange
        do {
            recTrack = try await recAsset.loadTracks(withMediaType: .audio)[0]
            originTimeRange = await CMTimeRange(
                start: .zero,
                duration: try recTrack.load(.timeRange).duration
            )
        } catch {
            fatalError(error.localizedDescription)
        }
        
        // Init track
        let initAsset = AVURLAsset(url: RecordingService.recordingInitAudioURL)
        let initTrack: AVAssetTrack
        do {
            initTrack = try await initAsset.loadTracks(withMediaType: .audio)[0]
        } catch {
            fatalError(error.localizedDescription)
        }
        
        // Make composition
        let composition = AVMutableComposition()
        guard
            let recAVComposition = composition.addMutableTrack(
                withMediaType: .audio,
                preferredTrackID: CMPersistentTrackID()),
            let initAVComposition = composition.addMutableTrack(
                withMediaType: .audio,
                preferredTrackID: CMPersistentTrackID())
        else {
            fatalError("Unable to instantiate AVMutableCompositionTrack")
        }
        do {
            try recAVComposition.insertTimeRange(originTimeRange, of: recTrack, at: .zero)
            try initAVComposition.insertTimeRange(originTimeRange, of: initTrack, at: .zero)
        } catch {
            fatalError(error.localizedDescription)
        }

        // Export
        let assetExport = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A)!
        assetExport.outputFileType = .m4a
        assetExport.outputURL = getFileUrl(byName: recordingURL.lastPathComponent)
        await assetExport.export()
        if let error = assetExport.error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Player
    private func preparePlay(file fileURL: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer.delegate = playerDelegate
            audioPlayer.prepareToPlay()
        } catch{
            print(error.localizedDescription)
        }
    }

    public func startPlaying(file fileURL: URL) {
        if isPlaying {
            fatalError("Some player is running")
        }
        if FileManager.default.fileExists(atPath: fileURL.path) {
            playerDelegate?.playerDidStart()
            preparePlay(file: fileURL)
            audioPlayer.play()
            isPlaying = true
        } else {
            print("ERROR in startPlaying")
        }
    }
    
    public func stopPlaying() {
        guard isPlaying else { return }
        audioPlayer.stop()
        playerDelegate?.playerDidEnd()
        isPlaying = false
    }
}

class AppropriateFormats {
    
    class AudioFormat: CustomStringConvertible {
        let description: String
        let format: AudioFormatID
        let fileExtensions: [String]
        
        init(description: String, format: AudioFormatID, fileExtensions: [String]) {
            self.description = description
            self.format = format
            self.fileExtensions = fileExtensions
        }
    }
    
    public static let formats: [AudioFormat] = [
        .init(description: "Linear PCM", format: kAudioFormatLinearPCM, fileExtensions: ["lpcm"]),
        .init(description: "MPEG 4 AAC", format: kAudioFormatMPEG4AAC, fileExtensions: ["m4a", "aac", "mp4"]),
        .init(description: "MPEG Layer 3", format: kAudioFormatMPEGLayer3, fileExtensions: ["mp3"]),
        .init(description: "Apple Lossless", format: kAudioFormatAppleLossless, fileExtensions: ["m4a", "caf"]),
        .init(description: "Apple IMA4", format: kAudioFormatAppleIMA4, fileExtensions: ["aif", "aiff", "aifc", "caf"]),
        .init(description: "iLBC", format: kAudioFormatiLBC, fileExtensions: ["ilbc"]),
        .init(description: "ULaw", format: kAudioFormatULaw, fileExtensions: ["wav", "aif", "aiff", "aifc", "caf", "snd", "au"])
    ]
    
    public static let ignoredList: [String] = [".DS_Store"]
    
    public static let allExtensions: [String] = {
        formats.flatMap { $0.fileExtensions }
    }()
    
    public static func getFirstExtension(byKey key: AudioFormatID) -> String? {
        formats.first { $0.format == key }?.fileExtensions.first
    }
}

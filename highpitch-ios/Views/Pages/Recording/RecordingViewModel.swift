//
//  RecordingViewModel.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/8/24.
//

import Foundation
import RxSwift
import RxCocoa

final class RecordingViewModel {
    let projectName = BehaviorRelay(value: Date().description)
    let sections = BehaviorRelay(value: [SectionOfProjectModel]())
    let selectedIndexPath = BehaviorRelay<IndexPath?>(value: IndexPath(row: 0, section: 0))
    
    let disposeBag = DisposeBag()
    
    let service = RecordingService()
    
    init() {
        configure()
    }
    
    func configure() {
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audiosDir = documentsDir.appendingPathComponent(RecordingService.audiosDirectoryName, 
                                                            conformingTo: .directory)
        // MARK: Audio 폴더 생성
        if FileManager.default.fileExists(atPath: audiosDir.path()) {
            getFiles(path: audiosDir)
        } else {
            do {
                try FileManager.default.createDirectory(at: audiosDir,
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
                getFiles(path: audiosDir)
            } catch {
                #if DEBUG
                print("Error creating directory: \(error.localizedDescription)")
                #endif
            }
        }
    }
    
    private func getFiles(path: URL) {
        let allFiles: [URL]
        do {
            allFiles = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
        print(allFiles)
    }
}

final class SettingsService {
    static func configure() {
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audiosDir = documentsDir.appendingPathComponent(RecordingService.audiosDirectoryName,
                                                            conformingTo: .directory)
        // MARK: Audio 폴더 생성
        if FileManager.default.fileExists(atPath: audiosDir.path()) {
            getFiles(path: audiosDir)
        } else {
            do {
                try FileManager.default.createDirectory(at: audiosDir,
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
                getFiles(path: audiosDir)
            } catch {
                #if DEBUG
                print("Error creating directory: \(error.localizedDescription)")
                #endif
            }
        }
    }
    
    static func getFiles(path: URL) {
        let allFiles: [URL]
        do {
            allFiles = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
        print(allFiles)
    }
}

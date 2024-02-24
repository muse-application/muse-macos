//
//  MusicPlayerAudio.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 22.02.2024.
//

import CoreAudio
import AudioToolbox
import Cocoa
import Combine

extension MusicPlayer {
    final class Audio {
        private enum Address {
            static var audioDevice: AudioObjectPropertyAddress = .init(
                mSelector: kAudioHardwarePropertyDefaultOutputDevice,
                mScope: kAudioObjectPropertyScopeGlobal,
                mElement: kAudioObjectPropertyElementMain
            )
            
            static var volume: AudioObjectPropertyAddress = .init(
                mSelector: kAudioHardwareServiceDeviceProperty_VirtualMainVolume,
                mScope: kAudioDevicePropertyScopeOutput,
                mElement: kAudioObjectPropertyElementMain
            )
        }
        
        private enum Listener {
            static var volume: AudioObjectPropertyListenerProc = { _, _, _, _ in
                NotificationCenter.default.post(name: Notification.volumeChanged.name, object: nil)
                return 0
            }
            
            static var audioDevice: AudioObjectPropertyListenerProc = { _, _, _, _ in
                NotificationCenter.default.post(name: Notification.audioDeviceChanged.name, object: nil)
                return 0
            }
        }
        
        private enum Notification: String {
            case volumeChanged = "mupl.volume.changed"
            case audioDeviceChanged = "mupl.audio.device.changed"
            
            var name: NSNotification.Name {
                return .init(self.rawValue)
            }
        }
        
        var audioDeviceID: AudioDeviceID?
        var volume: CurrentValueSubject<Float?, Never> = .init(nil)
        
        private var cancellables: Set<AnyCancellable> = .init()
        
        init() {
            self.setup()
        }
        
        deinit {
            self.removeVolumeListener(for: self.audioDeviceID)
            self.removeAudioDeviceListener()
            
            self.cancellables.forEach { $0.cancel() }
        }
        
        func getVolume() -> Float? {
            guard let deviceID = self.audioDeviceID else { return nil }
            
            var size = UInt32(MemoryLayout<Float32>.size)
            var volume: Float = 0.0
            
            guard AudioObjectGetPropertyData(deviceID, &Address.volume, 0, nil, &size, &volume) == noErr else { return nil }
            
            return min(max(0.0, volume), 1.0)
        }
        
        func setVolume(_ volume: Float?) {
            guard let deviceID = self.audioDeviceID, let volume = volume else { return }
            
            var canChangeVolume = DarwinBoolean(true)
            
            guard
                AudioObjectIsPropertySettable(deviceID, &Address.volume, &canChangeVolume) == noErr,
                canChangeVolume.boolValue
            else {
                return
            }
            
            var normalizedValue = min(max(0.0, volume), 1.0)
            
            AudioObjectSetPropertyData(deviceID, &Address.volume, 0, nil, UInt32(MemoryLayout<Float>.size(ofValue: normalizedValue)), &normalizedValue)
        }
        
        // MARK: - Setup
        
        private func setup() {
            self.audioDeviceID = self.getDefaultAudioDevice()
            self.volume.send(self.getVolume())
            
            self.setupListeners()
            self.setupNotifications()
        }
        
        private func setupNotifications() {
            NotificationCenter.default.publisher(for: Notification.volumeChanged.name)
                .throttle(for: 0.2, scheduler: DispatchQueue.main, latest: true)
                .sink { _ in
                    self.handleVolumeUpdate()
                }
                .store(in: &self.cancellables)
            
            NotificationCenter.default.publisher(for: Notification.audioDeviceChanged.name)
                .sink { _ in
                    self.handleAudioDeviceUpdate()
                }
                .store(in: &self.cancellables)
        }
        
        private func setupListeners() {
            self.setupVolumeListener()
            self.setupAudioDeviceListener()
        }
        
        // MARK: - Listeners
        
        private func setupVolumeListener() {
            guard let deviceID = self.audioDeviceID else { return }
            AudioObjectAddPropertyListener(.init(deviceID), &Address.volume, Listener.volume, nil)
        }
        
        private func removeVolumeListener(for deviceID: AudioDeviceID?) {
            guard let deviceID = deviceID else { return }
            AudioObjectRemovePropertyListener(.init(deviceID), &Address.volume, Listener.volume, nil)
        }
        
        private func setupAudioDeviceListener() {
            AudioObjectAddPropertyListener(.init(kAudioObjectSystemObject), &Address.audioDevice, Listener.audioDevice, nil)
        }
        
        private func removeAudioDeviceListener() {
            AudioObjectRemovePropertyListener(.init(kAudioObjectSystemObject), &Address.audioDevice, Listener.audioDevice, nil)
        }
        
        // MARK: - Handlers
        
        private func handleVolumeUpdate() {
            self.volume.send(self.getVolume())
        }
        
        private func handleAudioDeviceUpdate() {
            self.removeVolumeListener(for: self.audioDeviceID)
            
            self.audioDeviceID = self.getDefaultAudioDevice()
            
            self.setupVolumeListener()
            
            if self.audioDeviceID == nil {
                self.volume.send(nil)
            } else {
                self.volume.send(self.getVolume())
            }
        }
        
        // MARK: - Utility
        
        private func getDefaultAudioDevice() -> AudioDeviceID? {
            guard AudioObjectHasProperty(.init(kAudioObjectSystemObject), &Address.audioDevice) else { return nil }
            
            var result = kAudioObjectUnknown
            var size = UInt32(MemoryLayout<AudioDeviceID>.size)
            
            guard
                AudioObjectGetPropertyData(.init(kAudioObjectSystemObject), &Address.audioDevice, 0, nil, &size, &result) == noErr,
                result != kAudioObjectUnknown
            else {
                return nil
            }
            
            guard AudioObjectHasProperty(result, &Address.volume) else { return nil }
            
            return result
        }
    }
}

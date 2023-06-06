//
//  ScreenRecorder.swift
//  ScreenCapture
//
//  Created by Jack P. on 11/12/2015.
//  Copyright © 2015 Jack P. All rights reserved.
//

import Foundation
import AVFoundation

public class ScreenRecorder: NSObject, AVCaptureFileOutputRecordingDelegate {
    
    var destinationUrl: NSURL
    var session: AVCaptureSession?
    var movieFileOutput: AVCaptureMovieFileOutput?
    
    public var destination: NSURL {
        get {
            return self.destinationUrl
        }
    }

    public init(destination: NSURL) {
        self.destinationUrl = destination
        self.session = AVCaptureSession()
        self.session?.sessionPreset = AVCaptureSession.Preset.high
        let displayId: CGDirectDisplayID = CGDirectDisplayID(CGMainDisplayID())
        let input: AVCaptureScreenInput = AVCaptureScreenInput(displayID: displayId)!
        if input.isEqual(to: false) {
            self.session = nil
            return
        }
        if ((self.session?.canAddInput(input)) != nil) {
            self.session?.addInput(input)
        }
        self.movieFileOutput = AVCaptureMovieFileOutput()
        if ((self.session?.canAddOutput(self.movieFileOutput!)) != nil) {
            self.session?.addOutput(self.movieFileOutput!)
        }
    }
 
    public func start() {
        self.session?.startRunning()
        self.movieFileOutput?.startRecording(to: self.destinationUrl as URL, recordingDelegate: self)
    }
    
    public func stop() {
        self.movieFileOutput?.stopRecording()
    }
    
    public func captureOutput(
        captureOutput: AVCaptureFileOutput!,
        didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!,
        fromConnections connections: [AnyObject]!,
        error: NSError!
    ) {
        self.session?.stopRunning()
        self.session = nil
    }
    
    
    public func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print(output)
    }
}

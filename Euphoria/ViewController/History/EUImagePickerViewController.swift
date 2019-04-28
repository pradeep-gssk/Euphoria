//
//  EUImagePickerViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 4/26/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import AVFoundation
import Photos

protocol EUImagePickerViewDelegate: class {
    func imagePickerController(_ picker: EUImagePickerViewController, didFinishPickingImage image: UIImage)
}

class EUImagePickerViewController: UIViewController {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var captureView: UIView!
    @IBOutlet weak var cameraOverlayView: UIImageView!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    weak var delegate: EUImagePickerViewDelegate?
    
    var historyType: HistoryType = .face
    
    var captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    let cameraOutput = AVCapturePhotoOutput()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraOverlayView.image = UIImage(named: historyType.placeholder)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkCameraPersmission()
    }
    
    private func checkCameraPersmission() {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            DispatchQueue.main.async {
                self.startCamera()
            }
        }
        else {
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                DispatchQueue.main.async {
                    if granted {
                        self.startCamera()
                    } else {
                        self.showPermissionAlert("Please enable camera permission in settings.")
                    }
                }
            }
        }
    }
    
    private func showPermissionAlert(_ message: String) {
        self.showAlertWithMessage(message, actionHandler: {
            self.openSettings()
        })
    }
    
    private func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func startCamera() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
            let input = try? AVCaptureDeviceInput(device: device),
            captureSession.canAddInput(input) else {
                return
        }
        captureSession.addInput(input)
        guard captureSession.canAddOutput(cameraOutput) else {
            return
        }
        captureSession.addOutput(cameraOutput)
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = captureView.bounds
        previewLayer.contentsRect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        captureView.layer.addSublayer(previewLayer)
        captureSession.startRunning()
    }
    
    @IBAction func didTapCapturePhoto(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                             kCVPixelBufferWidthKey as String: 160,
                             kCVPixelBufferHeightKey as String: 160]
        settings.previewPhotoFormat = previewFormat
        self.cameraOutput.capturePhoto(with: settings, delegate: self)
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapRetakeButton(_ sender: Any) {
        self.cameraView.isHidden = false
        self.previewView.isHidden = true
    }
    
    @IBAction func didTapUsePhoto(_ sender: Any) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            self.saveImage()
        case .denied, .restricted :
            DispatchQueue.main.async {
                self.showPermissionAlert("Please enable photos read and write permission in settings.")
            }
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    self.saveImage()
                default:
                    DispatchQueue.main.async {
                        self.showPermissionAlert("Please enable photos read and write permission in settings.")
                    }
                }
            }
        }
    }
    
    private func saveImage() {
        DispatchQueue.main.async {
            guard let image = self.imageView.image else { return }
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            self.delegate?.imagePickerController(self, didFinishPickingImage: image)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension EUImagePickerViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            self.cameraView.isHidden = true
            self.previewView.isHidden = false
            self.imageView.image = UIImage(data: imageData)
        }
    }
}
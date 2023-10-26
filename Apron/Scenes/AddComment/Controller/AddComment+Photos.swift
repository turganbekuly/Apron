//
//  AddComment+Photos.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.08.2022.
//

import UIKit
import Photos
import APRUIKit

extension AddCommentViewController {
    // MARK: - Open media modal

    func openMediaModal() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        let cameraAction = UIAlertAction(title: L10n.Photo.Action.camera, style: .default) { [weak self] _ in
//            self?.checkCameraAccessIfNeeded()
//        }
//        alert.addAction(cameraAction)
        let galleryAction = UIAlertAction(title: L10n.Photo.Action.gallery, style: .default) { [weak self] _ in
            self?.checkLibraryAcceessIfNeeded()
        }
        alert.addAction(galleryAction)
        alert.addAction(.init(title: L10n.Common.cancel, style: .cancel))
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Photo library

    func checkLibraryAcceessIfNeeded() {
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            openLibrary()
        } else {
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                if status == .authorized {
                    DispatchQueue.main.async { [weak self] in
                        self?.openLibrary()
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.askLibraryAccess()
                    }
                }
            }
        }
    }

    private func openLibrary() {
        let viewController = UIImagePickerController()
        viewController.allowsEditing = false
        viewController.delegate = self
        viewController.sourceType = .photoLibrary
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.present(viewController, animated: true, completion: nil)
        }
    }

    func askLibraryAccess() {
        let alert = UIAlertController(
            title: L10n.Photo.Permission.Gallery.title,
            message: nil,
            preferredStyle: .alert
        )
        let yesAction = UIAlertAction(
            title: L10n.Photo.Action.settings,
            style: .default) {_ in
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

                DispatchQueue.main.async {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        alert.addAction(yesAction)
        let noAction = UIAlertAction(
            title: L10n.Common.close,
            style: .cancel,
            handler: nil
        )
        alert.addAction(noAction)
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Photos
    public func checkCameraAccessIfNeeded() {
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            openCamera()
        } else {
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async { [weak self] in
                        self?.openCamera()
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.askCameraAccess()
                    }
                }
            }
        }
    }

    private func askCameraAccess() {
        let alert = UIAlertController(title: L10n.Photo.Permission.Camera.title, message: nil, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: L10n.Photo.Action.settings, style: .default) {_ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

            DispatchQueue.main.async {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alert.addAction(yesAction)
        let noAction = UIAlertAction(title: L10n.Common.close, style: .cancel, handler: nil)
        alert.addAction(noAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }

    private func openCamera() {
        let viewController = UIImagePickerController()
        viewController.allowsEditing = false
        viewController.delegate = self
        viewController.sourceType = .camera
        DispatchQueue.main.async { [weak self] in
            self?.present(viewController, animated: true, completion: nil)
        }
    }
}

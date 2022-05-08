//
//  RecipeCreation+Photos.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19.04.2022.
//

import UIKit
import Photos
import DesignSystem

extension RecipeCreationViewController {
    // MARK: - Open media modal

    func openMediaModal() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Сделать фото", style: .default) { [weak self] _ in
            self?.checkCameraAccessIfNeeded()
        }
        alert.addAction(cameraAction)
        let galleryAction = UIAlertAction(title: "Выбрать из галереи", style: .default) { [weak self] _ in
            self?.checkLibraryAcceessIfNeeded()
        }
        alert.addAction(galleryAction)
        alert.addAction(.init(title: "Отмена", style: .cancel))
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
            title: "Требуется доступ к галлерее",
            message: nil,
            preferredStyle: .alert
        )
        let yesAction = UIAlertAction(
            title: "Перейти в \"Настройки\"",
            style: .default) {_ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

            DispatchQueue.main.async {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alert.addAction(yesAction)
        let noAction = UIAlertAction(
            title: "Закрыть",
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
        let alert = UIAlertController(title: "Требуется доступ к камере", message: nil, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Перейти в \"Настройки\"", style: .default) {_ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

            DispatchQueue.main.async {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alert.addAction(yesAction)
        let noAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
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

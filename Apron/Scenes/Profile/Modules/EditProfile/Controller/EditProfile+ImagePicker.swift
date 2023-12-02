//
//  EditProfile+ImagePicker.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 23.10.2023.
//

import UIKit
import APRUIKit
import Photos

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true) {
            self.selectedImage = image
        }
    }
}

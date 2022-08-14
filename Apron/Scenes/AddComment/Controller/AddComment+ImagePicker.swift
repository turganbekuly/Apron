//
//  AddComment+ImagePicker.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.08.2022.
//

import UIKit
import APRUIKit
import Photos

extension AddCommentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true) {
            self.selectedImage = image
        }
    }
}

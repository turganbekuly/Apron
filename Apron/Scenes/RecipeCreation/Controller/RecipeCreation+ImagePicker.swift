//
//  RecipeCreation+ImagePicker.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19.04.2022.
//

import UIKit
import DesignSystem
import Photos

extension RecipeCreationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true) {
            self.selectedImage = image
        }
    }
}

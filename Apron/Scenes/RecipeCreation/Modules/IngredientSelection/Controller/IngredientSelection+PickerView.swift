//
//  IngredientSelection+PickerView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21.04.2022.
//

import UIKit

extension IngredientSelectionViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        measureTextField.measurementTyptextField.text = measurementType[row]
    }
}

extension IngredientSelectionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return measurementType.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return measurementType[row]
    }

}

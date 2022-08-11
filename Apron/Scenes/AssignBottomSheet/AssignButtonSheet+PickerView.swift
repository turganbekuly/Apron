//
//  AssignButtonSheet+PickerView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.04.2022.
//

import UIKit

extension AssignBottomSheetViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch type {
        case .servings:
            type = .servings(servingComponents[row])
        case .prepTime:
            let hourIndex = pickerView.selectedRow(inComponent: 0)
            let minIndex = pickerView.selectedRow(inComponent: 2)
            let hourToMinInt = Int(hourComponents[hourIndex]) ?? 0
            let minInt = Int(minComponments[minIndex]) ?? 0
            type = .prepTime("\((hourToMinInt * 60) + minInt)")
        case .cookTime:
            let hourIndex = pickerView.selectedRow(inComponent: 0)
            let minIndex = pickerView.selectedRow(inComponent: 2)
            let hourToMinInt = Int(hourComponents[hourIndex]) ?? 0
            let minInt = Int(minComponments[minIndex]) ?? 0
            type = .cookTime("\((hourToMinInt * 60) + minInt)")
        case .whenToCook:
            type = .whenToCook(row + 1)
        default:
            break
        }
    }
}

extension AssignBottomSheetViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch type {
        case .servings, .whenToCook:
            return 1
        case .cookTime, .prepTime:
            return 4
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch type {
        case .servings:
            return servingComponents.count
        case .prepTime, .cookTime:
            if component == 0 {
                return hourComponents.count
            } else if component == 2 {
                return minComponments.count
            } else {
                return 1
            }
        case .whenToCook:
            return whenToCook.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch type {
        case .servings:
            return "\(servingComponents[row])"
        case .prepTime, .cookTime:
            if component == 0 {
                return "\(hourComponents[row])"
            } else if component == 1 {
                return hourSeparator
            } else if component == 2 {
                return "\(minComponments[row])"
            } else {
                return minSeparator
            }
        case .whenToCook:
            return "\(whenToCook[row])"
        default:
            return ""
        }
    }

}

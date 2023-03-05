//
//  AssignButtonSheet+PickerView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.04.2022.
//

import UIKit
import APRUIKit

extension AssignBottomSheetViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch type {
        case .servings:
            type = .servings(servingComponents[row])
        case .cookTime:
            let hourIndex = pickerView.selectedRow(inComponent: 0)
            let minIndex = pickerView.selectedRow(inComponent: 2)
            let hourToMinInt = Int(hourComponents[hourIndex]) ?? 0
            let minInt = Int(minComponments[minIndex]) ?? 0
            type = .cookTime("\((hourToMinInt * 60) + minInt)")
        case .timer:
            let hourIndex = pickerView.selectedRow(inComponent: 0)
            let minIndex = pickerView.selectedRow(inComponent: 2)
            let secIndex = pickerView.selectedRow(inComponent: 4)
            let hourInt = Int(hourComponents[hourIndex]) ?? 0
            let minInt = Int(minComponments[minIndex]) ?? 0
            let secInt = Int(secComponents[secIndex]) ?? 0
            let seconds = (hourInt * 3600) + (minInt * 60) + secInt
            type = .timer("\(seconds)")
        default:
            break
        }
    }
}

extension AssignBottomSheetViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch type {
        case .servings:
            return 1
        case .cookTime:
            return 4
        case .timer:
            return 6
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch type {
        case .servings:
            return servingComponents.count
        case .cookTime:
            if component == 0 {
                return hourComponents.count
            } else if component == 2 {
                return minComponments.count
            } else {
                return 1
            }
        case .timer:
            if component == 0 {
                return hourComponents.count
            } else if component == 2 {
                return minComponments.count
            } else if component == 4 {
                return secComponents.count
            } else {
                return 1
            }
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch type {
        case .servings:
            return "\(servingComponents[row])"
        case .cookTime:
            if component == 0 {
                return "\(hourComponents[row])"
            } else if component == 1 {
                return hourSeparator
            } else if component == 2 {
                return "\(minComponments[row])"
            } else {
                return minSeparator
            }
        case .timer:
            if component == 0 {
                return "\(hourComponents[row])"
            } else if component == 1 {
                return hourSeparator
            } else if component == 2 {
                return "\(minComponments[row])"
            } else if component == 3 {
                return minSeparator
            } else if component == 4 {
                return "\(secComponents[row])"
            } else {
                return secSeparator
            }
        default:
            return ""
        }
    }

    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?
    ) -> UIView {
        guard let type = type else { return UIView() }
        switch type {
        case .timer, .cookTime:
            if component == 0 {
                var label: UILabel
                if let view = view as? UILabel { label = view } else { label = UILabel() }
                label.textAlignment = .center
                label.text = hourComponents[row]
                label.font = TypographyFonts.regular20
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.5
                return label
            } else if component == 1 {
                var label: UILabel
                if let view = view as? UILabel { label = view } else { label = UILabel() }

                label.text = hourSeparator
                label.textAlignment = .center
                label.font = TypographyFonts.regular14
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.5
                return label
            } else if component == 2 {
                var label: UILabel
                if let view = view as? UILabel { label = view } else { label = UILabel() }
                label.textAlignment = .center
                label.text = minComponments[row]
                label.font = TypographyFonts.regular20
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.5
                return label
            } else if component == 3 {
                var label: UILabel
                if let view = view as? UILabel { label = view } else { label = UILabel() }

                label.text = minSeparator
                label.textAlignment = .center
                label.font = TypographyFonts.regular14
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.5
                return label
            } else if component == 4 {
                var label: UILabel
                if let view = view as? UILabel { label = view } else { label = UILabel() }
                label.textAlignment = .center
                label.font = TypographyFonts.regular20
                label.text = secComponents[row]
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.5
                return label
            } else {
                var label: UILabel
                if let view = view as? UILabel { label = view } else { label = UILabel() }

                label.text = secSeparator
                label.textAlignment = .center
                label.font = TypographyFonts.regular14
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.5
                return label
            }
        case .servings:
            var label: UILabel
            if let view = view as? UILabel { label = view } else { label = UILabel() }
            label.textAlignment = .center
            label.font = TypographyFonts.regular20
            label.adjustsFontSizeToFitWidth = true
            label.text = servingComponents[row]
            label.minimumScaleFactor = 0.5
            return label
        }
    }
}

//
//  StepByStepMode+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24/08/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Foundation
import UIKit
import APRUIKit
import Storages
import RemoteConfig

extension StepByStepModeViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case is StepByStepPagerView:
            return stepperSections.count
        case is StepByStepModeView:
            return sections.count
        default:
            return 0
        }
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case is StepByStepPagerView:
            return stepperSections[section].rows.count
        case is StepByStepModeView:
            return sections[section].rows.count
        default:
            return 0
        }
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case is StepByStepPagerView:
            let row = stepperSections[indexPath.section].rows[indexPath.row]
            switch row {
            case .step, .review:
                let cell: StepPagerCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
            }
        case is StepByStepModeView:
            let row = sections[indexPath.section].rows[indexPath.row]
            switch row {
            case .instruction:
                let cell: StepDescriptionCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
            case .review:
                let cell: StepFinalStepCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
            }
        default:
            let cell: UICollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension StepByStepModeViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case is StepByStepPagerView:
            let row = stepperSections[indexPath.section].rows[indexPath.row]
            switch row {
            case .step, .review:
                onStepperSelected = true
                mainView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
                stepperView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        case is StepByStepModeView:
            let row = sections[indexPath.section].rows[indexPath.row]
            switch row {
            default:
                break
            }
        default:
            break
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case is StepByStepPagerView:
            let row = stepperSections[indexPath.section].rows[indexPath.row]
            switch row {
            case .step, .review:
                return CGSize(width: 50, height: 60)
            }
        case is StepByStepModeView:
            let row = sections[indexPath.section].rows[indexPath.row]
            switch row {
            case .instruction, .review:
                return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
            }
        default:
            return CGSize(width: 0, height: 0)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch collectionView {
        case is StepByStepPagerView:
            let row = stepperSections[indexPath.section].rows[indexPath.row]
            switch row {
            case .step:
                guard let cell = cell as? StepPagerCell else { return }
                cell.configure(with: StepPagerCellViewModel(pagerType: .regular(title: "\(indexPath.row + 1)")))
            case .review:
                guard let cell = cell as? StepPagerCell else { return }
                cell.configure(with: StepPagerCellViewModel(pagerType: .image(image: APRAssets.iconKnifeFork.image)))
            }
        case is StepByStepModeView:
            let row = sections[indexPath.section].rows[indexPath.row]
            switch row {
            case let .instruction(instruction):
                guard let cell = cell as? StepDescriptionCell else { return }
                cell.delegate = self
                cell.configure(
                    with: StepDescriptionViewModel(
                        stepCount: indexPath.row + 1,
                        recipeInstruction: instruction
                    )
                )
            case .review:
                guard let cell = cell as? StepFinalStepCell else { return }
                cell.delegate = self
                cell.configure(with: finalImage)
            }
        default:
            break
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let currentPage = (Int(scrollView.contentOffset.x / width) + 1)
        let progress = Double(currentPage) / Double(instructions.count + 1)
        progressBar.setProgress(Float(progress), animated: true)
        guard instructions.indices.contains(currentPage - 1) else {
            return
        }

        guard let description = instructions[currentPage - 1].description else { return }
        if RemoteConfigManager.shared.remoteConfig.isCookAssistantEnabled {
            guard RecipeCreationStorage().isCookAssistEnabled else { return }
            TTSMAnager.shared.startTTS(with: description)
        }
    }
}

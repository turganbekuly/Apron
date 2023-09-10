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
            case .step, .review, .ingredient:
                let cell: StepPagerCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
            }
        case is StepByStepModeView:
            let row = sections[indexPath.section].rows[indexPath.row]
            switch row {
            case .ingredient:
                let cell: StepIngredientsCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
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
            case .step, .review, .ingredient:
                let actualIndexPath = translatedIndexPath(for: indexPath) ?? IndexPath(item: 0, section: 0)
                let cellWidth = mainView.bounds.width
                let totalCellsBefore = sections.prefix(actualIndexPath.section).reduce(0) { $0 + $1.rows.count } + actualIndexPath.item
                let offset = cellWidth * CGFloat(totalCellsBefore)
                let contentWidth = cellWidth * CGFloat(sections.reduce(0) { $0 + $1.rows.count })
                
                // Calculate progress
                let progress = offset / (contentWidth - cellWidth)
                progressBar.setProgress(Float(progress), animated: true)
                
                mainView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
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
            case .step, .review, .ingredient:
                return CGSize(width: 50, height: 60)
            }
        case is StepByStepModeView:
            let row = sections[indexPath.section].rows[indexPath.row]
            switch row {
            case .instruction, .review, .ingredient:
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
            case .ingredient:
                guard let cell = cell as? StepPagerCell else { return }
                cell.configure(with: StepPagerCellViewModel(pagerType: .image(image: APRAssets.iconGroceryBasket.image)))
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
            case let .ingredient(ingredients):
                guard let cell = cell as? StepIngredientsCell else { return }
                cell.configure(with: ingredients)
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
        switch scrollView {
        case is StepByStepPagerView:
            progressViewHandler(scrollView)
            stepperViewHanlder(scrollView)
        case is StepByStepModeView:
            progressViewHandler(scrollView)
            stepperViewHanlder(scrollView)
        default:
            break
        }
    }
    
    private func progressViewHandler(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let cellWidth = scrollView.bounds.width
        
        // Calculate the total number of cells across all sections
        let totalCells = sections.reduce(0) { $0 + $1.rows.count }
        
        // Calculate the content width
        let contentWidth = cellWidth * CGFloat(totalCells)
        
        // Calculate progress
        let progress = offset / (contentWidth - cellWidth)
        progressBar.setProgress(Float(progress), animated: true)
        
        // Use the progress to determine the current page or cell
        let currentPage = Int((progress * CGFloat(totalCells)).rounded())
        
        guard currentPage > 0 && currentPage <= instructions.count else {
            return
        }
        
        let currentInstructionIndex = currentPage - 2 // Adjusting for your ingredient and review pages

        guard instructions.indices.contains(currentInstructionIndex) else {
            return
        }
        
        guard let description = instructions[currentInstructionIndex].description else {
            return
        }
        
        if RemoteConfigManager.shared.remoteConfig.isCookAssistantEnabled {
            guard RecipeCreationStorage().isCookAssistEnabled else { return }
            TTSMAnager.shared.startTTS(with: description)
        }
    }
    
    private func stepperViewHanlder(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let currentPage = Int(scrollView.contentOffset.x / width) // Removed +1 from this line
        
        var sectionType: StepperSection.Section
        var item: Int
        
        switch currentPage {
        case 0:
            sectionType = .ingredients
            item = 0
        case 1..<1 + instructions.count:
            sectionType = .steps
            item = currentPage - 1
        default:
            sectionType = .review
            item = 0
        }
        
        guard let sectionIndex = stepperSections.firstIndex(where: { $0.section == sectionType }) else { return }
        
        let indexPath = IndexPath(item: item, section: sectionIndex)
        stepperView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    private func translatedIndexPath(for indexPath: IndexPath) -> IndexPath? {
        let stepperSection = stepperSections[indexPath.section].section
        switch stepperSection {
        case .ingredients:
            if let mainSectionIndex = sections.firstIndex(where: { $0.section == .ingredients }) {
                return IndexPath(item: indexPath.item, section: mainSectionIndex)
            }
        case .steps:
            if let mainSectionIndex = sections.firstIndex(where: { $0.section == .instructions }) {
                return IndexPath(item: indexPath.item, section: mainSectionIndex)
            }
        case .review:
            if let mainSectionIndex = sections.firstIndex(where: { $0.section == .review }) {
                return IndexPath(item: indexPath.item, section: mainSectionIndex)
            }
        }
        return nil
    }
}

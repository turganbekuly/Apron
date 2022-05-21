//
//  CommunitySegmentedCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 18.01.2022.
//

public protocol ICommunitySegmentedCellViewModel {
    var index: Int { get }
}

public struct CommunitySegmentedCellViewModel: ICommunitySegmentedCellViewModel {

    // MARK: - SegmentCellProtocol

    public var index: Int

    // MARK: - Init

    public init(filter: CommunitySegmentView.CommunitySegment?) {
        index = filter?.rawValue ?? CommunitySegmentView.CommunitySegment.recipes.rawValue
    }

}


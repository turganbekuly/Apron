//
//  CommunityPage+Segment.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 18.01.2022.
//

import Foundation

extension CommunityPageViewController: ICommunitySegmentCell {
    public func cell(_ cell: CommunitySegmentCell, didChangedSegment segment: CommunitySegmentCell.CommunitySegment) {
        self.selectedSegment = segment
    }
}

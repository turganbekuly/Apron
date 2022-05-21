//
//  CommunityPage+Segment.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 18.01.2022.
//

import Foundation

extension CommunityPageViewController: ICommunitySegmentCell {
    public func cell(_ cell: CommunitySegmentView, didChangedSegment segment: CommunitySegmentView.CommunitySegment) {
        self.selectedSegment = segment
    }
}

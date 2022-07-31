//
//  AddCommentService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol AddCommentServiceProtocol {
    
}

final class AddCommentService: AddCommentServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<AddCommentEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<AddCommentEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - AddCommentServiceProtocol
    
}

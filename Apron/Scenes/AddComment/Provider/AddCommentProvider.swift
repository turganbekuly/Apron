//
//  AddCommentProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol AddCommentProviderProtocol {
    
}

final class AddCommentProvider: AddCommentProviderProtocol {

    // MARK: - Properties
    private let service: AddCommentServiceProtocol
    
    // MARK: - Init
    init(service: AddCommentServiceProtocol =
                    AddCommentService(provider: AKNetworkProvider<AddCommentEndpoint>())) {
        self.service = service
    }
    
    // MARK: - AddCommentProviderProtocol

}

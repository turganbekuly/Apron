//
//  ResultListProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol ResultListProviderProtocol {
    
}

final class ResultListProvider: ResultListProviderProtocol {

    // MARK: - Properties
    private let service: ResultListServiceProtocol
    
    // MARK: - Init
    init(service: ResultListServiceProtocol =
                    ResultListService(provider: AKNetworkProvider<ResultListEndpoint>())) {
        self.service = service
    }
    
    // MARK: - ResultListProviderProtocol

}

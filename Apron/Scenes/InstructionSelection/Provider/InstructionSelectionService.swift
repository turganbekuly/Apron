//
//  InstructionSelectionService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21.08.2022.
//

import AKNetwork

protocol InstructionSelectionServiceProtocol {
    func uploadImage(
        request: InstructionSelectionDataFlow.UploadImage.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class InstructionSelectionService: InstructionSelectionServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<InstructionSelectionEndpoints>

    // MARK: - Init
    init(provider: AKNetworkProvider<InstructionSelectionEndpoints>) {
        self.provider = provider
    }

    // MARK: - RecipeCreationServiceProtocol

    func uploadImage(
        request: InstructionSelectionDataFlow.UploadImage.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        guard let data = request.image.jpeg(.medium) else {
            completion(.failure(.invalidData))
            return
        }

        provider.send(target: .uploadImage(image: data)) { result in
            completion(result)
        }
    }
}

//
//  InstructionSelectionProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21.08.2022.
//


import Models

protocol InstructionSelectionProviderProtocol {
    func uploadImage(
        request: InstructionSelectionDataFlow.UploadImage.Request,
        completion: @escaping ((InstructionSelectionDataFlow.UploadImageResult) -> Void)
    )
}

final class InstructionSelectionProvider: InstructionSelectionProviderProtocol {

    // MARK: - Properties
    private let service: InstructionSelectionServiceProtocol

    // MARK: - Init
    init(service: InstructionSelectionServiceProtocol = InstructionSelectionService(provider: AKNetworkProvider<InstructionSelectionEndpoints>())) {
        self.service = service
    }

    // MARK: - RecipeCreationProviderProtocol

    func uploadImage(
        request: InstructionSelectionDataFlow.UploadImage.Request,
        completion: @escaping ((InstructionSelectionDataFlow.UploadImageResult) -> Void)
    ) {
        service.uploadImage(request: request) {
            switch $0 {
            case let .success(json):
                if let json = json["path"] as? String {
                    completion(.successful(imagePath: json))
                } else {
                    completion(.failed(error: .invalidData))
                }
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }
}

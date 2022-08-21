//
//  InstructionSelectionEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21.08.2022.
//

import Configurations
import AKNetwork
import Storages
import Models

enum InstructionSelectionEndpoints {
    case uploadImage(image: Data)
}

extension InstructionSelectionEndpoints: AKNetworkTargetType {

    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .uploadImage:
            return "image/upload/4"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .uploadImage:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: AKNetworkTask {
        switch self {
        case let .uploadImage(data):
            return .uploadMultipart(
                [
                    .init(
                        provider: .data(data),
                        name: "file",
                        fileName: "image.jpg",
                        mimeType: "image/jpeg"
                    )
                ]
            )
        }
    }

    var headers: [String: String]? {
        var headers = [
            "Accept-Language": "ru",
            "Content-Type": "application/json"
        ]
        if let token = AuthStorage.shared.accessToken {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }

}


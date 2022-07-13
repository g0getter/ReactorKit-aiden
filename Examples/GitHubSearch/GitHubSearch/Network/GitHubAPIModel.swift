//
//  GitHubAPIModel.swift
//  GitHubSearch
//
//  Created by Aiden on 2022/07/13.
//  Copyright © 2022 Suyeol Jeon. All rights reserved.
//

import Foundation

struct ApiResponseModel<T: Codable>: Codable {
    var data: T?
}

enum GitHub {
    struct search {
        // MARK: - Response
        struct Response: Codable {
            let message: String
            let errors: [Error]
            let documentationURL: String

            enum CodingKeys: String, CodingKey {
                case message, errors
                case documentationURL = "documentation_url"
            }
        }

        // MARK: - Error
        struct Error: Codable {
            let resource, field, code: String
        }

    }
}

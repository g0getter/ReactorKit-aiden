//
//  GitHubTargetType.swift
//  GitHubSearch
//
//  Created by Aiden on 2022/07/12.
//  Copyright © 2022 Suyeol Jeon. All rights reserved.
//

import Foundation
import Moya

enum GitHubTargetType {
    case search(query: String, page: Int)
}

extension GitHubTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com/search/repositories?")!
    }
    
    var path: String {
        switch self {
        case .search:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .search(let query, let page):
            return .requestParameters(parameters: ["q": query, "page": page], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

let gitHubProvider = MoyaProvider<GitHubTargetType>()

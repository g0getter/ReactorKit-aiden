//
//  Moya+Coable.swift
//  GitHubSearch
//
//  Created by Aiden on 2022/07/13.
//  Copyright © 2022 Suyeol Jeon. All rights reserved.
//

import Foundation
import RxSwift
import Moya

public extension Response {

    func mapObject<T: Codable>(_ type: T.Type, path: String? = nil) throws -> T {

        do {
            return try JSONDecoder().decode(T.self, from: try getJsonData(path))
        } catch {
            throw MoyaError.jsonMapping(self)
        }
    }
    
    private func getJsonData(_ path: String? = nil) throws -> Data {

        do {
            var jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            if let path = path {

                guard let specificObject = jsonObject.value(forKeyPath: path) else {
                    throw MoyaError.jsonMapping(self)
                }
                jsonObject = specificObject as AnyObject
            }

            return try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
        } catch {
            throw MoyaError.jsonMapping(self)
        }
    }
}

public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {

    func mapObject<T: Codable>(_ type: T.Type, path: String? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObject(type, path: path))
        }
    }
}

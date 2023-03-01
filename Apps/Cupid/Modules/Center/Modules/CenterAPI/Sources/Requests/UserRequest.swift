//
//  UserInfoRequest.swift
//  CenterAPI
//
//  Created by jcc on 2022/12/15.
//

import Foundation
import RestfulClient
import Coder

class UserInfoRequest: BaseRequestable {
    let path: String = "/api/v1/user/info"
    let method: HTTPMethod = .GET
    let queryItems: [URLQueryItem]?
    
    init(guid: String? = nil) {

        if let guid = guid  {
            self.queryItems = [URLQueryItem(name: "guid", value: guid)]
        }else {
            self.queryItems = nil
        }
        
    }
    
}


class UpdateUserInfoRequest: BaseRequestable {
    let path: String = "/api/v1/user/info/update"
    let method: HTTPMethod = .POST
    let body: [UInt8]?
    
    init(name: String?, gender: Int?, birthday: String?, avatar: String?) {
        let object = UpdateUserInfoRequestBody(name: name, gender: gender, birthday: birthday, avatar: avatar)
        body = try? JSONCoder.encode(object: object).bytes
    }
}


fileprivate struct UpdateUserInfoRequestBody: Codable {
    let name: String?
    let gender: Int?
    let birthday: String?
    let avatar: String?
}

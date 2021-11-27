//
//  Response.swift
//  NowOnlineReplic
//
//  Created by William Tristão de Pauloa on 16/11/21.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let status, message: String
    let response: T
    let requestID: String?
}

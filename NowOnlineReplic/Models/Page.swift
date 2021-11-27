//
//  Page.swift
//  NowOnlineReplic
//
//  Created by William Tristão de Pauloa on 16/11/21.
//

import Foundation

struct Page: Decodable {
    let id: Int
    let title, layout: String
    let categories: [Carousel]
    let contents: [String]
    let type: String
    let link: String?
    let previewType: String
    let filters: [String]?
    let parents: [String]
}

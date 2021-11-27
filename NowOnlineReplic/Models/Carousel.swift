//
//  HomeContents.swift
//  NowOnlineReplic
//
//  Created by William Tristão de Pauloa on 16/11/21.
//

import Foundation

struct Carousel: Decodable {
    let id: Int
    let title, layout: String
    let categories: [String]
    let contents: [ItemCarousel]
    let type: TypesCarousel
    let link: Link?
    let previewType: String
    let filters: [String]?
}

enum TypesCarousel: String, Codable {
    case banners = "banners"
    case live = "live"
    case editorial = "editorial"
    case tv_channels = "tv_channels"
    case recommendation_smartcontent = "recommendation_smartcontent"
    case continue_watching = "continue_watching"
    case characters = "characters"
    case categories = "categories"
}

struct Link: Decodable {
    let type: String?
    let path: String?
    let categoryId: Int?
}

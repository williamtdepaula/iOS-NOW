//
//  ItemCarousel.swift
//  NowOnlineReplic
//
//  Created by William Tristão de Pauloa on 16/11/21.
//

import Foundation

struct ItemCarousel: Decodable {
    var id: Int
    var title: String
    var type: String
    var packages: [Int]
    var images: Images?
    var isFree: Bool?
    var hasLive: Bool?
    let duration: Int?
    let ageRating: String?
    let tvChannels: [TvChannel]?
    let tvChannel: TvChannel?
    let averageRating, userRating: Int?
    let language: String?
    let genres: [String]?
    let releaseYear: String?
    let image: String?
    let recommendationProvider: [String]?
    
    func getBannerInfo() -> String {
        var info = "\(self.genres?[0] ?? "") • \(self.releaseYear ?? "")"
        
        guard let age = self.ageRating else {return info }
        
        info = "\(info) • +\(age)"
        
        return info
    }
}

// MARK: - Images
struct Images: Decodable {
    let coverPortrait, coverLandscape, bannerPortrait, bannerLandscape, frameLandscape, banner, bannerHover: String?
}

struct TvChannel: Decodable {
    let id: Int
    let liveID: Int?
    let name, channelName, type, source: String
    let maxStreams: Int
    let logo: String
    let channelLogo: String
    let stamp: String?
    let isHD: Bool?
    let hasLive, is4GFree, hasAdvertising: Bool
    let showChannelContent: Bool
}

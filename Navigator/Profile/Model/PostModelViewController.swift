//
//  PostModelViewController.swift
//  Navigator
//
//  Created by Jazzband on 25.12.2022.
//

import UIKit

struct PostModel {

    var autor: String
    var fullDescription: String
    var shortDescription: String
    var image: String
    var likes: Int
    var views: Int

}

class Posts {

    static let singleton: Posts = .init()

    var posts: [PostModel] = [
        PostModel(autor: "CDProject",
                  fullDescription: "This game has been waited for may yars by thousands of people around the world,but unfortunatly it became disastrous.  ",
                  shortDescription: "a new up side down game",
                  image: "ciberPunk",
                  likes: 11,
                  views: 23),
        PostModel(autor: "NationalGeographic",
                  fullDescription: "We found this beautiful winter palace with gorgeous inside interior with a large brick fire place and a big northen bear skin infront of it. ",
                  shortDescription: "winter forest in North America",
                  image: "winterHouse",
                  likes: 22,
                  views: 52),
        PostModel(autor: "CCP Games",
                  fullDescription: "A brnd new EVE online expantion was released. Players will able to find more new events and new ships",
                  shortDescription: "Explore more deeper space with new ships",
                  image:"Eve",
                  likes: 52,
                  views: 1242),
        PostModel(autor: "NationalGeographic",
                  fullDescription: "We found this admirable raod withing a red forest on the outskirt of  the Easten Ireland", shortDescription: "red forest with eaevn road, leading us to a endless nature adventure",
                  image:  "dorogaRed",
                  likes: 33,
                  views: 322)
    ]
}


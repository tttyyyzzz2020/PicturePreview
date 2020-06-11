//
//  Picture.swift
//  PictruePreview
//
//  Created by yongzhan on 2020/6/11.
//  Copyright © 2020 yongzhan. All rights reserved.
//

import Foundation

struct Picture: Identifiable {
    let id  = UUID()
    var imageName: String
    
    static func data() -> [Picture] {
        return [
            .init(imageName: "img1"),
            .init(imageName: "img2"),
            .init(imageName: "img3"),
            .init(imageName: "img4"),
            .init(imageName: "img5")
        ]
    }
}

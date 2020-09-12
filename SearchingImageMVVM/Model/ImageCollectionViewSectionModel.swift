//
//  ImageCollectionViewSectionModel.swift
//  SearchingImageMVVM
//
//  Created by Paul Jang on 2020/09/12.
//  Copyright © 2020 jdm. All rights reserved.
//

import Foundation
import RxDataSources

struct ImageCollectionViewSectionModel {
    var header: String
    var items: [Item]
}

extension ImageCollectionViewSectionModel: SectionModelType {
    typealias Item = ImageInfo

    init(original: ImageCollectionViewSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}
 

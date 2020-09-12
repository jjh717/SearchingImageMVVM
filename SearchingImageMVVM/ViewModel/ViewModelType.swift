//
//  ViewModelType.swift
//  SearchingImageMVVM
//
//  Created by Jang Dong Min on 2020/09/08.
//  Copyright © 2020 jdm. All rights reserved.
//

import Foundation
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output? { get }
}

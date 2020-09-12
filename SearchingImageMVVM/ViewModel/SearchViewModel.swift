//
//  SearchViewModel.swift
//  SearchingImageMVVM
//
//  Created by Jang Dong Min on 2020/09/07.
//  Copyright © 2020 jdm. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

class SearchViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    var input: Input
    var output: Output? = nil
    
    struct Input {
        let loadMore: AnyObserver<Void>
        let dataLoad: AnyObserver<Void>
    }

    struct Output {
        let searchResult: Driver<[ImageInfo]>
        let isLoading: Driver<Bool>
        let isPageCount: Driver<Int>
    }
    
    private let dataLoadSubject = PublishSubject<Void>()
    private let loadMoreTriggerSubject = PublishSubject<Void>()
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)
    private let pageRelay = BehaviorRelay<Int>(value: 0)
    
    private let totalImageInfoRelay = BehaviorRelay<[ImageInfo]>(value: [])
  
    init() {
        self.input = Input(loadMore: loadMoreTriggerSubject.asObserver(), dataLoad: dataLoadSubject.asObserver())
         
        dataLoadSubject.subscribe(onNext: { _ in
            self.pageRelay.accept(0)
            self.searchImageBy(page: 0)
        }).disposed(by: disposeBag)
         
        loadMoreTriggerSubject.subscribe { _ in
            if !self.isLoadingRelay.value {
                self.pageRelay.accept(self.pageRelay.value + 1)
                self.searchImageBy(page: self.pageRelay.value)
            }
        }.disposed(by: disposeBag)
         
        self.output = Output(searchResult: totalImageInfoRelay.asDriver(), isLoading: isLoadingRelay.asDriver(), isPageCount: pageRelay.asDriver())
    }
      
    func searchImageBy(page: Int) {
        self.isLoadingRelay.accept(true)
        APIClient.searchImage(page: page) { result in
            switch result {
            case .success(let info):
                self.totalImageInfoRelay.accept(self.totalImageInfoRelay.value + self.parse(json: info))
                break
            case .failure( _):
                break
            }
            
            self.isLoadingRelay.accept(false)
        }
    }
    
    func parse(json: Any) -> [ImageInfo] {
        let value = JSON(json)
        var result = [ImageInfo]()
        for i in 0..<value.count {
            let width = value[i]["width"].intValue
            let height = value[i]["height"].intValue
            let thumb = value[i]["urls"]["thumb"]
            result.append(ImageInfo(thumb: thumb.stringValue, width: width, height: height))
        }
        
        return result
    }
}

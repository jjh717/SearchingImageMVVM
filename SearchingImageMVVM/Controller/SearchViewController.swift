//
//  SearchViewController.swift
//  SearchingImageMVVM
//
//  Created by Jang Dong Min on 2020/09/07.
//  Copyright © 2020 jdm. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SDWebImage

class SearchViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel = SearchViewModel()
    
    @IBOutlet var imageCollectionView: ImageCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBind()
    }
     
    func setupBind() {
        viewModel.output?.searchResult.map({
            return [ImageCollectionViewSectionModel(header: "0", items: $0)]
        }).asObservable().bind(to: imageCollectionView.rx.items(dataSource: imageCollectionView.rxDataSource)).disposed(by: disposeBag)
          
        let loadNextPageTrigger: Observable<Void> = {
            self.imageCollectionView.rx.contentOffset
                .flatMap { (offset) -> Observable<Void> in
                    return self.imageCollectionView.isNearTheBottomEdge(offset, self.imageCollectionView)
                        ? Observable.just(Void())
                        : Observable.empty()
            }
        }()
        
        loadNextPageTrigger.bind(to: viewModel.input.loadMore).disposed(by: disposeBag)
 
        viewModel.input.dataLoad.onNext(())
    }
}

extension SearchViewController {

}

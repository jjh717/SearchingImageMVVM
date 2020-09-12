//
//  ImageCollectionView.swift
//  SearchingImageMVVM
//
//  Created by Jang Dong Min on 2020/09/08.
//  Copyright © 2020 jdm. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

class ImageCollectionView: UICollectionView {
    private let startLoadingOffset: CGFloat = 20.0
 
    let rxDataSource = RxCollectionViewSectionedReloadDataSource<ImageCollectionViewSectionModel>(
        configureCell: { dataSource, collectionView, indexPath, item in
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCollectionViewCell.self), for: indexPath) as? ImageCollectionViewCell {
            
                cell.contentImageView.sd_setImage(with: URL(string: item.thumb), completed: nil)

                return cell
            }
            return UICollectionViewCell()
    })
     
    override func awakeFromNib() {
        self.delegate = self

        if let layout = self.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }
}

extension ImageCollectionView: UICollectionViewDelegateFlowLayout, PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, width: CGFloat) -> CGFloat {
        
        let item = rxDataSource[indexPath.section].items[indexPath.row]
        return CGFloat(item.height) * width / CGFloat(item.width)
    }
    
    func isNearTheBottomEdge(_ contentOffset: CGPoint, _ collectionView: UICollectionView) -> Bool {
        if collectionView.contentSize.height == 0 {
            return false
        }
        return contentOffset.y + collectionView.frame.size.height + startLoadingOffset > collectionView.contentSize.height
    }
}


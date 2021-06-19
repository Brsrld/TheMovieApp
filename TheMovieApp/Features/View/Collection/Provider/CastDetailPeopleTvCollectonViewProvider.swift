//
//  CastDetailPeopleTvCollectonViewProvider.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 19.06.2021.
//

import Foundation
import UIKit

//MARK: Protocols

protocol CastDetailPeopleTvCollectionViewProtocol {
    func update (items: [PeopleTvCredits])
}

protocol CastDetailPeopleTvCollectionViewOutput: AnyObject {}

//MARK: CollectionView Functions

final class CastDetailPeopleTvCollectionView: NSObject{
    
    private lazy var items: [PeopleTvCredits] = []
    
    weak var delegate: CastDetailPeopleTvCollectionViewOutput?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let dataCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.castPeopleTVCreditsCollectionViewCellID, for: indexPath) as? CastPeopleTVCreditsCollectionViewCell {
            dataCell.configure(url: items[indexPath.row].poster_path ?? Constants.nilValue)
            cell = dataCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 1.2
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let sectionInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let adjustedWidth = collectionViewWidth - spaceBetweenCells - sectionInsets
        let width: CGFloat = floor(adjustedWidth / columns)
        let height: CGFloat = width / 2
        return CGSize(width: height / 1.5, height: width / 2)
    }
}

//MARK: Extensions

extension CastDetailPeopleTvCollectionView: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {}
extension CastDetailPeopleTvCollectionView: CastDetailPeopleTvCollectionViewProtocol {
    func update (items: [PeopleTvCredits]) {
        self.items = items
    }
}

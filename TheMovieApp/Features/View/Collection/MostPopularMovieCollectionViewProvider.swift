//
//  MostPopularMovieCollectionViewProvider.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import Foundation
import UIKit

//MARK: Protocols

protocol MostPopularMovieCollecionViewProtocol {
    func update (items: [MostPopularMovie])
}

protocol MostPopularMovieCollecionViewOutput: AnyObject {
    func onSelected()
}

//MARK: CollectionView Functions

final class MostPopularMovieCollecionView: NSObject{
    
    private lazy var items: [MostPopularMovie] = []
    
    weak var delegate: MostPopularMovieCollecionViewOutput?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let dataCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.mostPopularCollectionViewCellID, for: indexPath) as? MostPopularCollectionViewCell {
            dataCell.configure(title: items[indexPath.row].original_title ?? Constants.nilValue, image:items[indexPath.row].poster_path ?? Constants.nilValue, overview: items[indexPath.row].overview ?? Constants.nilValue)
            cell = dataCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 1.05
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let sectionInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let adjustedWidth = collectionViewWidth - spaceBetweenCells - sectionInsets
        let width: CGFloat = floor(adjustedWidth / columns)
        let height: CGFloat = width / 2
        return CGSize(width: width, height: height)
    }
}

//MARK: Extensions

extension MostPopularMovieCollecionView: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {}
extension MostPopularMovieCollecionView: MostPopularMovieCollecionViewProtocol {
    func update (items: [MostPopularMovie]) {
        self.items = items
    }
}


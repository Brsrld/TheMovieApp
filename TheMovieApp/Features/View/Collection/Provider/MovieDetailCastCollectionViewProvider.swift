//
//  MovieDetailCastCollectionViewProvider.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 18.06.2021.
//

import Foundation
import UIKit

//MARK: Protocols

protocol MovieDetailCastCollectionViewProtocol {
    func update (items: [CastPersons])
}

protocol MovieDetailCastCollectionViewViewOutput: AnyObject {
    func onSelected()
}

//MARK: CollectionView Functions

final class MovieDetailCastCollectionView: NSObject{
    
    private lazy var items: [CastPersons] = []
    
    weak var delegate: MovieDetailCastCollectionViewViewOutput?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let dataCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.movieDetailCastCollectionViewCell, for: indexPath) as? MovieDetailCastCollectionViewCell {
            dataCell.configure(title: items[indexPath.row].name ?? Constants.nilValue, url: items[indexPath.row].profile_path ?? Constants.nilValue)
            cell = dataCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 1.4
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let sectionInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let adjustedWidth = collectionViewWidth - spaceBetweenCells - sectionInsets
        let width: CGFloat = floor(adjustedWidth / columns)
        let height: CGFloat = width / 2
        return CGSize(width: height, height: width)
    }
}

//MARK: Extensions

extension MovieDetailCastCollectionView: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {}
extension MovieDetailCastCollectionView: MovieDetailCastCollectionViewProtocol {
    func update (items: [CastPersons]) {
        self.items = items
    }
}


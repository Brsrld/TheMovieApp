//
//  MovieDetailVideosCollectionViewProvider.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 19.06.2021.
//

import Foundation
import UIKit

//MARK: Protocols

protocol MovieDetailVideosCollectionViewProtocol {
    func update (items: [MovieVideos])
}

protocol MovieDetailVideosCollectionViewOutput: AnyObject {
    func onSelected()
}

//MARK: CollectionView Functions

final class MovieDetailVideosCollectionView: NSObject{
    
    private lazy var items: [MovieVideos] = []
    
    weak var delegate: MovieDetailVideosCollectionViewOutput?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let dataCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.movieDetailVideosCollectionViewCell, for: indexPath) as? MovieDetailVideosCollectionViewCell {
            dataCell.configureUI(videoID: items[indexPath.row].key ?? Constants.nilValue)
            cell = dataCell
        }
        return cell
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
        return CGSize(width: width, height: height)
    }
}

//MARK: Extensions

extension MovieDetailVideosCollectionView: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {}
extension MovieDetailVideosCollectionView: MovieDetailVideosCollectionViewProtocol {
    func update (items: [MovieVideos]) {
        self.items = items
    }
}


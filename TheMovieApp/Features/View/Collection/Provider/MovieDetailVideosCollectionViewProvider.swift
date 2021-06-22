//
//  MovieDetailVideosCollectionViewProvider.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 19.06.2021.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

//MARK: Protocols

protocol MovieDetailVideosCollectionViewProtocol: AnyObject {
    func fillCollectionView(collectionView: UICollectionView, model: Observable<[MovieVideos]>)
}

protocol MovieDetailVideosCollectionViewOutput: AnyObject {}

//MARK: CollectionView Functions

final class MovieDetailVideosCollectionView: NSObject{
    
    private var video: MovieVideos?
    private let disposedBag = DisposeBag()
    
    weak var delegate: MovieDetailVideosCollectionViewOutput?
    
    func fillCollectionView(collectionView: UICollectionView, model: Observable<[MovieVideos]>) {
        model.bind(to: collectionView.rx.items(cellIdentifier: Constants.movieDetailVideosCollectionViewCellID, cellType: MovieDetailVideosCollectionViewCell.self)) {
            (index,video,cell) in
            self.video = video
            cell.configureUI(videoID: video.key!)
        }.disposed(by: disposedBag)
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

//MARK: - UICollectionViewDelegate,UICollectionViewDelegateFlowLayout

extension MovieDetailVideosCollectionView: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {}

//MARK: - MovieDetailVideosCollectionViewProtocol

extension MovieDetailVideosCollectionView: MovieDetailVideosCollectionViewProtocol {}

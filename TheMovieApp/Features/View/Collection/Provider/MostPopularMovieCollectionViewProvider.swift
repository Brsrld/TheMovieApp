//
//  MostPopularMovieCollectionViewProvider.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

//MARK: Protocols

protocol MostPopularMovieCollecionViewProtocol: AnyObject {
    
    func fillCollectionView(collectionView: UICollectionView, model: Observable<[MostPopularMovie]>)
    func navigate(collectionView: UICollectionView, navigateController:UINavigationController)
}

protocol MostPopularMovieCollecionViewOutput: AnyObject {}

//MARK: CollectionView Functions

final class MostPopularMovieCollecionView: NSObject{
    
    private var movies: MostPopularMovie?
    private let disposedBag = DisposeBag()
    private lazy var items: [MostPopularMovie] = []
    
    
    weak var delegate: MostPopularMovieCollecionViewOutput?
    
    func fillCollectionView(collectionView: UICollectionView, model: Observable<[MostPopularMovie]>) {
        collectionView.dataSource = nil
        model.bind(to: collectionView.rx.items(cellIdentifier: Constants.mostPopularCollectionViewCellID, cellType: MostPopularCollectionViewCell.self)) {
            (index,movie,cell) in
            self.movies = movie
            cell.configure(title: movie.original_title!, image: movie.poster_path!, overview: movie.overview!)
            
        }.disposed(by: disposedBag)
    }
    
    func navigate(collectionView: UICollectionView, navigateController:UINavigationController) {
        
        collectionView.rx.itemSelected
            .subscribe(onNext: { index  in
                let vc = MovieDetailViewController()
                vc.moviesDetail = self.movies
                navigateController.pushViewController(vc, animated: true)
                
            })
            .disposed(by: disposedBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 1.1
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

extension MostPopularMovieCollecionView: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {}

//MARK: - MostPopularMovieCollecionViewProtocol

extension MostPopularMovieCollecionView: MostPopularMovieCollecionViewProtocol {}



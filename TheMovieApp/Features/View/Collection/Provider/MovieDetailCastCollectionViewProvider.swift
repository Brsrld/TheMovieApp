//
//  MovieDetailCastCollectionViewProvider.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 18.06.2021.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

//MARK: Protocols

protocol MovieDetailCastCollectionViewProtocol: AnyObject {
    func fillCollectionView(collectionView: UICollectionView, model: Observable<[CastPersons]>)
}

protocol MovieDetailCastCollectionViewOutput: AnyObject {}

//MARK: CollectionView Functions

final class MovieDetailCastCollectionView: NSObject{
    
    private var persons: CastPersons?
    private let disposedBag = DisposeBag()
    
    weak var delegate: MovieDetailCastCollectionViewOutput?
    
    func fillCollectionView(collectionView: UICollectionView, model: Observable<[CastPersons]>) {
        model.bind(to: collectionView.rx.items(cellIdentifier: Constants.movieDetailCastCollectionViewCellID, cellType: MovieDetailCastCollectionViewCell.self)) {
            (index,cast,cell) in
            self.persons = cast
            cell.configure(title: cast.name ?? Constants.nilValue , url: cast.profile_path ?? Constants.nilValue)
        }.disposed(by: disposedBag)
    }
    
    
    func navigate(collectionView: UICollectionView,navigateController:UINavigationController) {
        collectionView.rx.itemSelected
                    .subscribe(onNext: { index in
                        let vc = CastDetailViewController()
                        vc.persons = self.persons
                        navigateController.pushViewController(vc, animated: true)
                    })
                    .disposed(by: disposedBag)
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
                return CGSize(width: height, height: width / 1.2)
      }
}

//MARK: Extensions

extension MovieDetailCastCollectionView: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {}
extension MovieDetailCastCollectionView: MovieDetailCastCollectionViewProtocol {}


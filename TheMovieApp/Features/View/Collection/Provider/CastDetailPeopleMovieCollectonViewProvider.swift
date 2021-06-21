//
//  CastDetailPeopleMovieCollectonViewProvider.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 19.06.2021.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

//MARK: Protocols

protocol CastDetailPeopleMovieCollectonViewProtocol: AnyObject {
    func fillCollectionView(collectionView: UICollectionView, model: Observable<[PeopleMovieCredits]>)
}

protocol CastDetailPeopleMovieCollectonViewOutput: AnyObject {}

//MARK: CollectionView Functions

final class CastDetailPeopleMovieCollectonView: NSObject{
    
    private var peopleMovieCredits: PeopleMovieCredits?
    private let disposedBag = DisposeBag()
    
    weak var delegate: CastDetailPeopleMovieCollectonViewOutput?
    
    func fillCollectionView(collectionView: UICollectionView, model: Observable<[PeopleMovieCredits]>) {
        model.bind(to: collectionView.rx.items(cellIdentifier: Constants.castPeopleMovieCreditsCollectionViewCellID, cellType: CastPeopleMovieCreditsCollectionViewCell.self)) {
            (index,peopleMovieCredits,cell) in
            self.peopleMovieCredits = peopleMovieCredits
            cell.configure(url: peopleMovieCredits.poster_path ?? Constants.nilValue)
        }.disposed(by: disposedBag)
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

extension CastDetailPeopleMovieCollectonView: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {}
extension CastDetailPeopleMovieCollectonView: CastDetailPeopleMovieCollectonViewProtocol {}

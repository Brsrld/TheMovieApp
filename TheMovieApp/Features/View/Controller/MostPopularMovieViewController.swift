//
//  MostPopularMovieViewController.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import UIKit

class MostPopularMovieViewController: UIViewController {
    
    //MARK: Variables
   
    private var mostPopularMovieViewModel: MostPopularMovieViewModel = MostPopularMovieViewModel()
    private let mostPopularMovieCollecionView: MostPopularMovieCollecionView = MostPopularMovieCollecionView()
    
    let mostPopularCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MostPopularCollectionViewCell.self, forCellWithReuseIdentifier: Constants.mostPopularCollectionViewCellID)
        cv.backgroundColor = .black
        cv.tag = 0
        return cv
    }()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(mostPopularCollectionView)
        service()
        initDelegate()
    }
    
    //MARK: Functions
    
    private func service() {
        mostPopularMovieViewModel.service { models in
            self.mostPopularMovieCollecionView.update(items: models)
            self.mostPopularCollectionView.reloadData()
        } onFail: { error in
            print(error ?? Constants.nilValue)
        }
    }
    private func initDelegate() {
        mostPopularCollectionView.delegate = mostPopularMovieCollecionView
        mostPopularCollectionView.dataSource = mostPopularMovieCollecionView
        mostPopularMovieCollecionView.delegate = self
    }
}

//MARK: Extensions

extension MostPopularMovieViewController:MostPopularMovieCollecionViewOutput{
    func onSelected() {
        print("")
    }
}

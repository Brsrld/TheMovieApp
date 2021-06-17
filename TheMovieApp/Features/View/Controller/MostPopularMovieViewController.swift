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
    
    lazy var searchBar:UISearchBar = UISearchBar()
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private var searchedMovie: [MostPopularMovie] = []
    private var allMovies: [MostPopularMovie] = []
    
    let mostPopularCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MostPopularCollectionViewCell.self, forCellWithReuseIdentifier: Constants.mostPopularCollectionViewCellID)
        cv.backgroundColor = .systemBackground
        cv.tag = 0
        return cv
    }()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(mostPopularCollectionView)
       
        service()
        initDelegate()
        setupUI()
        navigationBarSetup()
        setIndicator()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mostPopularCollectionView.contentSize = CGSize(width: mostPopularCollectionView.frame.width, height:  UIScreen.main.bounds.height)
    }
    
    //MARK: Functions
    
    private func service() {
        mostPopularMovieViewModel.service { models in
            self.allMovies = models
            self.mostPopularMovieCollecionView.update(items: models)
            self.mostPopularCollectionView.reloadData()
            self.activityIndicator.stopAnimating()
        } onFail: { error in
            print(error ?? Constants.nilValue)
        }
    }
    
    private func initDelegate() {
        mostPopularCollectionView.delegate = mostPopularMovieCollecionView
        mostPopularCollectionView.dataSource = mostPopularMovieCollecionView
        mostPopularMovieCollecionView.delegate = self
    }
    
    private func navigationBarSetup() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.mostPopularTitle
        searchBar.placeholder = Constants.searchTitle
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.restorationIdentifier = "SearchBar"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
    }
    
    private func setupUI() {
        mostPopularCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mostPopularCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mostPopularCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mostPopularCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
}

//MARK: Extensions

extension MostPopularMovieViewController:MostPopularMovieCollecionViewOutput{
    func onSelected() {
        print("")
    }
}

extension MostPopularMovieViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedMovie = allMovies.filter({($0.original_title?.prefix(searchText.count))! == searchText})
        mostPopularMovieCollecionView.update(items: searchedMovie)
        mostPopularCollectionView.reloadData()
    }
}

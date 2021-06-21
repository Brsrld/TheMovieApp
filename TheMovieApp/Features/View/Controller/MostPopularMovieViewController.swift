//
//  MostPopularMovieViewController.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import UIKit
import RxSwift
import RxCocoa

class MostPopularMovieViewController: UIViewController {
    
    //MARK: Variables
    
    private var mostPopularMovieViewModel: MostPopularMovieViewModel = MostPopularMovieViewModel()
    private let mostPopularMovieCollecionView: MostPopularMovieCollecionView = MostPopularMovieCollecionView()
    
    lazy var searchBar:UISearchBar = UISearchBar()
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private let disposedBag = DisposeBag()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.text = "Most Populars"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        view.backgroundColor = .white
        
        scrollView.addSubview(mostPopularCollectionView)
        scrollView.addSubview(titleLabel)
        
        service()
        initDelegate()
        setupUI()
        navigationBarSetup()
        setIndicator()
        navigate()
    }
 
    //MARK: Functions

    private func service() {
        mostPopularMovieCollecionView.fillCollectionView(collectionView: mostPopularCollectionView, model: mostPopularMovieViewModel.service(url: Constants.popularMovieUrl))
    }
    
    private func navigate() {
        mostPopularMovieCollecionView.navigate(collectionView: mostPopularCollectionView, navigateController: navigationController!)
    }

    private func initDelegate() {
        mostPopularCollectionView.delegate = mostPopularMovieCollecionView
        mostPopularMovieCollecionView.delegate = self
    }
    
    private func navigationBarSetup() {
        
        navigationController?.navigationBar.prefersLargeTitles = false
        searchBar.placeholder = Constants.searchTitle
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.restorationIdentifier = Constants.searchBarID
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
    }
    
    private func setupUI() {
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        mostPopularCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mostPopularCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        mostPopularCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mostPopularCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
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

extension MostPopularMovieViewController: MostPopularMovieCollecionViewOutput {}
extension MostPopularMovieViewController: UIScrollViewDelegate {}
extension MostPopularMovieViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//       searchedMovie = allMovies.filter({($0.original_title?.prefix(searchText.count))! == searchText})
//        if searchedMovie.count == 0 {
//
//        }else {
//           mostPopularMovieCollecionView.update(items: searchedMovie)
//            mostPopularCollectionView.reloadData()
//        }
    }
}



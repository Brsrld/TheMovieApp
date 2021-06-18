//
//  MovieDetailViewController.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import UIKit
import Kingfisher
import Cosmos
import TinyConstraints

class MovieDetailViewController: UIViewController {
   
    private var movieDetailViewModel: MovieDetailViewModel = MovieDetailViewModel()
    private let movieDetailCastCollecionView: MovieDetailCastCollectionView = MovieDetailCastCollectionView()
    private let movieDetailVideosCollectionView: MovieDetailVideosCollectionView = MovieDetailVideosCollectionView()
    
    var moviesDetail: MostPopularMovie?
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        return scroll
    }()
    
    private let videosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MovieDetailVideosCollectionViewCell.self, forCellWithReuseIdentifier: Constants.movieDetailVideosCollectionViewCellID)
        cv.backgroundColor = .white
        cv.tag = 0
        return cv
    }()
    
    private let castsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MovieDetailCastCollectionViewCell.self, forCellWithReuseIdentifier: Constants.movieDetailCastCollectionViewCell)
        cv.backgroundColor = .white
        cv.tag = 1
        return cv
    }()
    
    private var movieImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let castsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.text = "Casts"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private let videosLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        label.text = "Videos"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.text = "Summary"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var rateStar: CosmosView = {
        let cosmos = CosmosView()
        cosmos.settings.updateOnTouch = false
        cosmos.settings.totalStars = 5
        cosmos.settings.starSize = 30
        cosmos.settings.starMargin = 5
        cosmos.rating = (moviesDetail?.vote_average ?? 0) / 2
        return cosmos
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(overviewLabel)
        scrollView.addSubview(movieImage)
        scrollView.addSubview(rateStar)
        scrollView.addSubview(summaryLabel)
        scrollView.addSubview(videosLabel)
        scrollView.addSubview(videosCollectionView)
        scrollView.addSubview(castsLabel)
        scrollView.addSubview(castsCollectionView)
        rateStar.centerInSuperview()
        
        setupUI()
        shadowForImage()
        configureItems()
        service()
        initDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height:  UIScreen.main.bounds.height)
        setupUI()
    }
    
    private func service() {
       
        movieDetailViewModel.castService(url: "\(Constants.urlforCast)\(moviesDetail?.id ?? 0)\(Constants.credistExtension)") { models in
            self.movieDetailCastCollecionView.update(items: models)
            self.castsCollectionView.reloadData()
        } onFail: { error in
            print(error ?? Constants.nilValue)
        }
        movieDetailViewModel.videoService(url: "\(Constants.urlforCast)\(moviesDetail?.id ?? 0)\(Constants.videoExtend)") { models in
            self.movieDetailVideosCollectionView.update(items: models)
            self.videosCollectionView.reloadData()
        } onFail: { error in
            print(error ?? Constants.nilValue)
        }
    }

    private func initDelegate() {
        castsCollectionView.delegate = movieDetailCastCollecionView
        castsCollectionView.dataSource = movieDetailCastCollecionView
        movieDetailCastCollecionView.delegate = self
        videosCollectionView.delegate = movieDetailVideosCollectionView
        videosCollectionView.dataSource = movieDetailVideosCollectionView
        movieDetailVideosCollectionView.delegate = self
    }
    
    private func shadowForImage() {
        movieImage.layer.cornerRadius = 10
        movieImage.layer.shadowOpacity = 1
        movieImage.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    private func configureItems() {
        movieImage.kf.setImage(with: URL(string: Constants.imageUrl + (moviesDetail?.poster_path)!))
        titleLabel.text = moviesDetail?.original_title
        overviewLabel.text = moviesDetail?.overview
    }
    
    private func setupUI() {
  
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        movieImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
        movieImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 75).isActive = true
        movieImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -75).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: view.frame.height / 2.75).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 50).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        
        summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60).isActive = true
        summaryLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        summaryLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        overviewLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 5).isActive = true
        overviewLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        overviewLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        overviewLabel.heightAnchor.constraint(equalToConstant: view.frame.height / 5).isActive = true
        
        videosLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 50).isActive = true
        videosLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        videosLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        videosCollectionView.topAnchor.constraint(equalTo: videosLabel.bottomAnchor, constant: 10).isActive = true
        videosCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        videosCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        videosCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height / 5).isActive = true
        
        castsLabel.topAnchor.constraint(equalTo: videosCollectionView.bottomAnchor, constant: 50).isActive = true
        castsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        castsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        castsCollectionView.topAnchor.constraint(equalTo: castsLabel.bottomAnchor, constant: 20).isActive = true
        castsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        castsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        castsCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height / 3.2).isActive = true
        castsCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20).isActive = true
    
    }
}

extension MovieDetailViewController:UIScrollViewDelegate {}
extension MovieDetailViewController:MovieDetailCastCollectionViewViewOutput{
func onSelected() {
    print("")
}
}
extension MovieDetailViewController:MovieDetailVideosCollectionViewOutput{}

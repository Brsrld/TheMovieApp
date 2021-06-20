//
//  CastDetailViewController.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 19.06.2021.
//

import UIKit
import Kingfisher

class CastDetailViewController: UIViewController {
    
    //MARK: Variables
    
    var persons:CastPersons?
    
    private let castDetailViewModel: CastDetailViewModel = CastDetailViewModel()
    private let castDetailPeopleMovieCollectionView: CastDetailPeopleMovieCollectionView = CastDetailPeopleMovieCollectionView()
    private let castDetailPeopleTvCollectonView: CastDetailPeopleTvCollectionView = CastDetailPeopleTvCollectionView()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.register(CastPeopleMovieCreditsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.castPeopleMovieCreditsCollectionViewCellID)
        cv.tag = 0
        return cv
    }()
    
    private let tVCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CastPeopleTVCreditsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.castPeopleTVCreditsCollectionViewCellID)
        cv.tag = 1
        return cv
    }()
    
    private var personImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "Videos"
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    private let biographyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        label.text = "Biography"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        return label
    }()
    
    private let biographyOverviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let moviesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        label.text = "Movies"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        return label
    }()
    
    private let tvLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        label.text = "TV's"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        return label
    }()
    
    private var viewforImage: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        return view
    }()
    
    private var bigImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(bigImage)
        scrollView.addSubview(viewforImage)
        scrollView.addSubview(personImage)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(statusLabel)
        scrollView.addSubview(biographyLabel)
        scrollView.addSubview(biographyOverviewLabel)
        scrollView.addSubview(moviesLabel)
        scrollView.addSubview(moviesCollectionView)
        scrollView.addSubview(tvLabel)
        scrollView.addSubview(tVCollectionView)
        
        scrollView.backgroundColor = .systemBackground
        viewforImage.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        
        servicePerson()
        setupUI()
        configureUI()
        shadowForImage()
        initdelegate()
        serviceMovie()
        serviceTv()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height:  UIScreen.main.bounds.height)
    }
    
    //MARK: Functions
    
    private func initdelegate() {
        moviesCollectionView.delegate = castDetailPeopleMovieCollectionView
        moviesCollectionView.dataSource = castDetailPeopleMovieCollectionView
        castDetailPeopleMovieCollectionView.delegate = self
        tVCollectionView.delegate = castDetailPeopleTvCollectonView
        tVCollectionView.dataSource = castDetailPeopleTvCollectonView
        castDetailPeopleTvCollectonView.delegate = self
    }
    
    private func servicePerson() {
        castDetailViewModel.servicePerson(url: "\(Constants.personURL)\(persons?.id ?? 0)\(Constants.personUrlExtend)") { models in
            if models.biography == Constants.nilValue {
                self.biographyOverviewLabel.text = "We are sorry there is no biography data."
            } else {
                self.biographyOverviewLabel.text = models.biography
            }
        } onFail: { error in
            print(error ?? Constants.nilValue)
        }
    }
    
    private func configureUI() {
        nameLabel.text = persons?.name
        statusLabel.text = persons?.known_for_department
        let url = "\(Constants.imageUrl)\(persons?.profile_path ?? Constants.nilValue)"
        if url == Constants.imageUrl {
            personImage.image = UIImage(named: Constants.actorImageDefault)
            bigImage.image = UIImage(named: Constants.actorImageDefault)
        }else {
            personImage.kf.setImage(with: URL(string: url))
            bigImage.kf.setImage(with: URL(string: url))
        }
    }
    
    private func serviceMovie() {
        castDetailViewModel.serviceCreditsMovie(url: "\(Constants.personCreditsUrl)\(persons?.id ?? 0)\(Constants.personCreditExtension)") { models in
            self.castDetailPeopleMovieCollectionView.update(items: models)
            self.moviesCollectionView.reloadData()
        } onFail: { error in
            print(error ?? Constants.nilValue)
        }
    }
    
    private func serviceTv() {
        castDetailViewModel.serviceCreditsTv(url: "\(Constants.personCreditsUrl)\(persons?.id ?? 0)\(Constants.personCreditTvExtension)") { models in
            self.castDetailPeopleTvCollectonView.update(items: models)
            self.tVCollectionView.reloadData()
        } onFail: { error in
            print(error ?? Constants.nilValue)
        }
    }
    
    private func shadowForImage() {
        personImage.layer.cornerRadius = 10
        personImage.layer.shadowOpacity = 1
        personImage.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    private func setupUI() {
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        bigImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        bigImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bigImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bigImage.heightAnchor.constraint(equalToConstant: view.frame.height / 2.05).isActive = true

        viewforImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        viewforImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewforImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewforImage.heightAnchor.constraint(equalToConstant: view.frame.height / 2.05).isActive = true
        
        personImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
        personImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        personImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100).isActive = true
        personImage.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
     
        nameLabel.topAnchor.constraint(equalTo: personImage.bottomAnchor, constant: 20).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        
        statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        statusLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        statusLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        
        biographyLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 30).isActive = true
        biographyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        biographyLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        biographyOverviewLabel.topAnchor.constraint(equalTo: biographyLabel.bottomAnchor, constant: 10).isActive = true
        biographyOverviewLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        biographyOverviewLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        moviesLabel.topAnchor.constraint(equalTo: biographyOverviewLabel.bottomAnchor, constant: 30).isActive = true
        moviesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        moviesLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        moviesCollectionView.topAnchor.constraint(equalTo: moviesLabel.bottomAnchor, constant: 10).isActive = true
        moviesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        moviesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        moviesCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height / 5).isActive = true
        moviesCollectionView.bottomAnchor.constraint(equalTo: tvLabel.topAnchor, constant: -20).isActive = true
        
        tvLabel.topAnchor.constraint(equalTo: moviesCollectionView.bottomAnchor, constant: 30).isActive = true
        tvLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tvLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        tVCollectionView.topAnchor.constraint(equalTo: tvLabel.bottomAnchor, constant: 10).isActive = true
        tVCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tVCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        tVCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height / 5).isActive = true
        tVCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20).isActive = true
    }
}

//MARK: Extensions

extension CastDetailViewController: UIScrollViewDelegate {}
extension CastDetailViewController:  CastDetailPeopleMovieCollectionViewOutput {}
extension CastDetailViewController:  CastDetailPeopleTvCollectionViewOutput {}


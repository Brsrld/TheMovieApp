//
//  MovieDetailViewController.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    
    private var movieImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.text = "Most Populars"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.backgroundColor = .white
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.text = "Most Populars"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.backgroundColor = .white
        return label
    }()
    
    private let movieRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.text = "Most Populars"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.backgroundColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
      
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(overviewLabel)
        scrollView.addSubview(movieImage)
        scrollView.addSubview(movieRateLabel)
        
        setupUI()
        shadowForImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height:  UIScreen.main.bounds.height)
        movieImage.frame = CGRect(x:90, y:100, width: scrollView.frame.size.width / 1.8 , height: scrollView.frame.size.height / 2 )
    }
    
    private func shadowForImage() {
        movieImage.layer.cornerRadius = 10
        movieImage.layer.shadowOpacity = 1
        movieImage.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    private func setupUI() {
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  
    }
}

extension MovieDetailViewController:UIScrollViewDelegate {}

//
//  DetailViewController.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 30/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var sliderHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageCarouselView: ImageCarouselView!
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchImages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateView()
    }
}

// MARK: - Configure
extension DetailViewController {
    func configure(phoneId: Int) {
        viewModel = DetailViewModel(phoneId: phoneId)
    }
}

// MARK: - Update view
private extension DetailViewController {
    func updateView() {
        title = viewModel.phone?.name
        descriptionLabel.text = viewModel.phone?.description
        ratingLabel.text = "Rating: \(viewModel.phone?.rating.shortForm() ?? "0")"
        priceLabel.text = "Price: $\(viewModel.phone?.price.shortForm() ?? "0")"
        imageCarouselView.configure(urls: viewModel.phone?.imagePaths ?? [])
    }
    
    func fetchImages() {
        viewModel.fetchImages { [weak self] (phone, error) in
            self?.stopLoading()
            
            guard let phone = phone, error == nil else {
                self?.presentAlert(title: "Error", message: error!.message)
                return
            }
            
            self?.viewModel.updateItem(phone)
            self?.updateView()
        }
    }
    
    func startLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func stopLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

// MARK: - Setup view
private extension DetailViewController {
    func setupView() {
        setupSliderView()
    }
    
    func setupSliderView() {
        sliderHeightConstraint.constant = (UIScreen.main.bounds.height) * 35 / 100
    }
}

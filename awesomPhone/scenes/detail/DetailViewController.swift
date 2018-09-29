//
//  DetailViewController.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 30/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var sliderHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
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

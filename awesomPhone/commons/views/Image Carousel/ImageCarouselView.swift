//
//  ImageCarouselView.swift
//  workguru
//
//  Created by Khemmachat Thongkhum on 12/11/2560 BE.
//  Copyright © 2560 Khemmachat Thongkhum. All rights reserved.
//

import UIKit

class ImageCarouselView: UIView, NibLoadable {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl?
    
    var datasources: [String] = [] {
        didSet {
            pageControl?.numberOfPages = datasources.count
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        createView()
    }
    
    private func createView() {
        Bundle.main.loadNibNamed(ImageCarouselView.nibName, owner: self, options: nil)
        
        addSubviewWithAutoConstraintToFill(view: collectionView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
}

// MARK: - Configure
extension ImageCarouselView {
    func configure(urls: [String]) {
        datasources = urls
        collectionView.reloadData()
    }
}

// MARK: - Setup view
private extension ImageCarouselView {
    func setupView() {
        collectionView.register(ImageCarouselCollectionViewCell.self)
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.headerReferenceSize = .zero
        collectionViewLayout.sectionInset = .zero
        
        collectionView.setCollectionViewLayout(collectionViewLayout, animated: false)
        collectionView.showsHorizontalScrollIndicator = false
    }
}

// MARK: - UICollectionViewDataSource
extension ImageCarouselView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCarouselCollectionViewCell.defaultReuseIdentifier,
                                                      for: indexPath) as! ImageCarouselCollectionViewCell
        
        configure(cell, at: indexPath)
        
        return cell
    }
}

// MARK - UICollectionViewDelegateFlowLayout
extension ImageCarouselView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width,
                      height: collectionView.frame.size.height - 1)
    }
}

// MARK: - Configure cell
private extension ImageCarouselView {
    func configure(_ cell: ImageCarouselCollectionViewCell, at indexPath: IndexPath) {
        cell.configure(url: datasources[indexPath.row])
    }
}

// MARK: - Scroll view delegate
extension ImageCarouselView: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            pageControl?.currentPage = scrollView.currentPage
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl?.currentPage = scrollView.currentPage
    }
}

// MARK: - UIScrollView+PageControl
private extension UIScrollView {
    var currentPage: Int {
        return Int((contentOffset.x + bounds.width / 2) / bounds.width)
    }
}

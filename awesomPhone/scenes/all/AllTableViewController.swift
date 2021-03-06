//
//  AllViewController.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 29/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import UIKit

class AllViewController: UITableViewController {
    private var viewModel = AllViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchAllPhones()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateView()
    }
}

// MARK: - Setup view
private extension AllViewController {
    func setupView() {
        setupTableView()
        setupRefreshView()
    }
    
    func setupTableView() {
        tableView.register(PhoneTableViewCell.self)
    }
    
    func setupRefreshView() {
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
}

// MARK: - Update view
private extension AllViewController {
    func updateView() {
        viewModel.loadStorePhones()
        tableView.reloadData()
    }
    
    func fetchAllPhones() {
        startLoading()
        
        viewModel.fetchAllPhones { [weak self] (phones, error) in
            self?.stopLoading()
            
            guard let phones = phones, error == nil else {
                self?.presentAlert(title: "Error", message: error!.message)
                return
            }
            
            self?.viewModel.updateItems(phones)
            self?.tableView.reloadData()
        }
    }
    
    func startLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func stopLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        refreshControl?.endRefreshing()
    }
}

// MARK: - Delegate and Datasource
extension AllViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.cellIdentifier, for: indexPath)
        
        configure(cell, with: item, at: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.row]
        
        performSegue(withIdentifier: Segue.detail.rawValue, sender: item.identifier)
    }
}

// MARK: - Configure view and cell
private extension AllViewController {
    func configure(_ cell: UITableViewCell, with item: BaseCellItem, at indexPath: IndexPath) {
        switch (cell, item) {
        case (let cell as PhoneTableViewCell, let item as PhoneTableViewCell.CellItem):
            cell.configure(item: item, favoriteHandler: { [weak self] cell in
                self?.viewModel.favorite(index: indexPath.row)
                self?.tableView.reloadRows(at: [indexPath], with: .none)
            })
        default:
            break
        }
    }
}

// MARK: - Action
private extension AllViewController {
    @objc func refresh() {
        fetchAllPhones()
    }
    
    @IBAction func sort(_ sender: Any) {
        presentAlrt(title: "Sort", actions: [
            UIAlertAction(title: "Price (low to high)", style: .default, handler: { [weak self] _ in
                self?.viewModel.sort(type: .priceLowToHigh)
                self?.tableView.reloadData()
            }),
            UIAlertAction(title: "Price (high to low)", style: .default, handler: { [weak self] _ in
                self?.viewModel.sort(type: .priceHightToLow)
                self?.tableView.reloadData()
            }),
            UIAlertAction(title: "Rating (5 to 1)", style: .default, handler: { [weak self] _ in
                self?.viewModel.sort(type: .rating)
                self?.tableView.reloadData()
            })
            ])
    }
}

// MARK: - Segue
extension AllViewController {
    enum Segue: String {
        case detail = "detailSegue"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier
            , let segueType = Segue(rawValue: segueIdentifier) else {
                return
        }
        
        switch (segueType, segue.destination, sender) {
        case (.detail, let destination as DetailViewController, let phoneId as String):
            destination.configure(phoneId: Int(phoneId)!)
        default:
            break
        }
    }
}


//
//  FavoriteTableViewController.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 29/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    private var viewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateView()
    }
}

// MARK: - Setup view
private extension FavoriteTableViewController {
    func setupView() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(PhoneTableViewCell.self)
    }
}

// MARK: - Update view
private extension FavoriteTableViewController {
    func updateView() {
        viewModel.loadStoreFavoritePhones()
        tableView.reloadData()
    }
}

// MARK: - Delegate and Datasource
extension FavoriteTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.cellIdentifier, for: indexPath)
        
        configure(cell, with: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            unFavorite(at: indexPath)
        default:
            break
        }
    }
}

// MARK: - Configure view and cell
private extension FavoriteTableViewController {
    func configure(_ cell: UITableViewCell, with item: BaseCellItem) {
        switch (cell, item) {
        case (let cell as PhoneTableViewCell, let item as PhoneTableViewCell.CellItem):
            cell.configure(item: item)
        default:
            break
        }
    }
}

// MARK: - Action
private extension FavoriteTableViewController {
    func unFavorite(at indexPath: IndexPath) {
        viewModel.unFavorite(index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
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


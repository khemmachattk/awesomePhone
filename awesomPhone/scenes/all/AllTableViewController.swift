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
        updateView()
    }
}

// MARK: - Setup view
private extension AllViewController {
    func setupView() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(PhoneTableViewCell.self)
    }
}

// MARK: - Update view
private extension AllViewController {
    func updateView() {
        fetchAllPhones()
    }
    
    func fetchAllPhones() {
        viewModel.fetchAllPhones { [weak self] (phones, error) in
            guard let phones = phones, error == nil else {
                self?.presentAlert(title: "Error", message: error!.message)
                return
            }
            
            self?.viewModel.updateItems(phones)
            self?.tableView.reloadData()
        }
    }
}

// MARK: - Datasource
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

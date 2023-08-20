//
//  BeerListViewController.swift
//  BeerApp
//
//  Created by Joaquín Corugedo Rodríguez on 17/8/23.
//

import UIKit
import Combine

class BeerListViewController: UIViewController {
    
    //MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel = BeerListViewModel()
    
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()

        viewModel.getBeers()
        
        observeViewModel()
    }
    
    private func configView() {
        self.title = "Beers"
        
        tableView?.register(
            UINib(nibName: "BeerViewCell", bundle: nil),
            forCellReuseIdentifier: "reuseIdentifier"
        )
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    }
    
    private func observeViewModel() {
        viewModel.$beerList.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellables)
    }

}

//MARK: - Tableview Delegates

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.beerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? BeerViewCell else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "no content"
            return cell
        }
        
        cell.set(model: viewModel.beerList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let beer = viewModel.beerList[indexPath.row]
        let nextVC = DetailViewController()
        nextVC.set(model: beer)
        navigationController?.pushViewController(nextVC, animated: true)
    }
        
}

extension BeerListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            viewModel.getBeers(beerName: searchText)
        } else {
            viewModel.getBeers()
        }
        
    }
}


//
//  ViewController.swift
//  TheSportsDB
//
//  Created by Quentin Gallois on 28/08/2020.
//  Copyright © 2020 Quentin Gallois. All rights reserved.
//

import UIKit

class LeaguesVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private(set) weak var searchBar: UISearchBar!
    @IBOutlet private(set) weak var tableView: UITableView!

    // MARK: - Properties
    private var leagues: [League] = [] {
        didSet {
            filteredLeagues = leagues
        }
    }
    
    private var filteredLeagues: [League] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        getLeagues()
    }
    
    // MARK: - Private
    private func setUpTableView() {
        tableView.register(UINib(nibName: LeagueCell.Constants.identifier, bundle: nil),
                           forCellReuseIdentifier: LeagueCell.Constants.identifier)
    }

    private func getLeagues() {
        LeagueService.shared.delegate = self
        LeagueService.shared.getLeagues()
    }
}

// MARK: - LeagueServiceDelegate
extension LeaguesVC: LeagueServiceDelegate {
    
    func didSuccessGetLeagues(result: LeagueResult) {
        leagues = result.leagues
    }
    
    func didFailedGetLeagues() {
        leagues = []
    }
}

// MARK: - UISearchBarDelegate
extension LeaguesVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredLeagues = leagues
            return
        }
        filteredLeagues = leagues.filter { (league: League) -> Bool in
          league.strLeague.lowercased().contains(searchText.lowercased())
        }
      }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UITableViewDataSource
extension LeaguesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredLeagues.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        LeagueCell.Constants.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: LeagueCell.Constants.identifier, for: indexPath)
        guard let cell = reusableCell as? LeagueCell,
            let league = filteredLeagues.safe[indexPath.row] else {
                return UITableViewCell()
        }
        cell.setUp(league: league)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LeaguesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}


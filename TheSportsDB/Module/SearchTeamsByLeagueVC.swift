//
//  ViewController.swift
//  TheSportsDB
//
//  Created by Quentin Gallois on 28/08/2020.
//  Copyright © 2020 Quentin Gallois. All rights reserved.
//

import UIKit

class SearchTeamsByLeagueVC: UIViewController {

    // MARK: - Constants

    // MARK: - IBOutlet
    @IBOutlet private(set) weak var searchBar: UISearchBar!
    @IBOutlet private(set) weak var tableView: UITableView!

    // MARK: - Properties
    private var leagues: [League] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpTableView()
        getLeagues()
    }
    
    // MARK: - Private
    private func setUpUI() {
        
    }
    
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
extension SearchTeamsByLeagueVC: LeagueServiceDelegate {
    
    func didSuccessGetLeagues(result: LeagueResult) {
        leagues = result.leagues
    }
    
    func didFailedGetLeagues() {
        leagues = []
    }
}

// MARK: - UITableViewDataSource
extension SearchTeamsByLeagueVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leagues.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        LeagueCell.Constants.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: LeagueCell.Constants.identifier, for: indexPath)
        guard let cell = reusableCell as? LeagueCell,
            let league = leagues.safe[indexPath.row] else {
                return UITableViewCell()
        }
        cell.setUp(league: league)
        return cell

    }
}

// MARK: - UITableViewDelegate
extension SearchTeamsByLeagueVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: - UISearchBarDelegate
extension SearchTeamsByLeagueVC: UISearchBarDelegate {
    
}


//
//  LeagueVC.swift
//  TheSportsDB
//
//  Created by Quentin Gallois on 30/08/2020.
//  Copyright © 2020 Quentin Gallois. All rights reserved.
//

import UIKit

class TeamsVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private(set) weak var leagueName: UILabel!
    @IBOutlet private(set) weak var tableView: UITableView!

    // MARK: - Properties
    private var teams: [Team] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        getTeams()
    }
    
    // MARK: - Private
    private func setUpTableView() {
        tableView.register(UINib(nibName: TeamCell.Constants.identifier, bundle: nil),
                           forCellReuseIdentifier: TeamCell.Constants.identifier)
    }

    private func getTeams() {
        TeamsService.shared.delegate = self
        LeagueService.shared.getLeagues()
    }
}

// MARK: - TeamServiceDelegate
extension TeamsVC: TeamServiceDelegate {
    
    func didSuccessGetTeams(result: TeamResult) {
        teams = result.teams
    }
    
    func didFailedGetTeams() {
        teams = []
    }
}

// MARK: - UITableViewDataSource
extension TeamsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teams.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        TeamCell.Constants.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: TeamCell.Constants.identifier, for: indexPath)
        guard let cell = reusableCell as? TeamCell,
            let team = teams.safe[indexPath.row] else {
                return UITableViewCell()
        }
        cell.setUp(team: team)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TeamsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}


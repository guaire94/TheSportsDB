//
//  Players.swift
//  TheSportsDB
//
//  Created by Quentin Gallois on 30/08/2020.
//  Copyright © 2020 Quentin Gallois. All rights reserved.
//

import UIKit

class PlayersVC: UIViewController {

    // MARK: - Constants
    enum Constants {
        static var identifier: String = "PlayersVC"
    }

    // MARK: - IBOutlet
    @IBOutlet private(set) weak var teamName: UILabel!
    @IBOutlet private(set) weak var tableView: UITableView!

    // MARK: - Properties
    public var team: Team?
    private var players: [Player] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTeamInfo()
        setUpTableView()
        getPlayers()
    }
    
    // MARK: - Privates
    private func setUpTeamInfo() {
        guard let name = team?.strTeam else {
            navigationController?.popViewController(animated: true)
            return
        }
        teamName.text = name
    }
    
    private func setUpTableView() {
        tableView.register(UINib(nibName: LeagueCell.Constants.identifier, bundle: nil),
                           forCellReuseIdentifier: LeagueCell.Constants.identifier)
    }

    private func getPlayers() {
        guard let idTeam = team?.idTeam else {
            navigationController?.popViewController(animated: true)
            return
        }
        PlayerService.shared.delegate = self
        PlayerService.shared.getTeams(idTeam: idTeam)
    }
}

// MARK: - TeamServiceDelegate
extension PlayersVC: PlayerServiceDelegate {
    
    func didSuccessGetPlayers(result: PlayerResult) {
        players = result.players
    }
    
    func didFailedGetPlayers() {
        players = []
    }
}

// MARK: - UITableViewDataSource
extension LeaguesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        players.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        PlayerCell.Constants.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: PlayerCell.Constants.identifier, for: indexPath)
        guard let cell = reusableCell as? PlayerCell,
            let player = players.safe[indexPath.row] else {
                return UITableViewCell()
        }
        cell.setUp(player: player)
        return cell
    }
}

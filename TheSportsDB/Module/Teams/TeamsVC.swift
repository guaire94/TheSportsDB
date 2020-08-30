//
//  LeagueVC.swift
//  TheSportsDB
//
//  Created by Quentin Gallois on 30/08/2020.
//  Copyright © 2020 Quentin Gallois. All rights reserved.
//

import UIKit

class TeamsVC: UIViewController {

    // MARK: - Constants
    enum Constants {
        static var identifier: String = "TeamsVC"
        static var nbCellPerLine: CGFloat = 2.0
        static var nbSpacingBetweenCell: CGFloat = 10.0
    }

    // MARK: - IBOutlet
    @IBOutlet private(set) weak var leagueName: UILabel!
    @IBOutlet private(set) weak var collectionView: UICollectionView!

    // MARK: - Properties
    public var league: League?
    private var teams: [Team] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    private var cellSize: CGFloat {
        (collectionView.frame.width / Constants.nbCellPerLine) - CGFloat(Constants.nbSpacingBetweenCell)
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLeagueInfo()
        setUpCollectionView()
        getTeams()
    }
    
    // MARK: - Privates
    private func setUpLeagueInfo() {
        guard let name = league?.strLeague else {
            navigationController?.popViewController(animated: true)
            return
        }
        leagueName.text = name
    }
    
    private func setUpCollectionView() {
        collectionView.register(UINib(nibName: TeamCell.Constants.identifier, bundle: nil),
                                forCellWithReuseIdentifier: TeamCell.Constants.identifier)
    }

    private func getTeams() {
        guard let idLeague = league?.idLeague else {
            navigationController?.popViewController(animated: true)
            return
        }
        TeamService.shared.delegate = self
        TeamService.shared.getTeams(idLeague: idLeague)
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

// MARK: - UICollectionViewDataSource
extension TeamsVC: UICollectionViewDataSource {
            
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCell.Constants.identifier, for: indexPath)
        guard let cell = reusableCell as? TeamCell,
            let team = teams.safe[indexPath.row] else {
                return UICollectionViewCell()
        }
        cell.setUp(team: team)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TeamsVC: UICollectionViewDelegateFlowLayout {
            
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: cellSize, height: cellSize)
    }
}

// MARK: - UICollectionViewDelegate
extension TeamsVC: UICollectionViewDelegate {
            
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

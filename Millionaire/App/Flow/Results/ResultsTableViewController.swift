//
//  ResultsTableViewController.swift
//  Millionaire
//
//  Created by Vladimir Bozhenov on 21.10.2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {

    let cellID = "ResultCell"
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return Game.shared.gameResults.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID,
                                                 for: indexPath)
        let result = Game.shared.gameResults[indexPath.row]
        cell.textLabel?.text = self.dateFormatter.string(from: result.date)
        cell.detailTextLabel?.text = "\(result.percentOfCorrectAnswers) %"
        return cell
    }
}

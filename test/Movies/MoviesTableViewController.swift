//
//  MoviesTableViewController.swift
//  test
//
//  Created by Jialin Chen on 2019/6/13.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    var movies : [Movie] {
        return MoviesDataHelper.getMovies()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell")
        let movie = movies[indexPath.row]
        cell?.textLabel?.text = movie.title
        cell?.detailTextLabel?.text = movie.genreString()
        return cell!
    }

    
}

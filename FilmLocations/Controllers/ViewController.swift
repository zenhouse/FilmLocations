//
//  ViewController.swift
//  FilmLocations
//
//  Created by John Edwards on 2/18/19.
//  Copyright © 2019 John Edwards. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var films = [Film]()
    
    // Mark: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateList()
    }

    // Mark: - updateList()
    func updateList() {
        let query = QueryService()
        let network = NetworkService()
        guard let URL = query.getURLForPath() else {return}
        network.dataForURL(URL) { data, error in
            guard error.isEmpty else {
                print("Search error: " + error)
                return
            }
            
            // extract film list from JSON Data
            DispatchQueue.global().async { [unowned self] in
                if let data = data {
                    let parser = JSONParser.shared
                    if let films = parser.filmList(data) {
                        DispatchQueue.main.async {
                            self.films = films
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}


// MARK: - Datasource, Delegate functions
extension ViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmTableViewCell
        cell.configure(self.films[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "FilmDetailSeg", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            vc.film = films[indexPath.row]
        }
        
    }
    
}

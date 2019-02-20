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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let parser = JSONParser.shared
        let data = parser.getDataFromFile()
        if let arry = parser.filmList(data) {
            self.films = arry
            print("total records: \(arry.count)\n\n\n")
//            for film in arry {
//                print("\(film.filmInfo)\n\n\(film.moreInfo.facts)\n\n\(film.moreInfo.locations)\n\n\n\n")
//            }
           
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

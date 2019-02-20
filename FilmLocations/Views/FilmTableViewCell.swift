//
//  FilmTableViewCell.swift
//  FilmLocations
//
//  Created by John Edwards on 2/19/19.
//  Copyright © 2019 John Edwards. All rights reserved.
//

import UIKit

final class FilmTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ film: Film) {
        let locations = film.moreInfo.locations
        self.title.text = film.filmInfo.title
        self.releaseDate.text = film.filmInfo.releaseYear
        self.location.text = locations.count > 1 ? "multiple locations..." : film.filmInfo.location
    }

}

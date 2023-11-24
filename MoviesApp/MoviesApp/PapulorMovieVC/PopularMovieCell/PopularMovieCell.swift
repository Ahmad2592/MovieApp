//
//  PopularMovieCell.swift
//  MoviesApp
//
//  Created by Muhammad Ahmad on 24/11/2023.
//

import UIKit

class PopularMovieCell: UITableViewCell {

    
    @IBOutlet weak var lblPopularMovieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


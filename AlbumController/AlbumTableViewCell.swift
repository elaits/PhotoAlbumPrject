//
//  AlbumTableViewCell.swift
//  NewProject
//
//  Created by user on 6/28/19.
//  Copyright © 2019 Razeware. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var IdLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCell(_ album: AlbumModel) {
        userIdLabel.text = "Album Id: " + String(album.id)
        IdLabel.text = "User Id: " + String(album.userId)
        titleLabel.text = album.title
    }
}

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}

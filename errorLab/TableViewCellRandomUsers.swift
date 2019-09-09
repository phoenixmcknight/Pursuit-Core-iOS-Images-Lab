//
//  TableViewCellRandomUsers.swift
//  errorLab
//
//  Created by Phoenix McKnight on 9/6/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import UIKit

class TableViewCellRandomUsers: UITableViewCell {

    @IBOutlet weak var randomImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cellPhoneNumberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  DetailViewControllerRandomUser.swift
//  errorLab
//
//  Created by Phoenix McKnight on 9/6/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

class DetailViewControllerRandomUser:UIViewController {
  
    @IBOutlet weak var locationTextView: UITextView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    var randomUsers:RandomUsers!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabels()
    }
    func setUpLabels() {
        nameLabel.text = randomUsers.name.getName()
        locationTextView.text = randomUsers.location.getLocation()
        ageLabel.text = randomUsers.dob.date
        phoneLabel.text = randomUsers.phone
        ImageHelper.shared.fetchImage(urlImage: "\(randomUsers.picture.large)") { (result) in
            DispatchQueue.main.async {
                
                
                switch result {
                case .success(let UsersFromOnline):
                    self.imageViewOutlet.image = UsersFromOnline
                case .failure(let error) :
                    print(error)
                }
            }
            
        }
    }
}

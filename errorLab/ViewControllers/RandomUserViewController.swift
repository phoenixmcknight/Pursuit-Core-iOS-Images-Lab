//
//  ViewController.swift
//  errorLab
//
//  Created by Phoenix McKnight on 9/6/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import UIKit

class RandomUserViewController: UIViewController {
    @IBOutlet weak var randomUserTableView: UITableView!
    
    var randomUser = [RandomUsers]() {
        didSet {
            randomUserTableView.reloadData()
        }
    }
    private func loadData() {
        RandomUserApiHelper.shared.getUsers { (result) in
            DispatchQueue.main.async {
                
                
                switch result {
                case .success(let UsersFromOnline):
                    self.randomUser = UsersFromOnline
                case .failure(let error) :
                    print(error)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        loadData()
        // Do any additional setup after loading the view.
    }


}
extension RandomUserViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
}
extension RandomUserViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = randomUserTableView.dequeueReusableCell(withIdentifier: "random") as? TableViewCellRandomUsers
        cell?.ageLabel.text = randomUser[indexPath.row].dob.date
        cell?.cellPhoneNumberLabel.text = randomUser[indexPath.row].phone
        cell?.nameLabel.text = randomUser[indexPath.row].name.getName()
       
        ImageHelper.shared.fetchImage(urlImage: "\(randomUser[indexPath.row].picture.large)") { (result) in
            DispatchQueue.main.async {
                
                
                switch result {
                case .success(let UsersFromOnline):
                  cell?.randomImageView.image   = UsersFromOnline
                case .failure(let error) :
                    print(error)
                }
            }
            
    }
        return cell!

            }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let storyBoard = storyboard?.instantiateViewController(withIdentifier: "DetailViewControllerRandomUser")as? DetailViewControllerRandomUser {
            storyBoard.randomUsers = randomUser[indexPath.row]
            
            navigationController?.pushViewController(storyBoard, animated: true)
        }
        
    }
    
    func setUp() {
        randomUserTableView.dataSource = self
        randomUserTableView.delegate = self
    }
    
}

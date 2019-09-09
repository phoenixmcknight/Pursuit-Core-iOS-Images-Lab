//
//  ComicViewController.swift
//  errorLab
//
//  Created by Phoenix McKnight on 9/6/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit
class ComicViewController:UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var mostRecentComicButton: UIButton!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var imageOutlet: UIImageView!
    
    @IBOutlet weak var textFieldComic: UITextField!
    
    var comic:Comic? {
        didSet {
            getImage()
           navigationItem.title = "Comic Number : \(comicNumber)"
        }
    }
    var randomNumber = GetNumbers.getNumber()
    var mostRecentNumber = "1" {
        didSet {
            mostRecentComicButton.isEnabled = true
        }
    }
    var comicNumber:String {
        get {
            return textFieldComic.text ?? String(randomNumber)
            
        }
        
    }
    private func loadData() {
        ComicApiHelper.shared.getComic(num:comicNumber) { (results) in
            DispatchQueue.main.async {
                
                
                switch results {
                case .success(let comicsFromOnline):
                    self.comic = comicsFromOnline
                case .failure(let error) :
                    print(error)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        textFieldComic.delegate = self

        textFieldComic.text = String(randomNumber)
        mostRecentComicButton.isEnabled = false
        
    }
    
  
    
    
    @IBAction func mostRecentComic(_ sender: UIButton) {
        mostRecentComicButton.isEnabled = true
       textFieldComic.text = mostRecentNumber
        randomNumber = Int(mostRecentNumber)!
       loadData()
        
    }
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        mostRecentImage()
       

        randomNumber += Int(sender.value)
        textFieldComic.text = String(randomNumber)
        
        loadData()
    sender.value = 0
        
    }
    
    @IBAction func randomButton(_ sender: UIButton) {
        mostRecentImage()
        randomNumber = GetNumbers.getNumber()
       textFieldComic.text = String(randomNumber)
        loadData()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = CharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldComic.text = textField.text
        loadData()
        return true
    }
    func getImage() { ImageHelper.shared.fetchImage(urlImage:"\(comic!.img)") {
        (result) in
        DispatchQueue.main.async {
            
            
            switch result {
            case .success(let ImageFromOnline):
                self.imageOutlet.image = ImageFromOnline
            case .failure(let error) :
                print(error)
            }
        }
        
        
        }
    }
    func mostRecentImage() {
        mostRecentNumber = textFieldComic.text!
    }
    
}

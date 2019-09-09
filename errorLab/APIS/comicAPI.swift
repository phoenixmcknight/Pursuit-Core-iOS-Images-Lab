//
//  comicAPI.swift
//  errorLab
//
//  Created by Phoenix McKnight on 9/6/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

class ComicApiHelper {
    static let shared = ComicApiHelper()
    private init () {}
    
    
    
    func getComic(num:String,completionHandler: @escaping(Result<Comic,AppError>) -> ()) {
       let urlStr = "https://xkcd.com/\(num)/info.0.json"
        NetworkManager.shared.fetchData(urlString: urlStr) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do { let comics = try JSONDecoder().decode(Comic.self, from: data)
                    completionHandler(.success(comics))
                } catch {
                    completionHandler(.failure(.networkError))
                }
            }
        }
    }
}


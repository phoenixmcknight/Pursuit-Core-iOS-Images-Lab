//
//  conertAPIhelper.swift
//  ConcertDates
//
//  Created by Phoenix McKnight on 9/6/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
class RandomUserApiHelper {
    static let shared = RandomUserApiHelper()
    private init () {}

    let urlStr = "https://randomuser.me/api/?results=50"

    func getUsers(completionHandler: @escaping(Result<[RandomUsers],AppError>) -> ()) {
        NetworkManager.shared.fetchData(urlString: urlStr) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.badUrl))
            case .success(let data):
            do { let randomUsers = try JSONDecoder().decode(ResultsWrapper.self, from: data)
                completionHandler(.success(randomUsers.results))
            } catch {
                completionHandler(.failure(.networkError))
            }
            }
        }
}
}
 

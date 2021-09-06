//
//  SearchAPI.swift
//  MVVM_New
//
//  Created by Arshad Ali on 05/08/21.
//  Copyright © 2021 Abhilash Mathur. All rights reserved.
//

import Foundation

public enum SearchRepositoriesSort: String{
    case stars
    case forks
    case updated
}

public enum SearchOrder: String {
    case asc
    case desc
}

public class SearchAPI: GithubService {
    
    func searchRepositories(q: String, page: Int = 1, per_page: Int = 10, sort: SearchRepositoriesSort? = nil, order: SearchOrder = .desc, completion: @escaping (RepoSearchListModel?, Error?) -> Swift.Void) {
        let path = "/search/repositories"
        var parameters = [String : String]()
        parameters["q"] = q
        parameters["order"] = order.rawValue
        if let sort = sort {
            parameters["sort"] = sort.rawValue
        }
        parameters["page"] = "\(page)"
        parameters["per_page"] = "\(per_page)"
        
        self.gh_get(path: path, parameters: parameters, completion: completion)
    }
    
}

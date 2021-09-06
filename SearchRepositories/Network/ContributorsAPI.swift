//
//  ContributorsAPI.swift
//  GithubAPI_MVVM
//
//  Created by Arshad Ali on 06/08/21.
//

import Foundation

public class ContributorsAPI: GithubService {
    
    func getContributors(url: String, completion: @escaping ([ContributorModel]?, Error?) -> Swift.Void) {
        self.gt_get(path: url, completion: completion)
    }
    
}

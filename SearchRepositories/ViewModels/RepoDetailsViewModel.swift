//
//  RepoDetailsViewModel.swift
//  GithubAPI_MVVM
//
//  Created by Arshad Ali on 05/08/21.
//

import Foundation

class RepoDetailsViewModel
{
    var selectedRepo : Repo
    
    private var conytributorsApiService : ContributorsAPI!
    
    init(item: Repo) {
        selectedRepo = item
        self.conytributorsApiService =  ContributorsAPI()
        callFuncToGetContributorsData()
    }
    private(set) var contributorsData : [ContributorModel]! {
        didSet {
            self.bindContributorViewModelToController()
        }
    }
    
    var bindContributorViewModelToController : (() -> ()) = {}
    
    func callFuncToGetContributorsData() {
        self.conytributorsApiService.getContributors(url: selectedRepo.contributorsURL ?? "") { contributors, error in
            self.contributorsData = contributors
        }
    }
}

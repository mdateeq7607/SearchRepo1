
import Foundation
import UIKit

class HomeViewModel: NSObject
{
    private var searchApiService : SearchAPI!
    
    private(set) var repoData : [Repo]! {
        didSet {
            self.bindRepoViewModelToController()
        }
    }
    
    var bindRepoViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.searchApiService =  SearchAPI()
        self.repoData = [Repo]()
    }
    
    func callFuncToGetEmpData(q: String,page: Int) {
        self.searchApiService.searchRepositories(q: q, page: page) { repositories, error in
            self.repoData.append(contentsOf: repositories?.items ?? [])
        }
    }
}

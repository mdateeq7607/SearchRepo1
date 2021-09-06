//
//  RepoDetailsViewController.swift
//  GithubAPI_MVVM
//
//  Created by HTS on 02/08/21.
//

import UIKit

class RepoDetailsViewController: UIViewController {
    
    var viewModel: RepoDetailsViewModel!
    
    private var dataSource : RepoContributorsDataSource<SearchTableViewCell,ContributorModel>!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var btnOfProjectLink: UIButton!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var contributorsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contributorsTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        bindData()
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        
        self.viewModel.bindContributorViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        
        self.dataSource = RepoContributorsDataSource(cellIdentifier: "SearchTableViewCell", items: self.viewModel.contributorsData, configureCell: { (cell, evm) in
            cell.repoName.text = evm.login
        })
        
        DispatchQueue.main.async {
            self.contributorsTableView.dataSource = self.dataSource
            self.contributorsTableView.reloadData()
        }
    }
    
    func bindData() {
        self.avatarImageView.downloaded(from: self.viewModel.selectedRepo.owner?.avatarURL ?? "")
        self.nameLabel.text = self.viewModel.selectedRepo.owner?.login
        self.btnOfProjectLink.setTitle(self.viewModel.selectedRepo.url, for: .normal)
        self.descTextView.text = self.viewModel.selectedRepo.itemDescription
    }
    
    @IBAction func onClickProjectLink(_ sender: UIButton) {
        if let url = URL(string: self.viewModel.selectedRepo.htmlURL ?? "") {
            UIApplication.shared.open(url)
        }
    }
}


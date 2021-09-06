//
//  ViewController.swift
//  SearchRepositories
//
//  Created by Arshad Ali on 07/08/21.
//

import UIKit

class RepoListViewController: UIViewController {
    
    @IBOutlet weak var repoTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewModel: HomeViewModel!
    
    private var dataSource : SearchRepoTableViewDataSource<SearchTableViewCell,Repo>!
    var currentNoOfPerPage : Int = 10
    var isLoadingList : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.repoTableView.isHidden = true
        self.repoTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
    }
    
    func updateDataSource(){
        
        self.dataSource = SearchRepoTableViewDataSource(cellIdentifier: "SearchTableViewCell", items: self.viewModel.repoData, configureCell: { (cell, evm) in
            cell.repoName.text = evm.name
        })
        
        DispatchQueue.main.async {
            self.repoTableView.dataSource = self.dataSource
            self.repoTableView.reloadData()
        }
    }
}

extension RepoListViewController :UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchBar.resignFirstResponder()
            self.searchBar.text = ""
            self.repoTableView.isHidden = true
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.repoTableView.isHidden = false
        searchBar.resignFirstResponder()
        if searchBar.text != "" {
            viewModel = HomeViewModel()
            self.viewModel.callFuncToGetEmpData(q: searchBar.text ?? "", page: 1)
            self.viewModel.bindRepoViewModelToController = {
                self.updateDataSource()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.repoTableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RepoDetailsViewController") as! RepoDetailsViewController
        vc.viewModel = RepoDetailsViewModel(item: self.viewModel.repoData[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList){
            self.isLoadingList = true
            self.currentNoOfPerPage += 1
            self.viewModel.callFuncToGetEmpData(q: searchBar.text ?? "", page: currentNoOfPerPage)
            self.viewModel.bindRepoViewModelToController = {
                self.isLoadingList = false
                self.updateDataSource()
            }
        }
    }
    
}


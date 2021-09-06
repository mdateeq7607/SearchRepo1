//
//  SearchTableViewCell.swift
//  GithubAPI_MVVM
//
//  Created by HTS on 02/08/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repoName: UILabel!
    
    var repo : Repo? {
        didSet {
            repoName.text = repo?.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

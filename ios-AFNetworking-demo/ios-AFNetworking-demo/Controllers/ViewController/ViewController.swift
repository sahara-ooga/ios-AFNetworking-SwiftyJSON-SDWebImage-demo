//
//  ViewController.swift
//  ios-AFNetworking-demo
//
//  Created by OkuderaYuki on 2017/03/12.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    fileprivate var dataSource = PhotoCollectionView()

    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
    }
    
    private func setupDelegates() {
        searchBar.delegate = self
        collectionView.dataSource = dataSource
    }
}

// MARK:- UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text else { return }
        
        PhotozouAPI.getRequest(keyword: text, limit: 10) { [weak self] (result) in
            guard let weakSelf = self else { return }
            
            switch result {
            case .success(let result):
                weakSelf.dataSource.photoList = result as! PhotoList
                weakSelf.collectionView.reloadData()
                
            case .failure(let error):
                let alertController = UIAlertController(title: "",
                                                        message: error.localizedDescription,
                                                        preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                weakSelf.present(alertController, animated: true, completion: nil)
                
            }
        }
    }
}

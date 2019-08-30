//
//  ViewController.swift
//  LTMAN_GRAPHQL
//
//  Created by Ananchai Mankhong on 30/8/2562 BE.
//  Copyright © 2562 Ananchai Mankhong. All rights reserved.
//

import UIKit

class ContentCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

  
    private var Cell = "Cell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ล่าสุด"
        label.textColor = UIColor.blackAlpha(alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "ล่าสุด"
        label.textColor = UIColor.blackAlpha(alpha: 0.5)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    
    var contents: [PostDetails] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    func queryContent() {
        let getAllPostsQuery = ArQuery()
        apollo.fetch(query: getAllPostsQuery, cachePolicy: .fetchIgnoringCacheData) {
            [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                return
            case .success(let graphQLResult):
                guard let allPosts = graphQLResult.data?.articles.range.data.compactMap({$0}) else {
                    print("Cannot load all posts")
                    return
                }
                self?.contents = allPosts.map({$0.teaser.fragments.postDetails})
                print(allPosts)
                
            }
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        queryContent()
        
    }
    
    func setUpView() {
        
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        
        collectionView.backgroundColor = UIColor.whiteAlpha(alpha: 0.90)
        collectionView.register(ContentViewCell.self, forCellWithReuseIdentifier: Cell)
        //collectionView.showsVerticalScrollIndicator = false
    }
    
 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: Cell, for: indexPath) as! ContentViewCell
        item.titleContent.text = contents[indexPath.row].title
        item.photoURL = contents[indexPath.row].photo
        return item
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 450)
    }
    
    
    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0 {
            navigationItem.titleView = titleLabel
        } else {
            navigationItem.titleView = subTitleLabel
        }
    }
    
    
}



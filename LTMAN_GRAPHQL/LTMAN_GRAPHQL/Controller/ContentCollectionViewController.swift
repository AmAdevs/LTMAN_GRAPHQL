//
//  ViewController.swift
//  LTMAN_GRAPHQL
//
//  Created by Ananchai Mankhong on 30/8/2562 BE.
//  Copyright © 2562 Ananchai Mankhong. All rights reserved.
//

import UIKit
import Apollo


class ContentCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

  
    private var Cell = "Cell"
    private var LoadingCell = "LoadingCell"
    
    var contentsID: [InId] = []
    var getContent: [PostDetails] = []
    
    var allQueryWatcher: GraphQLQueryWatcher<ArQuery>?
    var limitPostId = 10
    var ID = "5d6e023b6525240caf55f392"
    var fetchingMore = false
    
    
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


    
    func queryContent(limit limitPostId: Int, id ID: String) {
        let getAllPostsQuery = ArQuery(postId: limitPostId, id: ID)
        allQueryWatcher = apollo.watch(query: getAllPostsQuery, cachePolicy: .returnCacheDataAndFetch) {
            [unowned self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                return
            case .success(let graphQLResult):
                guard let allPosts = graphQLResult.data?.articles.range.data.compactMap({$0}) else {
                    print("Cannot load all posts")
                    return
                }
                
                self.contents = allPosts.map({$0.teaser.fragments.postDetails})
                self.contentsID = allPosts.map({$0.fragments.inId})
          

            }
            
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        queryContent(limit: limitPostId, id: ID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func setUpView() {
        
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        let loadingNib = UINib(nibName: "Loading", bundle: nil)
        collectionView.register(loadingNib, forCellWithReuseIdentifier: LoadingCell)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        collectionView.backgroundColor = UIColor.whiteAlpha(alpha: 0.90)
        collectionView.register(ContentViewCell.self, forCellWithReuseIdentifier: Cell)
        //collectionView.showsVerticalScrollIndicator = false
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return contents.count
        } else if section == 1 && fetchingMore {
            return 1
        }
        return 0
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        if section == 0 {
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: Cell, for: indexPath) as! ContentViewCell
            item.titleContent.text = contents[indexPath.row].title
            item.photoURL = contents[indexPath.row].photo
            item.idLabel.text = contentsID[indexPath.row].id
            ID = item.idLabel.text!
            return item
        } else {
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCell, for: indexPath) as! Loading
            item.spinner.startAnimating()
            return item
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        if section == 0 {
            return CGSize(width: view.frame.width, height: 450)
        } else {
            return CGSize(width: view.frame.width, height: 30)
        }
     
    }
    
    
    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0 {
            navigationItem.titleView = titleLabel
        } else {
            navigationItem.titleView = subTitleLabel
        }
        
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offSetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                fectching()
            }
        }
    }
    
    
    func fectching() {
        fetchingMore = true
        collectionView.reloadSections(IndexSet(integer: 1))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.limitPostId += 10
            print(self.limitPostId)
            self.queryContent(limit: self.limitPostId, id: self.ID)
            self.fetchingMore = false
            self.collectionView.reloadData()
        }
    }
    
}



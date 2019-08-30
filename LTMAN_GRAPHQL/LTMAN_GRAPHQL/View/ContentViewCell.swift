//
//  CollectionViewCell.swift
//  LTMAN_GRAPHQL
//
//  Created by Ananchai Mankhong on 30/8/2562 BE.
//  Copyright © 2562 Ananchai Mankhong. All rights reserved.
//

import UIKit
import Kingfisher


class ContentViewCell: UICollectionViewCell {
    
    
    let titleContent: UILabel = {
        let label = UILabel()
        
        let title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.blackAlpha(alpha: 1)])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        
        label.attributedText = attributedText
        label.numberOfLines = 2
        return label
    }()
    
    
    let photoContent: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "xp")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 0
        return image
    }()
    
    
    var photoURL: String? {
        didSet {
            guard let getPhotoURL = self.photoURL,
                let url = URL(string: getPhotoURL) else { return }
            photoContent.kf.setImage(with: url)
        }
    }
    
    override func prepareForReuse() {
        photoContent.image = nil
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViewCell()
    }
    
    func setUpViewCell() {

        backgroundColor = .whiteAlpha(alpha: 1)
        
        addSubview(titleContent)
        addSubview(photoContent)
        
        titleContent.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 6, widthConstant: 0, heightConstant: 0)
        
        photoContent.anchor(titleContent.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

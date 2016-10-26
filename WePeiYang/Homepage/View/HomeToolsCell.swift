//
//  HomeToolsCell.swift
//  WePeiYang
//
//  Created by Qin Yubo on 16/1/9.
//  Copyright © 2016年 Qin Yubo. All rights reserved.
//

import UIKit

@objc protocol HomeToolsCellDelegate {
    optional func toolsTappedAtIndex(index: Int)
}

class HomeToolsCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var toolsCollectionView: UICollectionView!
    
    weak var delegate: HomeToolsCellDelegate!
    
    let homeTools = [
        (title: "成绩", image: UIImage(named: "gpaBtn")!),
        (title: "自行车", image: UIImage(named: "bicycleBtn")!),
        (title: "课程表", image: UIImage(named: "classtableBtn")!),
//        (title: "失物招领", image: UIImage(named: "lfBtn")!)
        (title: "阅北洋", image: UIImage(named: "readBtn")!)
    ]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let nib = UINib(nibName: "HomeToolsCollectionViewCell", bundle: nil)
        toolsCollectionView.registerNib(nib, forCellWithReuseIdentifier: "cellIdentifier")
        toolsCollectionView.backgroundColor = UIColor.whiteColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeTools.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        //smaller icon
        return CGSizeMake(collectionView.bounds.width/CGFloat(homeTools.count), collectionView.bounds.height)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellIdentifier", forIndexPath: indexPath) as! HomeToolsCollectionViewCell
        let row = indexPath.row
        cell.iconImage.image = homeTools[row].image
        cell.titleLabel.text = homeTools[row].title
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegate.toolsTappedAtIndex!(indexPath.row)
    }
    
}

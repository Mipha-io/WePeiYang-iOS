//
//  InfoViewController.swift
//  YuePeiYang
//
//  Created by Halcao on 2016/10/22.
//  Copyright © 2016年 Halcao. All rights reserved.
//

import UIKit
import AFNetworking

class InfoViewController: UITableViewController {

    let review_url = "http://162.243.136.96/review.json"
    let bookshelf_url = "http://162.243.136.96/bookshelf.json"
    var headerArr: [String] = ["我的收藏", "我的点评"]
    var bookShelf: [MyBook] = []
    var reviewArr: [Review] = []

    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.frame = CGRect(x: self.tableView.frame.origin.x, y: 108, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height-108)
        User.sharedInstance.getBookShelf({
            self.bookShelf = User.sharedInstance.bookShelf
            self.tableView.reloadData()
        })
        User.sharedInstance.getReviewArr({
            self.reviewArr = User.sharedInstance.reviewArr
            self.tableView.reloadData()
        })

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        self.tableView.style
        self.tableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .None
    }
    
// MARK: push to viewcontroller
    func sectionTapped(sender: UITapGestureRecognizer)
    {
        guard let tag = sender.view?.tag else{
            return
        }
        switch tag {
        case 0:
            let bvc = BookShelfViewController()
            // TODO: only push once
            // bvc.bookShelf = self.bookShelf
            self.navigationController?.pushViewController(bvc, animated: true)
        case 1:
            let rvc = ReviewListViewController()
            rvc.reviewArr = self.reviewArr
            self.navigationController?.pushViewController(rvc, animated: true)
            break
        default:
            break
        }
    }
    
// Mark: UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return (bookShelf.count > 2) ? 2 : bookShelf.count
        case 1:
            return (reviewArr.count > 2) ? 2 : reviewArr.count
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell1")
            cell.textLabel?.text = self.bookShelf[indexPath.row].title
            cell.textLabel?.font = UIFont.systemFontOfSize(16)
            cell.detailTextLabel?.font = UIFont.systemFontOfSize(12)
            cell.detailTextLabel?.text = self.bookShelf[indexPath.row].author
            print(self.bookShelf[indexPath.row].id)
            if indexPath.row != self.bookShelf.count - 1 && indexPath.row != 2 - 1 {
                let separator = UIView()
                separator.backgroundColor = UIColor.init(red: 227/255, green: 227/255, blue: 229/255, alpha: 1)
                cell.addSubview(separator)
                separator.snp_makeConstraints { make in
                    make.height.equalTo(1)
                    make.left.equalTo(cell).offset(20)
                    make.right.equalTo(cell).offset(-20)
                    make.bottom.equalTo(cell).offset(0)
                }
            }
            return cell
        case 1:
            let cell = ReviewCell(model: self.reviewArr[indexPath.row])
            if indexPath.row == 1 {
                cell.separator.removeFromSuperview()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            // TODO: 删除的时候section也会动
            if editingStyle == .Delete {
                User.sharedInstance.delFromFavourite(with: "\(self.bookShelf[indexPath.row].id)") {
                    self.bookShelf.removeAtIndex(indexPath.row)
                    User.sharedInstance.bookShelf = self.bookShelf
                    self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    self.tableView.reloadData()
                }
            }
            break
        default:
            return
        }
    }

    
// MARK: HeaderView delegate
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UITableViewCell()
        header.contentView.backgroundColor = UIColor.init(red: 254/255, green: 255/255, blue: 255/255, alpha: 1)
        header.textLabel?.textColor = UIColor.init(red: 136/255, green: 137/255, blue: 138/255, alpha: 1)
        header.detailTextLabel?.textColor = UIColor.init(red: 163/255, green: 163/255, blue: 163/255, alpha: 1)
        header.textLabel!.text = headerArr[section]
        header.detailTextLabel?.font = UIFont.systemFontOfSize(16)
        header.accessoryType = .DisclosureIndicator
        header.backgroundColor = UIColor.whiteColor()
        header.userInteractionEnabled = true
        // tag 作为点击事件的索引 跳转到相关控制器
        header.tag = section
        let tap = UITapGestureRecognizer(target: self, action: #selector(InfoViewController.sectionTapped(_:)))
        header.addGestureRecognizer(tap)
        let 🌚 = UIView()
        header.addSubview(🌚)
        🌚.backgroundColor = UIColor.init(red: 245/255, green: 246/255, blue: 247/255, alpha: 1)
        🌚.snp_makeConstraints { make in
            make.height.equalTo(2)
            make.left.equalTo(header).offset(0)
            make.right.equalTo(header).offset(0)
            make.bottom.equalTo(header).offset(0)
        }
        return header
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 0:
            if bookShelf.count == 0 {
                // 🤓 stands for footer
                let 🤓 = UITableViewCell(style: .Default, reuseIdentifier: "footer")
                🤓.backgroundColor = UIColor.whiteColor()
                🤓.textLabel?.text = "暂时还没有收藏，快去收藏吧！"
                🤓.textLabel?.sizeToFit()
                🤓.textLabel?.snp_makeConstraints { make in
                    make.centerX.equalTo(🤓.contentView.snp_centerX)
                    make.centerY.equalTo(🤓.contentView.snp_centerY)
                }
                // 🌚 stands for separator
                let 🌚 = UIView()
                🤓.addSubview(🌚)
                🌚.backgroundColor = UIColor.init(red: 245/255, green: 246/255, blue: 247/255, alpha: 1)
                🌚.snp_makeConstraints { make in
                    make.height.equalTo(2)
                    make.left.equalTo(🤓).offset(0)
                    make.right.equalTo(🤓).offset(0)
                    make.bottom.equalTo(🤓).offset(0)
                }
                return 🤓
            }
        case 1:
            if reviewArr.count == 0 {
                // 🤓 stands for footer
                let 🤓 = UITableViewCell(style: .Default, reuseIdentifier: "footer")
                🤓.backgroundColor = UIColor.whiteColor()
                🤓.textLabel?.text = "暂时还没有评论，快去评论吧！"
                🤓.textLabel?.sizeToFit()
                🤓.textLabel?.snp_makeConstraints { make in
                    make.centerX.equalTo(🤓.contentView.snp_centerX)
                    make.centerY.equalTo(🤓.contentView.snp_centerY)
                }
//                // 🌚 stands for separator
//                let 🌚 = UIView()
//                🤓.addSubview(🌚)
//                🌚.backgroundColor = UIColor.init(red: 245/255, green: 246/255, blue: 247/255, alpha: 1)
//                🌚.snp_makeConstraints { make in
//                    make.height.equalTo()
//                    make.left.equalTo(🤓).offset(0)
//                    make.right.equalTo(🤓).offset(0)
//                    make.bottom.equalTo(🤓).offset(0)
//                }
                return 🤓
            }
        default:
            break
        }
        return nil
    }
    
    
// MARK: Select Row at IndexPath
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            let vc = BookDetailViewController(bookID: "\(self.bookShelf[indexPath.row].id)")
            self.navigationController?.showViewController(vc, sender: nil)
            break
        case 1:
            print("Push Detail View Controller, bookID: \(reviewArr[indexPath.row].bookID)")
            let vc = BookDetailViewController(bookID: "\(self.reviewArr[indexPath.row].bookID)")
            self.navigationController?.showViewController(vc, sender: nil)

        default:
            break
        }
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            if bookShelf.count == 0 {
                return 70
            }
            return 10;
        case 1:
            if reviewArr.count == 0 {
                return 70
            }
        default:
            return 0;
        }
        return 0;
    }
    
}

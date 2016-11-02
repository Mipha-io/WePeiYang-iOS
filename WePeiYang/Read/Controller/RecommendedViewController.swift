//
//  RecommendedViewController.swift
//  WePeiYang
//
//  Created by JinHongxu on 2016/10/25.
//  Copyright © 2016年 Qin Yubo. All rights reserved.
//

import UIKit
import SafariServices

class RecommendedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, RecommendBookViewDelegate {
    
    
    let tableView = UITableView(frame: CGRect(x: 0, y: 108, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height-108) , style: .Grouped)
    let sectionList = ["热门推荐", "热门书评", "阅读之星"]
    var headerScrollView = UIScrollView()
    let pageControl = UIPageControl()
    var loadingView = UIView()
    
//    let bannerList = ["http://www.twt.edu.cn/upload/banners/hheZnqd196Te76SDF9Ww.png", "http://www.twt.edu.cn/upload/banners/ZPQqmajzKOI3A6qE7gIR.png", "http://www.twt.edu.cn/upload/banners/gJjWSlAvkGjZmdbuFtXT.jpeg"]
    
    //var reviewList = [MyReview]()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        if !Recommender.sharedInstance.dataDidRefresh {
            initLoadingView()
        }
        Recommender.sharedInstance.getBannerList(refreshUI)
        Recommender.sharedInstance.getRecommendedList(refreshUI)
        Recommender.sharedInstance.getHotReviewList(refreshUI)
        Recommender.sharedInstance.getStarUserList(refreshUI)
        
        //initReviews(tableView.reloadData)
    }
    
    func initLoadingView() {
        loadingView = UIView(frame: CGRect(x: 0, y: 108, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height-108))
        loadingView.backgroundColor = UIColor.whiteColor()
        view.addSubview(loadingView)
        MsgDisplay.showLoading()
    }
    
    func refreshUI() {
        if Recommender.sharedInstance.finishFlag.isFinished() {
            Recommender.sharedInstance.dataDidRefresh = true
            Recommender.sharedInstance.finishFlag.reset()
            loadingView.removeFromSuperview()
            MsgDisplay.dismiss()
        }
        tableView.reloadData()
    }
    
    func initReviews(success: () -> ()) {
        
//        for i in 0...3 {
//            let foo = MyReview()
//            foo.initWithDict(
//                [
//                    "content": "James while John had had had had had had had had had had had a better effect on the teacher",
//                    "rate": i,
//                    "like": i,
//                    "timestamp": 143315151,
//                    "book": [
//                        "title": "活着",
//                        "isbn": "ABS-131"
//                    ]
//                ])
//            reviewList.append(foo)
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initUI() {
        
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .None
    }
    
    
    //Table DataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return Recommender.sharedInstance.reviewList.count
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = RecommendCell(model: Recommender.sharedInstance.recommendedList)
            for fooView in cell.fooView {
                fooView.delegate = self
            }
            return cell
        case 1:
            let cell = ReviewCell(model: Recommender.sharedInstance.reviewList[indexPath.row])
            return cell
        case 2:
            let cell = ReadStarCell(model: Recommender.sharedInstance.starList)
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
        
    }
    
    //    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        switch indexPath.section {
    //        case 0:
    //            return 200
    //        case 2:
    //            return 160
    //        default:
    //            return 0
    //        }
    //    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return UIScreen.mainScreen().bounds.width*0.375+32
        }
        return 16
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionList[section]
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.width*0.375+32))
            
            headerScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.width*0.375))
            
            headerView.addSubview(headerScrollView)
            headerView.addSubview(pageControl)
            
//            headerScrollView.snp_makeConstraints {
//                make in
//                make.top.equalTo(headerView)
//                make.left.equalTo(headerView)
//                make.right.equalTo(headerView)
//                make.bottom.equalTo(headerView).offset(-32)
//            }
            
            pageControl.snp_makeConstraints {
                make in
                make.centerX.equalTo(headerScrollView)
                make.bottom.equalTo(headerScrollView)
            }
            
            //设置scrollView的内容总尺寸
            headerScrollView.contentSize = CGSize(width: CGFloat(UIScreen.mainScreen().bounds.width)*CGFloat(Recommender.sharedInstance.bannerList.count), height: UIScreen.mainScreen().bounds.width*0.375)
            //关闭滚动条显示
            headerScrollView.showsHorizontalScrollIndicator = false
            headerScrollView.showsVerticalScrollIndicator = false
            headerScrollView.scrollsToTop = false
            //无弹性
            headerScrollView.bounces = false
            //协议代理，在本类中处理滚动事件
            headerScrollView.delegate = self
            //滚动时只能停留到某一页
            headerScrollView.pagingEnabled = true
            //添加页面到滚动面板里
            for (seq, banner) in Recommender.sharedInstance.bannerList.enumerate() {
                let imageView = UIImageView()
                imageView.setImageWithURL(NSURL(string: banner.image)!);
                imageView.frame = CGRect(x: CGFloat(seq)*UIScreen.mainScreen().bounds.width, y: 0,
                                         width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.width*0.375)
                imageView.userInteractionEnabled = true
                imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(RecommendedViewController.pushWebPage)))
                headerScrollView.addSubview(imageView)
            }
            
            //页控件属性
            pageControl.backgroundColor = UIColor.clearColor()
            pageControl.numberOfPages = Recommender.sharedInstance.bannerList.count
            pageControl.currentPage = 0
            //设置页控件点击事件
            pageControl.addTarget(self, action: #selector(pageChanged(_:)),
                                  forControlEvents: UIControlEvents.ValueChanged)
            
            let fooLabel = UILabel(text: "热门推荐")
            fooLabel.textColor = UIColor.grayColor()
            fooLabel.font = UIFont(name: "Arial", size: 13)
            headerView.addSubview(fooLabel)
            
            fooLabel.snp_makeConstraints {
                make in
                make.top.equalTo(headerScrollView.snp_bottom).offset(10)
                make.left.equalTo(headerView).offset(14)
            }
            
            return headerView
        } else {
            return nil
        }
    }
    
    //Table View Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let detailVC = BookDetailViewController(bookID: Recommender.sharedInstance.reviewList[indexPath.row].bookID)
        self.navigationController?.showViewController(detailVC, sender: nil)
        print("Push Detail View Controller, bookID: \(Recommender.sharedInstance.reviewList[indexPath.row].bookID)")
    }
    
    //UIScrollViewDelegate方法，每次滚动结束后调用
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //通过scrollView内容的偏移计算当前显示的是第几页
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        //设置pageController的当前页
        pageControl.currentPage = page
    }
    
    //点击页控件时事件处理
    func pageChanged(sender:UIPageControl) {
        //根据点击的页数，计算scrollView需要显示的偏移量
        var frame = headerScrollView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        //展现当前页面内容
        headerScrollView.scrollRectToVisible(frame, animated:true)
    }
    
    func pushDetailViewController(bookID: String) {
        let detailVC = BookDetailViewController(bookID: bookID)
        self.navigationController?.showViewController(detailVC, sender: nil)
        self.navigationController?.navigationBarHidden = true
        print("Push Detail View Controller, bookID: \(bookID)")
    }
    
    func pushWebPage() {
        if #available(iOS 9.0, *) {
            let safariController = SFSafariViewController(URL: NSURL(string: Recommender.sharedInstance.bannerList[pageControl.currentPage].url)!, entersReaderIfAvailable: true)
            presentViewController(safariController, animated: true, completion: nil)
        } else {
            let webController = WebAppViewController(address: Recommender.sharedInstance.bannerList[pageControl.currentPage].url)
            self.navigationController?.pushViewController(webController, animated: true)
            self.jz_navigationBarBackgroundAlpha = 0
        }
    }
    
}

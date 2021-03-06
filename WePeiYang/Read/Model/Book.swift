//
//  Book.swift
//  WePeiYang-iOS
//
//  Created by Allen X on 10/25/16.
//  Copyright © 2016 allenx. All rights reserved.
//


//class Review {
//    let content
//}

import Foundation

class Book {
    
    struct Status {
        let id: Int
        let barcode: String
        let callno: String
        let stateCode: Int
        let statusInLibrary: String
        let libCode: String
        let localCode: String
        let dueTime: String
        let library: String
    }
    
    let id: Int
    let title: String
    let ISBN: String
    let author: String
    let publisher: String
    let year: String
    let coverURL: String
    let rating: Double
    let summary: String
    let status: [Status]
    var reviews: [Review]
    let starReviews: [StarReview]
    
//    init() {
//        self.id = id
//        self.title = title
//        self.ISBN = ISBN
//        self.author = author
//        self.publisher = publisher
//        self.year = year
//        self.coverURL = coverURL
//        self.rating = rating
//        self.summary = summary
//        self.status = status
//        self.reviews = reviews
//        self.starReviews = starReviews
//    }
    
    init(id: Int, title: String, ISBN: String, author: String, publisher: String, year: String, coverURL: String, rating: Double, summary: String, status: [Status], reviews: [Review], starReviews: [StarReview]) {
        self.id = id
        self.title = title
        self.ISBN = ISBN
        self.author = author
        self.publisher = publisher
        self.year = year
        self.coverURL = coverURL
        self.rating = rating
        self.summary = summary
        self.status = status
        self.reviews = reviews
        self.starReviews = starReviews
    }
    
    init(ISBN: String) {
        self.id = 1
        self.ISBN = ISBN
        
        self.status = [Status(id: 23322, barcode: "sdf", callno: "sdf", stateCode: 1, statusInLibrary: "sdf", libCode: "1", localCode: "sdf", dueTime: "sdf", library: "sdf")]
        self.title = "孤本"
        self.coverURL = "https://images-na.ssl-images-amazon.com/images/I/51w6QuPzCLL._SX319_BO1,204,203,200_.jpg"
        self.author = "鲍 一心"
        self.publisher = "新星出版社"
        self.year = "2018 年"
        self.rating = 4.8
        self.summary = "有时候你需要修改已经存在的约束为了移动或者移除、代替约束。\n 在SnapKit 有一些不同的方法更新约束引用（References）你可以通过将约束的结果赋值给一个局部变量或一个类属性来保持一个特定的约束的引用。您还可以将多个约束引用存储在数组中。"

        self.reviews = [Review(reviewID: 32, bookID: 32, bookName: "孤本", userName: "sdf", avatarURL: "sdfsdf", rating: 2.0, like: 2, content: "sdfsdf", updateTime: "dfsdf", liked: false)]


        self.starReviews = [StarReview(name: "sdfs", content: "dfsdf")]
    }

}

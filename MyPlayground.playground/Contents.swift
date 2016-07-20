//: Playground - noun: a place where people can play

import UIKit

import XCPlayground

var str = "Hello, playground"

var appView: UIWebView = UIWebView(frame: CGRectMake(0,0,400,400))

var appURL: NSURL;

appURL = NSURL(string: "https://www.apple.com")!

appView.loadRequest(NSURLRequest(URL:appURL))
XCPlaygroundPage.currentPage.liveView = appView


				
//
//  ViewController.swift
//  TheWikipediaSearch
//
//  Created by Reem alsharif on 9/6/17.
//  Copyright © 2017 Reem alsharif. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    
    @IBOutlet weak var Search: UIButton!
    
    
    
    @IBAction func SearchWiki(_ sender: Any) {
    
    
    let urlOfWikipedia = URL(string: "http://en.wikipedia.org/wiki/\(searchTextField.text!)")
    let requestt = URLRequest(url: (urlOfWikipedia)!)
    webView.loadRequest(requestt)
    let stringOfPagesUserVisited = "This is your reques \(String(describing: urlOfWikipedia))"
    var array = [String]()
    array.append(stringOfPagesUserVisited)
    for pagesUserVisited in array{
    print("The pages: \(pagesUserVisited)")
    
    }
}
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://en.wikipedia.org/")
        let request = URLRequest(url:url!)
        webView.loadRequest(request)
        _ = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(ViewController.check), userInfo: nil, repeats: true)
    }
    
    func check() {
        guard let trimmedString = searchTextField.text?.trimmingCharacters(in: .whitespaces),!((trimmedString.isEmpty))  else {
            searchButton.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
            searchButton.isEnabled = false
            return
        }
        
        searchButton.setTitleColor(UIColor.darkText, for: UIControlState.normal)
        searchButton.isEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



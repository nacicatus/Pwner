//
//  WCViewController.swift
//  Pwner
//
//  Created by Saurabh_Sikka on 2021. 09. 23..
//

import UIKit

class WCViewController: UIViewController
{
    
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var objectBox: UIView!
    @IBOutlet weak var methodBox: UIView!
    
    
    
    var objectArray = [String]()
    var methodArray = [String]()
    
    var objectSet: Set<String>? {
        didSet {
            configureView()
        }
    }
    var methodSet: Set<String>? {
        didSet {
            configureView()
        }
    }
    
    var story: String? {
        didSet {
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOA()
        populateMA()
        
        configureView()
    }
    
    func populateOA(){
        for item in objectSet! {
            objectArray.append(item)
        }
    }
    
    func populateMA(){
        for item in methodSet! {
            methodArray.append(item)
        }
    }
    
    func configureView(){

        storyLabel?.text = story!
        
        for sdex in 0..<objectArray.count {
            let dex = 160 + (50 * sdex)
            let nlabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 36))
            nlabel.center = CGPoint(x: 100, y: dex)
            nlabel.textAlignment = .center
            nlabel.textColor = UIColor.blue
            nlabel.text = objectArray[sdex]
            nlabel.layer.borderColor = UIColor.blue.cgColor
            nlabel.layer.borderWidth = 3.0
            nlabel.isUserInteractionEnabled = true
            self.view.addSubview(nlabel)
        }
        
        for sdey in 0..<methodArray.count {
            let dey = 300 + (50 * sdey)
            let vlabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 36))
            vlabel.center = CGPoint(x: 100, y: dey)
            vlabel.textAlignment = .center
            vlabel.textColor = UIColor.red
            vlabel.text = methodArray[sdey]
            vlabel.layer.borderColor = UIColor.red.cgColor
            vlabel.layer.borderWidth = 3.0
            vlabel.isUserInteractionEnabled = true
            self.view.addSubview(vlabel)
        }
    }
}


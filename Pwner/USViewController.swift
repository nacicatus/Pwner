//
//  USViewController.swift
//  Pwner
//
//  Created by Saurabh_Sikka on 2021. 09. 23..
//

import UIKit
import NaturalLanguage

class USViewController: UIViewController {
    
    var userStory : String!
    var scenarioText: String!
    var actor: String!
    var act: String!
    var outcome: String!
    
//    var lexi: [String:Substring]!
    var atticArray = [String]()
    var nounSet = Set<String>()
    var verbSet = Set<String>()
    
    
    @IBOutlet weak var primaryActor: UITextField!
    @IBOutlet weak var action: UITextField!
    @IBOutlet weak var goal: UITextField!
    @IBOutlet weak var journey: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func analyse(_ sender: UIButton) {
        actor = primaryActor.text
        act = action.text
        outcome = goal.text
        scenarioText = journey.text  // get the matter from the Text Field
        
        // local variables that will be transferred to next VC
        // 1 : User Story
//        userStory = "As a \(actor ?? "user"), I want \(act ?? "to do something"), so that \(outcome ?? "something will happen")."  // prepare for segue
//        print(userStory!)
        
        // 2: Objects and Methods
        nlpize(scenarioText)
    }
    
    func nlpize(_ text: String){
        
        // What Language?
        let tagger = NLTagger(tagSchemes: [.language, .lexicalClass])
        let options : NLTagger.Options = [.omitWhitespace, .omitPunctuation]
        
        tagger.string = text
        let lang = tagger.dominantLanguage?.rawValue
        print("The user story is written in \(lang!)")
        
        
        // find lexical class of each word in the text
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange in
            
            if let tig = tag {
                let lexit = tig.rawValue
                let lunn = String(text[tokenRange])
                
                switch lexit {
                case "Verb":
                    verbSet.insert(lunn)
                case "Noun":
                    nounSet.insert(lunn)
                default:
                    atticArray.append(lunn)
                }
        
                print("\(lunn) : \(lexit)")
                
            }
            return true
        }
        print("OBJECTS:")
        for item in nounSet {
            print(item)
        }
        print("METHODS:")
        for item in verbSet {
            print(item)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard
            segue.identifier == "wordcloud",
            let nextVC = segue.destination as? WCViewController
        else {
            return
        }
        userStory = "As a \(actor ?? "user"), I want \(act ?? "to do something"), so that \(outcome ?? "something will happen")."  // prepare for segue
        print(userStory!)
        
        nextVC.objectSet = nounSet
        nextVC.methodSet = verbSet
        nextVC.story = userStory
    }


}


//
//  EditControllerViewController.swift
//  rss-reader
//
//  Created by Svyatoslav Titov on 22.03.2018.
//  Copyright © 2018 Svyatoslav Titov. All rights reserved.
//

import UIKit

class EditControllerViewController: UIViewController {

    @IBOutlet weak var _urlText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _urlText.addTarget(self, action: #selector(validateUrl), for: UIControlEvents.editingChanged)
    }

    @objc func validateUrl(textField: UITextField){
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func applyData(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
        let settings = UserDefaults.standard
        settings.set(_urlText.text, forKey: "UrlAddress")
    }
}

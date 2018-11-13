//
//  ViewController.swift
//  swiping
//
//  Created by Yvette Zhukovsky on 11/13/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func updateRating(_ ratingControl: CustomControl) {
        let valueRating = ratingControl.value
        
        // self.title = "User Rating: \(ratingControl.value) stars"
        if valueRating > 1 {
            self.title = "User Rating: \(valueRating) stars"
        } else {
           self.title = "User Rating: \(valueRating) star"
        }
        
        
    }
    
    
}

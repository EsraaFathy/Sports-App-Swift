//
//  ViewController.swift
//  SportsApp
//
//  Created by Esraa on 19/04/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "nav" {
                let a = segue.destination as! LeagueEventsViewController
                a.id = "4328"
                }
        }

    @IBAction func navigate(_ sender: Any) {
       // self.performSewithIdentifiergue(: "nav", sender: self)
    }
}


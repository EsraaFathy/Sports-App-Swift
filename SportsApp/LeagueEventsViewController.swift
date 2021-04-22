//
//  LeagueEventsViewController.swift
//  SportsApp
//
//  Created by Esraa on 21/04/2021.
//

import UIKit

class LeagueEventsViewController: UIViewController {
var lastEventsArray = [DatumLastEvents]()
    override func viewDidLoad() {
        super.viewDidLoad()
        lastEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa", employeeSalary: 2, employeeAge: 3, profileImage: "1"))
        lastEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa1", employeeSalary: 2, employeeAge: 3, profileImage: "1"))
        lastEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa2", employeeSalary: 2, employeeAge: 3, profileImage: "1"))
        // Do any additional setup after loading the view.
    }
    
}

//Last 15 Events by League Id
//https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id=4328
//
//
//List all Teams in a League
//https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=English%20Premier%20League

extension LeagueEventsViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lastEventsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! LastEventesTableViewCell
        cell.countLabelView1.text = "2"
        cell.countLabelView2.text = "3"
        cell.imageView1.image = UIImage(named: "1")
        cell.view1.layer.cornerRadius = 20.0
        cell.imageViw2.image = UIImage(named: "1")
        cell.view2.layer.cornerRadius = 20.0
        return cell
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 170.0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Last Events"
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
}

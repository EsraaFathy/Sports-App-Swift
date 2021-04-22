//
//  LeagueEventsViewController.swift
//  SportsApp
//
//  Created by Esraa on 21/04/2021.
//

import UIKit

class LeagueEventsViewController: UIViewController {
    @IBOutlet weak var upcommingCollectionView: UICollectionView!
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    var lastEventsArray = [DatumLastEvents]()
    var upcommingEventsArray = [DatumLastEvents]()
    var teams = [String]()



    override func viewDidLoad() {
        super.viewDidLoad()
        self.upcommingCollectionView.delegate = self
        self.upcommingCollectionView.dataSource = self
        self.teamsCollectionView.delegate = self
        self.teamsCollectionView.dataSource = self
        
        lastEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa", employeeSalary: 2, employeeAge: 3, profileImage: "1"))
        lastEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa1", employeeSalary: 2, employeeAge: 3, profileImage: "1"))
        lastEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa2", employeeSalary: 2, employeeAge: 3, profileImage: "1"))

        upcommingEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa", employeeSalary: 2, employeeAge: 3, profileImage: "1"))
        upcommingEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa1", employeeSalary: 2, employeeAge: 3, profileImage: "1"))
        upcommingEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa2", employeeSalary: 2, employeeAge: 3, profileImage: "1"))
        upcommingEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa", employeeSalary: 2, employeeAge: 3, profileImage: "1"))
        upcommingEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa1", employeeSalary: 2, employeeAge: 3, profileImage: "1"))
        upcommingEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa2", employeeSalary: 2, employeeAge: 3, profileImage: "1"))
        
        teams.append("1")
        teams.append("1")
        teams.append("1")
        teams.append("1")
        teams.append("1")
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


extension LeagueEventsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == upcommingCollectionView {
            return upcommingEventsArray.count
        }else{
            return teams.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == upcommingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellh1", for: indexPath as IndexPath) as! UpCommingCollectionViewCell
            cell.labelCounter1.text = "2"
            cell.labelCounter2.text = "3"
            cell.imageView1.image = UIImage(named: "1")
            cell.view1.layer.cornerRadius = 20.0
            cell.imageView2.image = UIImage(named: "1")
            cell.view2.layer.cornerRadius = 20.0
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellh2", for: indexPath as IndexPath) as! TeamsCollectionViewCell
            cell.teamImageViw.image = UIImage(named: "1")
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == upcommingCollectionView {
            return CGSize(width: 300, height: 180)
        }else{
            return CGSize(width: 185, height: 144)
        }
    
    
}
}

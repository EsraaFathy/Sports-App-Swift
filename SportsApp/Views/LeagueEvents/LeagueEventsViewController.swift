//
//  LeagueEventsViewController.swift
//  SportsApp
//
//  Created by Esraa on 21/04/2021.
//

import UIKit
import Alamofire
import SDWebImage
import CoreData

class LeagueEventsViewController: UIViewController {
    
    @IBOutlet weak var buttonImage: UIBarButtonItem!
    var id = ""
    @IBOutlet weak var lastEventsTableView: UITableView!
    @IBOutlet weak var upcommingCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    var lastEventsArray = [Events]()
    var upcommingEventsArray = [UpCommingEvents]()
    var teams = [Teams]()
    var arrayOfFafourite = [FavoriteModelCoreData]()
    var flag = false
    var model : FavoriteModelCoreData!
    var teamID = ""
    
    var upCommingViewModel : UpcommingViewModel!
    
    @IBAction func addToFavourite(_ sender: Any) {
        if flag == false {
        let appDeleget = UIApplication.shared.delegate as! AppDelegate
        let cont = appDeleget.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavouriteCoreData", in: cont)
        let m = NSManagedObject(entity: entity!, insertInto: cont)
        m.setValue(model.title , forKey: "title")
        m.setValue(model.image, forKey: "image")
        m.setValue(model.youtube, forKey: "youtube")
        m.setValue(model.id, forKey: "id")
        try? cont.save()
        self.featchCoreData()
        }else{
            deleteFromCoreData()
            self.featchCoreData()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.upcommingCollectionView.delegate = self
        self.upcommingCollectionView.dataSource = self
        self.teamsCollectionView.delegate = self
        self.teamsCollectionView.dataSource = self
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        self.scrollView.contentSize = CGSize(width: screenWidth, height: 1000)
        self.scrollView.frame = CGRect(x: 0, y: 70, width: screenWidth, height: screenHeight)
        scrollView.backgroundColor = UIColor.clear

        self.featchCoreData()
        self.feachTeams(LeagueId: id)
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
        
        self.title = lastEventsArray[indexPath.row].strLeague
        cell.countLabelView1.text = lastEventsArray[indexPath.row].intHomeScore
        cell.countLabelView2.text = lastEventsArray[indexPath.row].intAwayScore
        cell.dateLabelView.text = lastEventsArray[indexPath.row].dateEvent
        if lastEventsArray[indexPath.row].idHomeTeam != nil &&
            lastEventsArray[indexPath.row].idAwayTeam != nil{
            let teamsPics = self.getTeamPic(teamOneId: lastEventsArray[indexPath.row].idHomeTeam!, teamTwoId: lastEventsArray[indexPath.row].idAwayTeam!, teams: teams)
                    cell.imageView1.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    cell.imageView1.sd_setImage(with: URL(string: teamsPics[0]), placeholderImage: UIImage(named: "placeholder"))
                    cell.view1.layer.cornerRadius = 20.0
                    cell.imageViw2.sd_imageIndicator = SDWebImageActivityIndicator.gray

                    cell.imageViw2.sd_setImage(with: URL(string: teamsPics[1]), placeholderImage: UIImage(named: "placeholder"))
                    cell.view2.layer.cornerRadius = 20.0
        }
        
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
            print(teams.count)
            return teams.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == upcommingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellh1", for: indexPath as IndexPath) as! UpCommingCollectionViewCell
            cell.labelCounter1.text = upcommingEventsArray[indexPath.row].intHomeScore
            cell.labelCounter2.text = upcommingEventsArray[indexPath.row].intAwayScore
            cell.dateLabeel.text = upcommingEventsArray[indexPath.row].dateEvent
            let teamsPics = self.getTeamPic(teamOneId: upcommingEventsArray[indexPath.row].idHomeTeam!, teamTwoId: upcommingEventsArray[indexPath.row].idAwayTeam!, teams: teams)
            cell.imageView1.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imageView1.sd_setImage(with: URL(string: teamsPics[0]), placeholderImage: UIImage(named: "placeholder"))
            cell.view1.layer.cornerRadius = 20.0
            cell.imageView2.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imageView2.sd_setImage(with: URL(string: teamsPics[1]), placeholderImage: UIImage(named: "placeholder"))
            cell.view1.layer.cornerRadius = 20.0
            cell.view2.layer.cornerRadius = 20.0
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellh2", for: indexPath as IndexPath) as! TeamsCollectionViewCell
            cell.teamImageViw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.teamImageViw!.sd_setImage(with: URL(string: teams[indexPath.row].strTeamBadge!), placeholderImage: UIImage(named: "placeholder"))
            cell.backGroundView.layer.cornerRadius = 55.0
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == upcommingCollectionView {
            return CGSize(width: 320, height: 180)
        }else{
            return CGSize(width: 185, height: 110)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "teamsSeague" {
//            let a = segue.destination as! // class TeamsDetails
//            a.id = teamID
//            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamsCollectionView {
            self.teamID = teams[indexPath.row].idTeam!
            // self.performSegue(withIdentifier: "navHome", sender: nil)
        }
        print("pressed")

    }
}

//servies
extension LeagueEventsViewController{
    func fetchLastEvents(leagueId id:String) {
          let url = "https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id=\(id)"
            AF.request(url)
                .validate()
                .responseDecodable(of: LastAllEvents.self) { (response) in
                    switch response.result {
                    case .success( _):
                        guard let lastevents = response.value else { return }
                        if lastevents.events != nil {
                            self.lastEventsArray = lastevents.events!
                                                    self.lastEventsTableView.reloadData()

                        }
                        
                    case .failure(let error):
                        print(error)
                        break
                    }
        }
    }
    
    
    func feachTeams(LeagueId id:String){
        //https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=4328
        let url = "https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=\(id)"
        print("id.........\(id)")
        AF.request(url)
            .validate()
            .responseDecodable(of: TeamsClassModel.self) { (response) in
                switch response.result {
                case .success( _):
                    guard let teamsResponse = response.value else { return }
                    if teamsResponse.teams != nil {
                        self.teams = teamsResponse.teams!
                        self.feachUpComming(LeagueId: id)
                        self.fetchLastEvents(leagueId: id)
                        self.teamsCollectionView.reloadData()
                    }

                    
                case .failure(let error):
                    print(error)
                    break
                }
    }
    }
    
    
    func feachUpComming(LeagueId id:String){
        URLs.upCommingURL = "https://www.thesportsdb.com/api/v1/json/1/eventsseason.php?id=\(id)&s=2020-2021"
        upCommingViewModel = UpcommingViewModel()
        upCommingViewModel.bindUpcommingViewModelToView = {
            self.onSuccessUpComming()
        }
        upCommingViewModel.bindViewModelErrorToView = {
            self.onFailUpComming()
        }
    }
    
    
    func onSuccessUpComming(){
        upcommingEventsArray = upCommingViewModel.UpcommingData.events!
        self.upcommingCollectionView.reloadData()
       }
       
    func onFailUpComming(){
        let alert = UIAlertController(title: "Error", message: upCommingViewModel.showError, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func getTeamPic(teamOneId:String,teamTwoId:String,teams:[Teams]) -> [String] {
            var teamspics=["",""]
            for item in teams{
                if teamOneId==item.idTeam {
                    teamspics[0]=item.strTeamBadge!
                }
                if teamTwoId==item.idTeam {
                    teamspics[1]=item.strTeamBadge!
                }
            }
            return teamspics
        }
}

extension LeagueEventsViewController{
    func featchCoreData(){
        arrayOfFafourite = [FavoriteModelCoreData]()
        var arrayfdNSManagedObject = [NSManagedObject]()
        let appDeleget = UIApplication.shared.delegate as! AppDelegate
        let cont = appDeleget.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteCoreData")
        do {
            arrayfdNSManagedObject = try! cont.fetch(fetchRequest)
            for i in arrayfdNSManagedObject {
                let fav = FavoriteModelCoreData(Title: i.value(forKey: "title") as! String, Image: i.value(forKey: "image") as! String, Youtube: i.value(forKey: "youtube") as! String, ID: i.value(forKey: "id") as! String)
                self.arrayOfFafourite.append(fav)
                print(arrayOfFafourite.count)
                if fav.id == self.id {
                    buttonImage.image = UIImage(named: "f")
                    self.flag = true
                }
            }
        }
    }
    
    
    
    func deleteFromCoreData(){
        arrayOfFafourite = [FavoriteModelCoreData]()
        var arrayfdNSManagedObject = [NSManagedObject]()
        let appDeleget = UIApplication.shared.delegate as! AppDelegate
        let cont = appDeleget.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteCoreData")
        do {
            arrayfdNSManagedObject = try! cont.fetch(fetchRequest)
            for i in arrayfdNSManagedObject {
                let fav = FavoriteModelCoreData(Title: i.value(forKey: "title") as! String, Image: i.value(forKey: "image") as! String, Youtube: i.value(forKey: "youtube") as! String, ID: i.value(forKey: "id") as! String)
                self.arrayOfFafourite.append(fav)
            }
            for i in 0...arrayOfFafourite.count{
                let favouriteModel = arrayOfFafourite[i]
                if favouriteModel.id == self.id {
                    cont.delete(arrayfdNSManagedObject[i])
                    arrayOfFafourite.remove(at: i)
                    self.buttonImage.image = UIImage(named: "ff")
                    self.flag = false
                    break
                }
            }
            try? cont.save()
        }

    }
}


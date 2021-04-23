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
    
    @IBAction func addToFavourite(_ sender: Any) {
//         let image = UIImage(named: "1")
//        let data = image!.pngData()!

        let image = (buttonImage.image?.pngData())! as Data
//        let data = image?.pngData()
       // let data = image?.jpegData(compressionQuality: 0.9)
       // let uiImage: UIImage = UIImage(data: imageData)
        //let data = image!.pngData()!

        //To load: let image = UIImage(data: data)
        let appDeleget = UIApplication.shared.delegate as! AppDelegate
        let cont = appDeleget.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavouriteCoreData", in: cont)
        let m = NSManagedObject(entity: entity!, insertInto: cont)
        let model = FavoriteModelCoreData(Title: "title", Image: image, Youtube: "youtube link", ID: 123)
        m.setValue(model.title , forKey: "title")
        m.setValue("model.image", forKey: "image")
        m.setValue(model.youtube, forKey: "youtube")
        m.setValue(model.id, forKey: "id")
        try? cont.save()
        
        
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
        let teamsPics = self.getTeamPic(teamOneId: lastEventsArray[indexPath.row].idHomeTeam!, teamTwoId: lastEventsArray[indexPath.row].idAwayTeam!, teams: teams)
        cell.imageView1.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imageView1.sd_setImage(with: URL(string: teamsPics[0]), placeholderImage: UIImage(named: "placeholder"))
        cell.view1.layer.cornerRadius = 20.0
        cell.imageViw2.sd_imageIndicator = SDWebImageActivityIndicator.gray

        cell.imageViw2.sd_setImage(with: URL(string: teamsPics[1]), placeholderImage: UIImage(named: "placeholder"))
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
                        self.lastEventsArray = lastevents.events!
                        self.lastEventsTableView.reloadData()
                    case .failure(let error):
                        print(error)
                        break
                    }
        }
    }
    
    
    func feachTeams(LeagueId id:String){
        //https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=4328
        let url = "https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=\(id)"
        AF.request(url)
            .validate()
            .responseDecodable(of: TeamsClassModel.self) { (response) in
                switch response.result {
                case .success( _):
                    guard let teamsResponse = response.value else { return }
                    self.teams = teamsResponse.teams!
                    self.feachUpComming(LeagueId: id)
                    self.fetchLastEvents(leagueId: id)
                    self.teamsCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                    break
                }
    }
    }
    
    
    func feachUpComming(LeagueId id:String){
        //https://www.thesportsdb.com/api/v1/json/1/eventsseason.php?id=4328&s=2020-2021
        let url = "https://www.thesportsdb.com/api/v1/json/1/eventsseason.php?id=\(id)&s=2020-2021"
        AF.request(url)
            .validate()
            .responseDecodable(of: UpCommingEventEntity.self) { (response) in
                switch response.result {
                case .success( _):
                    guard let teamsResponse = response.value else { return }
                    self.upcommingEventsArray = teamsResponse.events!
                    self.upcommingCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                    break
                }
    }
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
    
}


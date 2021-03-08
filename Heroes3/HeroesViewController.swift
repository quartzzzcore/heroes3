//
//  HeroesViewController.swift
//  Heroes
//
//  Created by Anggi Putra Gomis on 01/03/21.
//

import UIKit
import CoreData
import KFSwiftImageLoader


class HeroesViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var collectionView:UICollectionView!
    
    var container: NSPersistentContainer!
    var heroes = [Hero]()
    var dataToShow = [Hero]()
    let categories = ["All", "Carry", "Disabler", "Durable", "Escape", "Initiator", "Jungler", "Nuker", "Pusher", "Support"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupCoreData()
        
        title = "All"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let urlString = "https://api.opendota.com/api/herostats"
        self.loadJson(fromURLString: urlString) { (result) in
            switch result {
            case .success(let data):
                self.parse(jsonData: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHeroDetailView" {
            let nextScene = segue.destination as! HeroDetailVewController
            let cell = sender as! HeroCollectionViewCell
            let indexpath = self.collectionView.indexPath(for: cell)
            NSLog("selected hero: %@",String(indexpath!.row))
            nextScene.heroNumber = indexpath!.row
            nextScene.hero = dataToShow[indexpath!.row]
            nextScene.similarHero = getSimilarHeroes(attribute: nextScene.hero!.attribute)
        }
    }
    
    func setupCoreData() {
        container = NSPersistentContainer(name: "Heroes3")

        container.loadPersistentStores { storeDescription, error in
            // resolve conflict by using correct NSMergePolicy
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
    }
    
//    func getData() {
//        if let url = URL(string: "https://api.opendota.com/api/herostats") {
//           URLSession.shared.dataTask(with: url) { data, response, error in
//              if let data = data {
//                  do {
//                     let res = try JSONDecoder().decode(Hero.self, from: data)
//                     print(res.name)
//                  } catch let error {
//                     print(error)
//                  }
//               }
//           }.resume()
//        }
//    }
    
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    completion(.success(data))
                }
            }
            urlSession.resume()
        }
    }
    
    private func parse(jsonData: Data) {
        do {
            heroes = try JSONDecoder().decode([Hero].self, from: jsonData)
            dataToShow = heroes
            print("total heroes \(heroes.count)")
            print("===================================")
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch {
            print("decode error")
        }
    }
    
    func filter(role: String) {
        if role.lowercased() == "all" {
            dataToShow = heroes
        }
        else
        {
            let filterHeroes = heroes.filter({
                $0.roles.contains(Hero.Role(rawValue: role)!)
            })
            dataToShow = filterHeroes
        }
        self.collectionView.reloadData()
    }
    
    func getSimilarHeroes(attribute: String) -> ArraySlice<Hero>{
        let result = heroes.filter({
            $0.attribute.contains(attribute)
        })
        let sortedArray = result.sorted(by: { $0.maxAttack > $1.maxAttack})
        return sortedArray.prefix(3)
    }
}

// MARK: - UITableView
extension HeroesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryTableViewCell
        let title = categories[indexPath.row]
        cell.titleLabel.text = title
        return cell
    }
}

extension HeroesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        NSLog("selected category: %@", categories[indexPath.row])
        tableView .deselectRow(at: indexPath, animated: true)
        title = categories[indexPath.row]
        filter(role: title!)
    }
}

// MARK: - UICollectionView
extension HeroesViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        NSLog("selected hero: %@", String(indexPath.row))
//
////        performSegue(withIdentifier: "showHeroDetailView", sender: self)
//    }
}

extension HeroesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as! HeroCollectionViewCell
        cell.titleLabel.text = dataToShow[indexPath.row].name//String(indexPath.row)
    
//        let imgURL = "https://api.opendota.com/apps/dota2/images/heroes/antimage_full.png"
        let imgURL = "https://api.opendota.com\(dataToShow[indexPath.row].img)"
        cell.imgView.loadImage(urlString: imgURL)
        
        return cell
    }
}

extension HeroesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 128, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
}



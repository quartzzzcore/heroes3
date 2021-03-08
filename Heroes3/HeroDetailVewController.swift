//
//  HeroDetailVewController.swift
//  Heroes
//
//  Created by Anggi Putra Gomis on 01/03/21.
//

import UIKit
import KFSwiftImageLoader


class HeroDetailVewController: UIViewController {

    var heroNumber:Int = 0
    var hero:Hero?
    var similarHero:ArraySlice<Hero>!
    
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var hpLabel:UILabel!
    @IBOutlet weak var mpLabel:UILabel!
    @IBOutlet weak var attributeLabel:UILabel!
    @IBOutlet weak var attackLabel:UILabel!
    @IBOutlet weak var defLabel:UILabel!
    @IBOutlet weak var speedLabel:UILabel!
    @IBOutlet weak var roleTextView:UITextView!
    @IBOutlet weak var attackTypeImgView:UIImageView!
    @IBOutlet weak var heroImgView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NSLog("hero number %d",heroNumber)
        print("selected hero name \(String(describing: hero!.name))")
        print("role \(String(describing: hero!.roles))")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        nameLabel.text = hero!.name
        hpLabel.text = String(hero!.health)
        mpLabel.text = String(hero!.mana)
        attributeLabel.text = hero!.attribute
        attackLabel.text = String(hero!.maxAttack)
        defLabel.text = String(hero!.armor)
        speedLabel.text = String(hero!.speed)
        
        let stringRepresentation = hero?.roles
//        roleTextView.text = stringRepresentation
//        let rawRoles = (hero?.roles.map ({ $0.rawValue }).joined(separator: ",")
        let rawRoles = stringRepresentation?.compactMap({ $0.rawValue }).joined(separator: ", ")
        roleTextView.text = rawRoles
        if hero!.type.lowercased() == "melee" {
            attackTypeImgView.image = UIImage(named:"icon_melee")!
        }
        else
        {
            attackTypeImgView.image = UIImage(named:"icon_range")!
        }
        let imgURL = "https://api.opendota.com\(hero!.img)"
        heroImgView.loadImage(urlString: imgURL)
        
        collectionView.reloadData()
    }
}

// MARK: - UICollectionView
extension HeroDetailVewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        NSLog("selected hero: %@", String(indexPath.row))
//
//    }
}

extension HeroDetailVewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarHero!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as! HeroCollectionViewCell
        
//        let imgURL = "https://api.opendota.com/apps/dota2/images/heroes/antimage_full.png"
        let imgURL = "https://api.opendota.com\(similarHero![indexPath.row].img)"
        cell.imgView.loadImage(urlString: imgURL)
        
        return cell
    }
}

extension HeroDetailVewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 128, height: 120)
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

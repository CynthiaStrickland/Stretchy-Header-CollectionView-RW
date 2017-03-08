//
//  MasterViewController.swift
//  StretchyHeaderCollectionViewRW
//
//  Created by Cynthia Strickland on 3/8/17.
//  Copyright © 2017 Fenix Designz. All rights reserved.
//

import UIKit

let masterID = "MasterToDetail"
let characterID = "CharacterCell"
let headerID = "CharacterHeader"

class MasterViewController: UICollectionViewController {
  
  let charactersData = Characters.loadCharacters()
        
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController!.isToolbarHidden = true
    
    let width = collectionView!.bounds.width - 4.0
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: width, height: 62)
    layout.minimumLineSpacing = 2
    layout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == masterID {
      let detailViewController = segue.destination as! DetailViewController
      detailViewController.character = sender as? Characters
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController!.isNavigationBarHidden = true
  }
}


// MARK: UICollectionViewDataSource
extension MasterViewController {
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return charactersData.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: characterID, for: indexPath) as! CharactersCell
    
    let character = charactersData[indexPath.item]
    cell.characterImage.image = UIImage(named: character.name)
    cell.characterTitle.text = character.title
    cell.characterDescription.text = character.description
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! CollectionHeaderView
    return header
  }
}

// MARK: UICollectionViewDelegate
extension MasterViewController {
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let character = charactersData[indexPath.item]
    performSegue(withIdentifier: masterID, sender: character)
  }
}










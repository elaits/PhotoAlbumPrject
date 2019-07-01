//
//  ViewController.swift
//  UICollectionView
//
//  Created by user on 6/24/19.
//  Copyright © 2019 Razeware. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    
    var photos = [PhotoModel]()
    
        override func viewDidLoad() {
        super.viewDidLoad()
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        fetchPhotos()
    }
    
     func fetchPhotos() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }
            
            do {
                self.photos = try JSONDecoder().decode([PhotoModel].self, from: data)
                self.photos = self.photos.map(){
                    PhotoModel(albumId: $0.albumId, id: $0.id, title: $0.title, url: $0.url, thumbnailUrl: $0.thumbnailUrl)
                }
                DispatchQueue.main.async { [weak self] in
                    self?.photoCollectionView.reloadData()
                }
            } catch {
                print("error: ",error.localizedDescription)
            }
            }.resume()
    }
    
    func setImage (_ photo: PhotoModel) {
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell {
            itemCell.setPhotoCell(photos[indexPath.row])
            return itemCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myModalViewController = storyboard.instantiateViewController(withIdentifier: "modalVC")
        myModalViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        myModalViewController.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(myModalViewController, animated: true, completion: nil)
    }

    
//    if let url = URL(string: ) {
//        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
//            if let data = data {
//                DispatchQueue.main.async {
//                    imageView.image = UIImage(data: data)
//                }
//            }
//            }.resume()
//    }
    
    
}
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showVC" {
//            if let vc = segue.destination as? DetailViewController {
//                let menu = sender as? Menu
//                print( menu ?? "nil")
//                vc.menu = menu
//            }
//        }
//    }

/*
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? MenuCollectionViewCell {
            itemCell.menu = itemArray[indexPath.row]
            
            return itemCell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menu = itemArray[indexPath.row]
        self.performSegue(withIdentifier: "showVC", sender: menu)
    }
    
}
}
*/

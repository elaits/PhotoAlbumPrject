//
//  AlbumTableViewController.swift
//  NewProject
//
//  Created by user on 6/28/19.
//  Copyright © 2019 Razeware. All rights reserved.
//

import UIKit

class AlbumTableViewController: UITableViewController {

    var albums = [AlbumModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        fetchAlbums()
        
        
    }
    
    private func fetchAlbums() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/albums") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }
            
            do {
                self.albums = try JSONDecoder().decode([AlbumModel].self, from: data)
                self.albums = self.albums.sorted{$0.title < $1.title}
                self.albums = self.albums.map(){
                    AlbumModel(userId: $0.userId, id: $0.id, title: $0.title.prefix(1).uppercased() + $0.title.dropFirst())
                }
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            } catch {
                print("error: ",error.localizedDescription)
            }
            }.resume()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albums.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.className, for: indexPath) as? AlbumTableViewCell else { return UITableViewCell() }
        
        cell.setCell(albums[indexPath.row])
        // Configure the cell...
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "enterToAlbum" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let dvc = segue.destination as! PhotoListViewController
//
//            }
//        }
//    }

}

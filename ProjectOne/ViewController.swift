//
//  ViewController.swift
//  ProjectOne
//
//  Created by Luiz R on 27/12/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Some necessarily fix to iOS 15ˆ to make the navigationBar White
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        if pictures.count > 0 {
            pictures.sort(by: {prev, pos in
                let prevImage = prev
                    .components(separatedBy:CharacterSet.decimalDigits.inverted)
                    .joined()
                let posImage = pos
                    .components(separatedBy:CharacterSet.decimalDigits.inverted)
                    .joined()
                return prevImage < posImage
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailViewController.selectedImage = pictures[indexPath.row]
            detailViewController.currentImagePosition = indexPath.row + 1
            detailViewController.totalImages = pictures.count
            
            
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}


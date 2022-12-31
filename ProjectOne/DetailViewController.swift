//
//  DetailViewController.swift
//  ProjectOne
//
//  Created by Luiz R on 28/12/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var currentImagePosition: Int?
    var totalImages: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedImage
        
        if let imagePosition = currentImagePosition {
            if let allImagesCount = totalImages {
                title = "Picture \(imagePosition) of \(allImagesCount)"
            }
        }
                        
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = false
    }

}

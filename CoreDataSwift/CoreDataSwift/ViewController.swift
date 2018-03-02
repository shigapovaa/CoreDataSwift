//
//  ViewController.swift
//  CoreDataSwift
//
//  Created by Alsu Shigapova on 01.03.2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var textOfLabelCell = ""
    var imageOfImageCell = UIImage(named: "")
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelCell.text = textOfLabelCell
        imageCell.image = imageOfImageCell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


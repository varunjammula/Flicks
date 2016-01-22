//
//  DetailsViewController.swift
//  Flicks
//
//  Created by Varun Chandra Jammula on 1/21/16.
//  Copyright © 2016 Varun Chandra Jammula. All rights reserved.
//

import UIKit
import AFNetworking

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var overView: UILabel!
    var overViewtext : String!
    var imageUrl : NSURL!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overView.text = overViewtext
        backgroundImage.setImageWithURL(imageUrl);
        backgroundImage.alpha = 0.1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

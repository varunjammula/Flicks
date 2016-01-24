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
    
    @IBOutlet weak var ratingsLabel: UILabel!

    @IBOutlet weak var popularityLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var overView: UILabel!
    
    var overViewtext : String?
    var imageUrl : String?
    var posterUrl : NSURL?
    var popularity : Double?
    var ratings : Double?
    var selectedMovie : NSDictionary!
    var posterBaseUrl = "http://image.tmdb.org/t/p/w500"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overView.text = selectedMovie["overview"] as? String
        imageUrl = selectedMovie["backdrop_path"] as? String
        if(imageUrl == nil) {
            backgroundImage.setImageWithURL(NSURL(string: posterBaseUrl + (selectedMovie["poster_path"] as? String)!)!)
        } else {
            backgroundImage.setImageWithURL(NSURL(string: posterBaseUrl + imageUrl!)!)
        }
        ratings = selectedMovie["vote_average"]! as? Double
        popularity = selectedMovie["popularity"]! as? Double
        ratingsLabel.text = " " + String(format: "%.2f", ratings!) + " / 10.0"
        popularityLabel.text = " " + String(format: "%.2f", popularity!) + " % "
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

//
//  MoviesViewController.swift
//  Flicks
//
//  Created by Varun Chandra Jammula on 1/19/16.
//  Copyright © 2016 Varun Chandra Jammula. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var movies : [NSDictionary]?
    var selectedmovie : NSDictionary?
    let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(Reachability.isConnectedToNetwork()) {
            self.fetchData()
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
            collectionView.insertSubview(refreshControl, atIndex: 0)
            collectionView.dataSource = self
            collectionView.delegate = self
            
        } else {
            self.view.hidden = true
        }
        
    }

    func refreshControlAction(refreshControl: UIRefreshControl) {
        print("Refreshing data....")
        self.fetchData()
        refreshControl.endRefreshing()
    }
    
    func fetchData() {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            MBProgressHUD.hideHUDForView(self.view, animated: true)
                            self.collectionView.reloadData()
                    }
                }
        });
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if let movies = movies {
                return movies.count
            } else {
                return 0;
            }
        }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("com.vjammula.MovieCollection", forIndexPath: indexPath) as! MovieCellCollection
        let movie = movies![indexPath.row]
        if let posterPath = movie["poster_path"] as? String {
            let posterUrl = NSURL(string: posterBaseUrl + posterPath)
            cell.imageView.setImageWithURL(posterUrl!)
        }
        else {
            // No poster image. Can either set to nil (no image) or a default movie poster image
            // that you include as an asset
            cell.imageView.image = nil
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "detailsSegue" {
            let controller = segue.destinationViewController as! DetailsViewController;
            controller.title = selectedmovie!["title"] as? String
            controller.overViewtext = selectedmovie!["overview"] as? String
            controller.imageUrl = NSURL(string: posterBaseUrl + (selectedmovie!["poster_path"] as? String)!)
        }
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print (indexPath.row)
        selectedmovie = movies![indexPath.row];
        self.performSegueWithIdentifier("detailsSegue", sender: self)
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
    }
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailsSegue", let destination = segue.destinationViewController as? DetailsViewController {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPathForCell(cell) {
                destination.title = (movies![indexPath.row])["title"] as? String
            }
        }
    }*/
    
}


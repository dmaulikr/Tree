//
//  TableViewController.swift
//  Tree
//
//  Created by Mark Meretzky on 1/15/15.
//  Copyright (c) 2015 Mark Meretzky. All rights reserved.
//

import UIKit;

class TableViewController: UITableViewController {
	let cellReuseIdentifier: String = "tree";
	let model: Model;
	let controllerIndexPath: NSIndexPath;

	//Called by app delegate.

	init(model: Model, indexPath: NSIndexPath) {
		self.model = model;
		//This view controller must have its own copy of the NSIndexPath.
		controllerIndexPath = indexPath.copy() as NSIndexPath;
		super.init(nibName: nil, bundle: nil);
		title = model.name(controllerIndexPath);
		if navigationItem.backBarButtonItem != nil {
			navigationItem.backBarButtonItem!.title = title;
		}
	}

	//not called
	required init(coder aDecoder: NSCoder) {
		model = Model();
		controllerIndexPath = NSIndexPath(index: 0);
		super.init(nibName: nil, bundle: nil);
	}

	override func viewDidLoad() {
		super.viewDidLoad();
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier);

		//Uncomment the following line to preserve selection between presentations
		clearsSelectionOnViewWillAppear = false;

		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		navigationItem.rightBarButtonItem = editButtonItem();
	}
    
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning();
		// Dispose of any resources that can be recreated.
	}

	// MARK: - Table view data source

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		// Return the number of sections.
		return 1;
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// Return the number of rows in the section.
		return model.count(controllerIndexPath);
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as UITableViewCell

		// Configure the cell...
		//ip is the indexPath of the subtree whose name is displayed in this cell.
		let ip: NSIndexPath = controllerIndexPath.indexPathByAddingIndex(indexPath.row);
		cell.textLabel!.text = model.name(ip);
		if model.count(ip) > 0 {
			cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator;
		} else {
			cell.accessoryType = UITableViewCellAccessoryType.None;
		}
		return cell;
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let cell: UITableViewCell? = tableView.cellForRowAtIndexPath(indexPath);
		if cell == nil {
			return;
		}
		//ip is the indexPath of the subtree whose name is displayed in this cell.
		let ip: NSIndexPath = controllerIndexPath.indexPathByAddingIndex(indexPath.row);
		if model.count(ip) > 0 {
			let tableViewController: TableViewController =
				TableViewController(model: model, indexPath: ip);
			navigationController!.pushViewController(tableViewController, animated: true);
		} else {
			//ip refers to a tree that is a leaf.  Display its Wikipedia article.
			let name: NSString = model.name(ip);
            println("\(name)")
            
         
			var string: NSString =
				name.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!;
			string = "http://en.m.wikipedia.org/wiki/".stringByAppendingString(string);
			let url: NSURL? = NSURL(string: string);
			let data: NSData? = NSData(contentsOfURL: url!);
			
			if data == nil {
				println("could not load URL \(url)");
			} else {
				let webView: UIWebView = UIWebView(frame: CGRectZero);
				webView.scalesPageToFit = true;
				webView.loadData(data,
					MIMEType: "text/html",
					textEncodingName: "NSUTF8StringEncoding",
					baseURL: url);
				
				//Give the web view a generic view controller.
				let viewController: UIViewController =
					UIViewController(nibName: nil, bundle: nil);
				viewController.title = name;
				viewController.view = webView;
				navigationController!.pushViewController(viewController, animated: true);
    
			}
		}
	}

	/*
	// Override to support conditional editing of the table view.
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true;
	}
	*/


	// Override to support editing the table view.
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
			// Delete the row from the data source
			tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade);
		} else if editingStyle == .Insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		}
	}
	
	/*
	// Override to support rearranging the table view.
	override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
	}
	*/

	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		// Return false if you do not want the item to be re-orderable.
		return true;
	}
	*/

	/*
	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		// Get the new view controller using [segue destinationViewController].
		// Pass the selected object to the new view controller.
	}
	*/

}

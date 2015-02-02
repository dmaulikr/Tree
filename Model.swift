//
//  Model.swift
//  Tree
//
//  Created by Mark Meretzky on 1/15/15.
//  Copyright (c) 2015 Mark Meretzky. All rights reserved.
//

import UIKit;

/*
The model consists of a big tree containing little trees.
The little trees have even smaller ones inside them.
At the very bottom are trees that contain no smaller trees.
We call them the "leaves".

An NSIndexPath identifies a tree.  For example,
0 represents the United States.
0.0 represents Connecticut.
0.1 represents New York.
0.2 represents New Jersey.
0.1.1 represents Putnam County.
0.1.1.2 represents Cold Spring.

Each tree is implemented as an array.  The first object in the array is a String
giving the name of the tree.  The remaining objects, if any, are the subtrees inside of
the tree.
*/

/*
//Here is the property I wanted to put into class Model.
//Error message was: Expression was too complex to be solved in reasonable time;
//consider breaking up the expression into distinct sub-expressions.

	let tree: [AnyObject] = ["Universe",
		["United States",
			["Connecticut",
				["Fairfield",
					["Cos Cob"
					]
				]
			],

			["New York",
				["Westchester",
					["Yonkers"
					],
					["Hastings"
					],
					["Dobbs Ferry"
					],
					["Irvington"
					],
					["Tarrytown"
					],
					["Ossining"
					],
					["Croton"
					],
					["Peekskill"
					]
				],
				["Putnam",
					["Manitou"
					],
					["Garrison"
					],
					["Cold Spring"
					]
				],
				["Dutchess",
					["Wappingers Falls"
					],
					["New Hamburg"
					],
					["Poughkeepsie"
					]
				],
				["Columbia"
				],
				["Rensselaer"
				]
			],

			["New Jersey",
				["Bergen",
					["Fort Lee"
					],
					["Alpine"
					]
				]
			]
		]
	];
*/

class Model: NSObject {
	let tree: [AnyObject]? = [AnyObject]();	//Create an empty array.

	override init() {
		let bundle: NSBundle = NSBundle.mainBundle()
		let filename: String? = bundle.pathForResource("tree", ofType: "json");
		if filename == nil {
			println("could not find file tree.json");
		} else {
			let data: NSData? = NSData(contentsOfFile: filename!);
			if data == nil {
				println("could not create data object");
			} else {
				var error: NSError?;
				tree = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &error) as [AnyObject]?;
				if tree == nil {
					println("could not create tree: \(error)");
				}
			}
		}
		super.init();
	}

	//Return the tree to which indexPath refers.

	func getTree(indexPath: NSIndexPath) -> [AnyObject] {
		var t: [AnyObject] = tree!;
		for var p = 0; p < indexPath.length; ++p {
			let i: Int = indexPath.indexAtPosition(p);
			t = t[i + 1] as [AnyObject];
		}
		
		return t;
	}

	//Return the name of the tree to which indexPath refers.

	func name(indexPath: NSIndexPath) -> String {
		let t: [AnyObject] = getTree(indexPath);
		return t[0] as String;
	}
	
	//Return the number of immediate subtrees of the tree to which indexPath refers.

	func count(indexPath: NSIndexPath) -> Int {
		let t: [AnyObject] = getTree(indexPath);
		return t.count - 1;
	}
}

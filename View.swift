//
//  View.swift
//  Meditate
//
//  Created by Feliks Leybovich on 1/2/15.
//  Copyright (c) 2015 Koursebook Inc. All rights reserved.
//

import UIKit
import GLKit;	//needed for GLKMathDegreesToRadians

class View: UIView {
    
    
    let label: UILabel = UILabel();
    let labelQuote: UITextView = UITextView();
    let imageView: UIImageView;
    
    required init(coder aDecoder: NSCoder) {
        self.imageView = UIImageView();
        super.init(coder: aDecoder);
        
        // Initialization code
        backgroundColor = UIColor.blackColor();
        
        labelQuote.autoresizingMask =
            UIViewAutoresizing.FlexibleLeftMargin
            | UIViewAutoresizing.FlexibleRightMargin
            | UIViewAutoresizing.FlexibleTopMargin
            | UIViewAutoresizing.FlexibleBottomMargin
            | UIViewAutoresizing.FlexibleWidth;
        
        
        
        /*
        slider.addTarget(self,
        action: "valueChanged:",
        forControlEvents: UIControlEvents.ValueChanged);
        */
        
        //Monospace font to keep the text stable as the numbers change.
        label.font = UIFont(name: "Chicago", size: 26);
        label.textAlignment = NSTextAlignment.Center;
        label.textColor = UIColor.whiteColor();
        
        var title: String = "Fate Knows Where You're Going, But It's Up To You To Get There";
        let titlefont: UIFont? = UIFont(name: "Papyrus", size: 30);
        
        //let titlesize: CGSize = title.sizeWithAttributes(titleattributes);
        
        labelQuote.font = titlefont;
        //labelQuote.textAlignment = NSTextAlignment;
        labelQuote.textColor = UIColor.yellowColor();
        labelQuote.text = title;
        labelQuote.backgroundColor = UIColor.blackColor()
        
        
        var image: UIImage? = UIImage(named: "imageLightOn.png");
        if image == nil {
            println("could not open assad.png");
            image = UIImage();	//Make a dummy image because the show must go on.
        }
        
        imageView = UIImageView(image: image!);
        imageView.alpha = 0
        
        //Fade in the green band.
        UIImageView.animateWithDuration(15,
            delay: 1,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                self.imageView.alpha = 1;
            },
            completion: nil);
        
        
        backgroundColor = UIColor.blackColor();
        
        
        let recognizer: UIRotationGestureRecognizer =
        UIRotationGestureRecognizer(target: self, action: "rotate:");
        
        addGestureRecognizer(recognizer);
        addSubview(imageView);
        //addSubview(slider);
        //addSubview(label);
        addSubview(labelQuote);
        //valueChanged(slider);	//write initial temperatures into the label
    }
    
    //Center the label below the slider, separated by a margin.
    
    
    
    
    override func layoutSubviews() {
        let m: CGFloat = min(bounds.size.width, bounds.size.height);
        let margin: CGFloat = m / 30;
        
        //label.frame = CGRectMake(
          //  );
        
        //labelQuote.frame = CGRectMake(
        //);
    
    }
    
    func valueChanged(slider: UISlider!) {
        //As the slider goes from the minimum to the maximum value,
        //red goes from 0 to 1.  Conversely, blue goes from 1 to 0.
        
        let red: CGFloat = CGFloat(slider.value - slider.minimumValue)
            / CGFloat(slider.maximumValue - slider.minimumValue);
        
        label.backgroundColor = UIColor(red: red, green: 0.0, blue: 1.0 - red, alpha: 1.0);
        imageView.alpha = red;
        
        //Each number is at least 5 characters wide, with one digit to right of decimal point.
        label.text = String(format: "\(slider.value)");
    }
    
    func rotate(recognizer: UIRotationGestureRecognizer) {
        //Convert CGFloat to Float, because GLKMathRadiansToDegrees demands a Float parameter.
        let radians: Float = Float(recognizer.rotation);
        let degrees: Float = GLKMathRadiansToDegrees(radians);
        println("recognizer.rotation = \(degrees)");	//positive is clockwise
        
        imageView.transform = CGAffineTransformMakeRotation(recognizer.rotation);
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}

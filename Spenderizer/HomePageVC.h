//
//  HomePageVC.h
//  Spenderizer
//
//  Created by Jackson Foley on 4/10/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <UIKIT/UIKIT.h>
#import "PNChart.h"

@interface HomePageVC : UIViewController

@property(weak, nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (retain, nonatomic) IBOutlet PNPieChart *pieChart;

@end

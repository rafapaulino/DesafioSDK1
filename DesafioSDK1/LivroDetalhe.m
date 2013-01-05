//
//  LivroDetalhe.m
//  DesafioSDK1
//
//  Created by Rafael Brigagão Paulino on 09/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "LivroDetalhe.h"

@interface LivroDetalhe ()

@end

@implementation LivroDetalhe

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

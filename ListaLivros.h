//
//  ListaLivros.h
//  DesafioSDK1
//
//  Created by Rafael Brigagão Paulino on 06/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListaLivros : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tabelaLivros;
@property (nonatomic, strong) NSMutableArray *arrLivros;

@end

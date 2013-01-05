//
//  MeuCarrinho.h
//  DesafioSDK1
//
//  Created by Rafael Brigagão Paulino on 06/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeuCarrinho : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tabelaItens;
@property (nonatomic, strong) NSMutableArray *arrItens;
@property (nonatomic, weak) IBOutlet UILabel *itensTotal;
@property (nonatomic, weak) IBOutlet UILabel *compraTotal;
@property (nonatomic, weak) IBOutlet UIButton *fecharCompra;



@end

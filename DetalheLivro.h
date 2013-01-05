//
//  DetalheLivro.h
//  DesafioSDK1
//
//  Created by Rafael Brigagão Paulino on 06/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetalheLivro : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *capa;
@property (nonatomic, weak) IBOutlet UILabel *titulo;
@property (nonatomic, weak) IBOutlet UILabel *autor;
@property (nonatomic, weak) IBOutlet UILabel *isbn;
@property (nonatomic, weak) IBOutlet UILabel *paginas;
@property (nonatomic, weak) IBOutlet UILabel *preco;
@property (nonatomic, weak) IBOutlet UILabel *ano;
@property (nonatomic, weak) IBOutlet UIButton *botaoAdicionar;
@property (nonatomic, strong) NSMutableDictionary *detalheLivro;


-(IBAction)adicionarClicado:(id)sender;

@end

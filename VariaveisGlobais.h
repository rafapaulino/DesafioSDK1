//
//  VariaveisGlobais.h
//  DesafioSDK1
//
//  Created by Rafael Brigagão Paulino on 06/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VariaveisGlobais : NSObject

//arquivo de livros escolhidos que foi salvo em disco
@property (nonatomic, strong) NSString *localCarrinho;
//arquivo com os dados do usuario que ira comprar o livro
@property (nonatomic, strong) NSString *localSessao;
//arquivo com os dados dos livros
@property (nonatomic, strong) NSString *localLivros;

+(VariaveisGlobais*)shared;
@end

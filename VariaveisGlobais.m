//
//  VariaveisGlobais.m
//  DesafioSDK1
//
//  Created by Rafael Brigagão Paulino on 06/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "VariaveisGlobais.h"

@implementation VariaveisGlobais

//metodo que permite que outras classes acessem uma instancia unica desta classe
static VariaveisGlobais *_shared = nil;

+(VariaveisGlobais*)shared
{
    //mesmo trabalhando com mais de uma thread, o objeto sera unico (Obj Singleton)
    @synchronized (self)
    {
        //se nao existe o objeto
        if (_shared == nil) {
            _shared = [[self alloc] init];
        }
    }
    //retorna a referenca da instancia
    return _shared;
}

@end

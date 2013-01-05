//
//  CompraConcluida.m
//  DesafioSDK1
//
//  Created by Rafael Brigagão Paulino on 11/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "CompraConcluida.h"
#import "VariaveisGlobais.h"

@interface CompraConcluida ()

@end

@implementation CompraConcluida


-(void)viewDidAppear:(BOOL)animated
{
    //carregando os dados do usuario
    NSFileManager *gerenciadorArquivos = [NSFileManager defaultManager];
    //Consultando qual o local do arquivo salvo em VariaveisGlobais
    NSString *meusDados = [[VariaveisGlobais shared] localSessao];
    
    if ([gerenciadorArquivos fileExistsAtPath:meusDados]) {
        //carregar o array com os dados desse arquivo
        NSMutableArray *listaDados = [[NSMutableArray alloc] initWithContentsOfFile:meusDados];
        //carrego os dados do usuario 
        _nome.text = [[listaDados objectAtIndex:0] objectForKey:@"nome"];
        _email.text = [[listaDados objectAtIndex:0] objectForKey:@"email"];
        _telefone.text = [[listaDados objectAtIndex:0] objectForKey:@"telefone"];
        _endereco.text = [[listaDados objectAtIndex:0] objectForKey:@"endereco"];
        _cep.text = [[listaDados objectAtIndex:0] objectForKey:@"cep"];
    }
    
    //carregando os dados da compra
    NSFileManager *gArquivos = [NSFileManager defaultManager];
    //Consultando qual o local do arquivo salvo em VariaveisGlobais
    NSString *caminhoArquivo = [[VariaveisGlobais shared] localCarrinho];
    
    if ([gArquivos fileExistsAtPath:caminhoArquivo]) {
        //carregar o array com os dados desse arquivo
        NSMutableArray *arrItens = [[NSMutableArray alloc] initWithContentsOfFile:caminhoArquivo];
        //somando os valores do carrinho
        int quantidade = 0;
        float valor = 0.0;
        //caso exista eu somente altero a quantidade deste livro
        for (int i = 0; i < arrItens.count; i++)
        {
            //somando a quantidade
            int qtde = [[[arrItens objectAtIndex:i] objectForKey:@"quantidade"] integerValue];
            quantidade = quantidade+qtde;
            
            //somando o valor total
            float val = [[[arrItens objectAtIndex:i] objectForKey:@"preco"] floatValue];
            valor = valor+val*qtde;
        }
        //colocando os valores nas labels
        _itensTotal.text = [NSString stringWithFormat:@"%d", quantidade];
        _compraTotal.text = [NSString stringWithFormat:@"%2.f", valor];
        
    }
    
    //altero o titulo do navigation
    [self.navigationItem setTitle:@"Compra concluída"];
}



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

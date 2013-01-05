//
//  MeusDados.m
//  DesafioSDK1
//
//  Created by Rafael Brigagão Paulino on 06/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "MeusDados.h"
#import "VariaveisGlobais.h"

@interface MeusDados ()

@end

@implementation MeusDados

//atualizando / adicionando os dados de contato
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _nome)
    {
        //proximo campo recebe o foco
        [_email becomeFirstResponder]; 
    }
    else if (textField == _email)
    {
        [_telefone becomeFirstResponder];
    }
    else if (textField == _telefone)
    {
        [_endereco becomeFirstResponder];  
    }
    else if (textField == _endereco)
    {
        [_cep becomeFirstResponder];
    }
    else
    {
        //verificando se os campos foram preenchidos
        if ([_nome.text isEqualToString:@""])
        {
            //Campo nome não pode ficar vazio, aviso o usuario
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Campo nome nao pode ser vazio" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil]; 
            [alerta show];
        }
        else if ([_email.text isEqualToString:@""])
        {
            //Campo email não pode ficar vazio, aviso o usuario
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Campo email nao pode ser vazio" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil];
            [alerta show];
        }
        else if ([_telefone.text isEqualToString:@""])
        {
            //Campo telefone não pode ficar vazio, aviso o usuario
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Campo telefone nao pode ser vazio" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil];
            [alerta show];
        }
        else if ([_endereco.text isEqualToString:@""])
        {
            //Campo endereco não pode ficar vazio, aviso o usuario
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Campo endereco nao pode ser vazio" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil];
            [alerta show];
        }
        else if ([_cep.text isEqualToString:@""])
        {
            //Campo cep não pode ficar vazio, aviso o usuario
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Campo cep nao pode ser vazio" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil];
            [alerta show];
        }
        //guardo as informacoes
        else
        {
            //Criar um novo dicionario
            NSMutableDictionary *atualizarDados = [[NSMutableDictionary alloc] init];
            //Salvar as informações dos campos de texto para cada chave deste dicionario
            [atualizarDados setObject:_nome.text forKey:@"nome"];
            [atualizarDados setObject:_email.text forKey:@"email"];
            [atualizarDados setObject:_telefone.text forKey:@"telefone"];
            [atualizarDados setObject:_endereco.text forKey:@"endereco"];
            [atualizarDados setObject:_cep.text forKey:@"cep"];
            
            //retira o foco do campo cep
            [_cep resignFirstResponder];
            
            //apago todos os dados do array
            [_listaDados removeAllObjects];
            //atualizo o array
            [_listaDados addObject:atualizarDados];
            
            //inserindo os dados do arquivo
            NSString *meusDados = [[VariaveisGlobais shared] localSessao];
            [_listaDados writeToFile:meusDados atomically:YES];
            
            //informo o usuario que os dados dele foram atualizados
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Parabéns" message:@"Os seus dados foram atualizados com sucesso!" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil];
           [alerta show];
        }  
    }
    return YES;
}

//metodo que é chamado toda vez que a tela aparecer para o usuário
-(void) viewDidAppear:(BOOL)animated
{
    //NSFileManager é responsável por verificar os arquivos na pasta da aplicação, abrir os mesmos e fechá-los na sequência
    NSFileManager *gerenciadorArquivos = [NSFileManager defaultManager];
    //Consultando qual o local do arquivo salvo em VariaveisGlobais
    NSString *meusDados = [[VariaveisGlobais shared] localSessao];
    
    if ([gerenciadorArquivos fileExistsAtPath:meusDados]) {
        
        //carregar o array com os dados desse arquivo
        _listaDados = [[NSMutableArray alloc] initWithContentsOfFile:meusDados];
        
        //carrego os dados do usuario no formulario
        _nome.text = [[_listaDados objectAtIndex:0] objectForKey:@"nome"];
        _email.text = [[_listaDados objectAtIndex:0] objectForKey:@"email"];
        _telefone.text = [[_listaDados objectAtIndex:0] objectForKey:@"telefone"];
        _endereco.text = [[_listaDados objectAtIndex:0] objectForKey:@"endereco"];
        _cep.text = [[_listaDados objectAtIndex:0] objectForKey:@"cep"];
        
    }
    else
    {
        //crio um array vazio
        _listaDados = [[NSMutableArray alloc] init];
        //gravo os dados vazios tb
        _nome.text = @"";
        _email.text = @"";
        _telefone.text = @"";
        _endereco.text = @"";
        _cep.text = @""; 
    }
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

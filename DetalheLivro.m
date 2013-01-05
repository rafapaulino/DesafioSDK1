//
//  DetalheLivro.m
//  DesafioSDK1
//
//  Created by Rafael Brigagão Paulino on 06/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "DetalheLivro.h"
#import "VariaveisGlobais.h"

@interface DetalheLivro ()

@end

@implementation DetalheLivro


//adicionando ao carrinho
-(IBAction)adicionarClicado:(id)sender
{
    //adicionando o livro ao carrinho
    NSMutableDictionary *itens = [[NSMutableDictionary alloc] init];
    
    //passo os dados dos detalhesdo livro para o carrinho
    itens = _detalheLivro;
    
    //primeiro eu preciso verificar se ja existe um livro no carrinho
    //lendo o conteudo do arquivo direto no formato de array
    NSString *caminhoCarrinho = [[VariaveisGlobais shared] localCarrinho];
    NSFileManager *gerenciadorArquivos = [NSFileManager defaultManager];
    //crio o ponteiro para o conteudo
    NSMutableArray *conteudo;
    //se o arquivo existir
    if ([gerenciadorArquivos fileExistsAtPath:caminhoCarrinho]) {
        conteudo = [[NSMutableArray alloc] initWithContentsOfFile:caminhoCarrinho];
        //caso exista mas o conteudo for nulo
        if (conteudo == nil) {
           conteudo = [[NSMutableArray alloc] init]; 
        }
    }
    else
    {
       conteudo = [[NSMutableArray alloc] init];
    }
    //variaveis de controle para ver se o livro existe no carrinho e o indice dele o array
    BOOL existe = NO;
    int indice = 0;
    
    //caso exista eu somente altero a quantidade deste livro
    for (int i = 0; i < conteudo.count; i++)
    {
        NSString *isbnA = [[conteudo objectAtIndex:i] objectForKey:@"isbn"];
        NSString *isbn = [_detalheLivro objectForKey:@"isbn"];
        
        if ([isbnA isEqualToString:isbn]) {
            //altero a variavel existe para sim
            existe = YES;
            indice = i;
        }
    }
    //se existir entao eu so mudo a quantidade dos livros
    if (existe == YES) {
        int quantidade = [[[conteudo objectAtIndex:indice] objectForKey:@"quantidade"] integerValue];
        quantidade = quantidade+1;
        [[conteudo objectAtIndex:indice] setObject:[NSNumber numberWithInt:quantidade] forKey:@"quantidade"];
        
    }
    //caso contrario eu insiro o livro normalmente
    else
    {
       [itens setObject:[NSNumber numberWithInt:1] forKey:@"quantidade"];
        //adicionando o livro ao array
        [conteudo addObject:itens];
    }
    
    //atualizando o conteudo do arquivo
    //inserindo o item no carrinho
    [conteudo writeToFile:caminhoCarrinho atomically:YES];
    
    //aviso que o livro foi adicionado com sucesso!
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Sucesso" message:@"O livro foi adicionado com sucesso!" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil];
    [alerta show];
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
    _titulo.text = [_detalheLivro objectForKey:@"titulo"];
    _autor.text = [_detalheLivro objectForKey:@"autor"];
    _isbn.text = [_detalheLivro objectForKey:@"isbn"];
    
    //total de paginas
    NSInteger paginas = [[_detalheLivro objectForKey:@"paginas"] integerValue];
    _paginas.text = [NSString stringWithFormat:@"%d", paginas];
    
    //ano
    NSInteger ano = [[_detalheLivro objectForKey:@"ano"] integerValue];
    _ano.text = [NSString stringWithFormat:@"%d", ano];
    
    //preco
    float preco = [[_detalheLivro objectForKey:@"preco"] floatValue];
    _preco.text = [NSString stringWithFormat:@"%02.f", preco];

    //nome da imagem
    NSString *nomeImagem = [_detalheLivro objectForKey:@"capa"];
    //criar a imagem
    UIImage *imagem = [UIImage imageNamed:nomeImagem];
    _capa.image = imagem;
    
    [self.navigationItem setTitle:@"Detalhes do livro"];
    
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

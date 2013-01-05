//
//  ListaLivros.m
//  DesafioSDK1
//
//  Created by Rafael Brigagão Paulino on 06/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "ListaLivros.h"
#import "VariaveisGlobais.h"
#import "DetalheLivro.h"

@interface ListaLivros ()

@end

@implementation ListaLivros

//criando o total de linhas na tabela
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrLivros.count;
}

//reclicagem de celulas
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *idCelula = @"minhaCelula";
    //Reciclagem
    UITableViewCell *celula = [_tabelaLivros dequeueReusableCellWithIdentifier:idCelula];
    
    //Houve reciclagem?
    if (celula == nil) {
        //Se não houve, crio uma celula
        celula = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idCelula];
    }
    
    //Configurar a celula
    NSDictionary *dadosLivros = [_arrLivros objectAtIndex:indexPath.row];
    celula.textLabel.text = [dadosLivros objectForKey:@"titulo"];
    
    return celula;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //transicao para uma tela de detalhes, passando o dicionaerio daquela posicaso do vetor parametro para a proxima tela
    
    //pegando qual historyboard sera chamado
    NSString *meuStoryBoard;
    
    //verificando qual aparelho e o usado no momento
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"] || [deviceType isEqualToString:@"iPhone Simulator"])
    {
        meuStoryBoard = @"MainStoryBoard_iPhone";
    }
    else if([deviceType isEqualToString:@"iPod touch"])
    {
        meuStoryBoard = @"MainStoryBoard_iPhone";
    }
    else
    {
        meuStoryBoard = @"MainStoryBoard_iPad";
    }
    //NSLog(@"aparelho %@",deviceType);
    
    //instanciar a proxima viewController a ser chamada
    DetalheLivro *telaDestino = [[UIStoryboard storyboardWithName:meuStoryBoard bundle:nil] instantiateViewControllerWithIdentifier:@"livroDetalhe"];
    
    //passar os dados pelo dicionario
    NSMutableDictionary *livroEscolhido = [_arrLivros objectAtIndex:indexPath.row];
    telaDestino.detalheLivro = livroEscolhido;
    
    //[self presentModalViewController:telaDestino animated:YES];
    [self.navigationController pushViewController:telaDestino animated:YES];
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
    
    //criando a lista de livros
    NSMutableArray *listaLivros = [[NSMutableArray alloc] init];
    
    //criando um dicionario vazio  para ser manipulado nas proximas linhas
    NSMutableDictionary *livros = [[NSMutableDictionary alloc] init];
    
    [livros setObject:@"8ps.gif" forKey:@"capa"];
    [livros setObject:@"8ps.pdf" forKey:@"pdf"];
    [livros setObject:@"Os 8 Ps do Marketing Digital" forKey:@"titulo"];
    [livros setObject:@"Conrado Adolpho" forKey:@"autor"];
    [livros setObject:@"978-85-7522-275-1" forKey:@"isbn"];
    [livros setObject:[NSNumber numberWithInt:904] forKey:@"paginas"];
    [livros setObject:[NSNumber numberWithInt:2011] forKey:@"ano"];
    [livros setObject:[NSNumber numberWithFloat:139.99] forKey:@"preco"];
    //adicionando os livros ao array
    [listaLivros addObject:livros];
    
    livros = [[NSMutableDictionary alloc] init];
    [livros setObject:@"sites_css_xhtml.gif" forKey:@"capa"];
    [livros setObject:@"css_xhtml.pdf" forKey:@"pdf"];
    [livros setObject:@"Construindo Sites com CSS e (X)HTML" forKey:@"titulo"];
    [livros setObject:@"Mauricio Samy Silva" forKey:@"autor"];
    [livros setObject:@"978-85-7522-139-6" forKey:@"isbn"];
    [livros setObject:[NSNumber numberWithInt:448] forKey:@"paginas"];
    [livros setObject:[NSNumber numberWithInt:2007] forKey:@"ano"];
    [livros setObject:[NSNumber numberWithFloat:75.50] forKey:@"preco"];
    //adicionando os livros ao array
    [listaLivros addObject:livros];
    
    livros = [[NSMutableDictionary alloc] init];
    [livros setObject:@"svg.gif" forKey:@"capa"];
    [livros setObject:@"svg.pdf" forKey:@"pdf"];
    [livros setObject:@"Fundamentos da SVG" forKey:@"titulo"];
    [livros setObject:@"Mauricio Samy Silva" forKey:@"autor"];
    [livros setObject:@"978-85-7522-321-5" forKey:@"isbn"];
    [livros setObject:[NSNumber numberWithInt:224] forKey:@"paginas"];
    [livros setObject:[NSNumber numberWithInt:2012] forKey:@"ano"];
    [livros setObject:[NSNumber numberWithFloat:53.00] forKey:@"preco"];
    //adicionando os livros ao array
    [listaLivros addObject:livros];
    
    livros = [[NSMutableDictionary alloc] init];
    [livros setObject:@"iphone.gif" forKey:@"capa"];
    [livros setObject:@"iphone.pdf" forKey:@"pdf"];
    [livros setObject:@"iPhone na Pratica" forKey:@"titulo"];
    [livros setObject:@"Fabio Perez Marzullo" forKey:@"autor"];
    [livros setObject:@"978-85-7522-297-3" forKey:@"isbn"];
    [livros setObject:[NSNumber numberWithInt:272] forKey:@"paginas"];
    [livros setObject:[NSNumber numberWithInt:2012] forKey:@"ano"];
    [livros setObject:[NSNumber numberWithFloat:59.20] forKey:@"preco"];
    //adicionando os livros ao array
    [listaLivros addObject:livros];
    
    livros = [[NSMutableDictionary alloc] init];
    [livros setObject:@"ajax.gif" forKey:@"capa"];
    [livros setObject:@"ajax.pdf" forKey:@"pdf"];
    [livros setObject:@"Ajax com jQuery" forKey:@"titulo"];
    [livros setObject:@"MaurÌcio Samy Silva" forKey:@"autor"];
    [livros setObject:@"978-85-7522-199-0" forKey:@"isbn"];
    [livros setObject:[NSNumber numberWithInt:328] forKey:@"paginas"];
    [livros setObject:[NSNumber numberWithInt:2009] forKey:@"ano"];
    [livros setObject:[NSNumber numberWithFloat:69.30] forKey:@"preco"];
    //adicionando os livros ao array
    [listaLivros addObject:livros];
    
    livros = [[NSMutableDictionary alloc] init];
    [livros setObject:@"jquery.gif" forKey:@"capa"];
    [livros setObject:@"jquery.pdf" forKey:@"pdf"];
    [livros setObject:@"jQuery a Biblioteca do Programador JavaScript" forKey:@"titulo"];
    [livros setObject:@"MaurÌcio Samy Silva" forKey:@"autor"];
    [livros setObject:@"978-85-7522-237-9" forKey:@"isbn"];
    [livros setObject:[NSNumber numberWithInt:544] forKey:@"paginas"];
    [livros setObject:[NSNumber numberWithInt:2010] forKey:@"ano"];
    [livros setObject:[NSNumber numberWithFloat:95.10] forKey:@"preco"];
    //adicionando os livros ao array
    [listaLivros addObject:livros];


    NSFileManager *gerenciadorArquivos = [NSFileManager defaultManager];
    //Consultando qual o local do arquivo salvo em VariaveisGlobais
    NSString *caminhoLivros = [[VariaveisGlobais shared] localLivros];
    
    //inserindo os dados no array
    [listaLivros writeToFile:caminhoLivros atomically:YES];
    
    if ([gerenciadorArquivos fileExistsAtPath:caminhoLivros])
    {
        //carregar o array com os dados desse arquivo
        _arrLivros = [[NSMutableArray alloc] initWithContentsOfFile:caminhoLivros];
    }
    else
    {
        //crio um array com os livros
        _arrLivros = listaLivros;
    }
    [self.navigationItem setTitle:@"Lista de livros"];
    
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

//
//  MeuCarrinho.m
//  DesafioSDK1
//
//  Created by Rafael Brigagão Paulino on 06/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "MeuCarrinho.h"
#import "VariaveisGlobais.h"

@interface MeuCarrinho ()
{
    //essas duas propiedades serao usadas apenas para deletar/atualizar o livro na linha da tabela
    //quando o metodo de deletar da tabela for chamado e este delegar a funcao de deletar ao alertview
    //de acordo com o botao clicado pelo usuario
    
    //informa a quantidade de livros na linha da tabela para o alertview
    int alertQuantidade;
    
    //informa o indexPathRow para o alertView
    int alertIndexPathRow;
    
    //informa o indexPath
    id alertIndexPath;
}

@end

@implementation MeuCarrinho


//titulo da secao da tabela
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *titulo = @"Itens no carrinho:";
    return titulo;
}

//criando o total de linhas na tabela
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrItens.count;
}

//reclicagem de celulas
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *idCelula = @"minhaCelula";
    //Reciclagem
    UITableViewCell *celula = [_tabelaItens dequeueReusableCellWithIdentifier:idCelula];
    
    //Houve reciclagem?
    if (celula == nil) {
        //Se não houve, crio uma celula
        celula = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idCelula];
    }
    
    //Configurar a celula
    //item do carrinho
    NSDictionary *dadosLivros = [_arrItens objectAtIndex:indexPath.row];
    //quantidade
    int qtde = [[[_arrItens objectAtIndex:indexPath.row] objectForKey:@"quantidade"] integerValue];
    //titulo
    NSString *titulo = [dadosLivros objectForKey:@"titulo"];
    //formatando a celula
    celula.textLabel.text = [NSString stringWithFormat:@"(%d) - %@", qtde,titulo];
    
    return celula;
}

//deletar arquivos (ao sobrescrever este metodo a tabela pode ser editada)
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //acao de deletar
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //verifico se a quantidade de livros adicionada nesta linha é maior que 1
        //quantidade
        int qtde = [[[_arrItens objectAtIndex:indexPath.row] objectForKey:@"quantidade"] integerValue];
        
        if (qtde > 1) {
            //atualizo os valores que serao usados nas funcoes do alertview
            alertQuantidade = qtde;
            alertIndexPathRow = indexPath.row;
            alertIndexPath = indexPath;
            
            //aviso que nessa linha nós temos mais de um livro
            //e as acoes que serao tomadas daqui p/frente sao passadas para o metodo do alert view
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atenção!" message:@"Nós temos mais de um livro para este item, o que você deseja fazer?" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Excluir todos os livros",@"Excluir apenas um livro", nil];
            [alerta show]; 
        }
        //deleto direto
        else
        {
            //deletando e alterando a tavela visualmente
            [self deleteTodosCom:indexPath.row e:indexPath];
            
            //atualizar o valor total da compra e quantidade de itens
            [self atualizarCompra];
            
            //aviso que o livro foi deletado com sucesso!
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"O item foi excluído" message:@"O livro foi excluído do carrinho com sucesso!" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil];
            [alerta show];
        }
    }
}

//alert view usado para deletar / atualizar os itens na tabela
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        //deletar todos
        case 1:
        {
            //deletando e alterando a tavela visualmente
            [self deleteTodosCom:alertIndexPathRow e:alertIndexPath];
 
            //atualizar o valor total da compra e quantidade de itens
            [self atualizarCompra];
            
            //aviso que o livro foi deletado com sucesso!
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"O item foi excluído" message:@"O livro foi excluído do carrinho com sucesso!" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil];
            [alerta show];
        }
        break;
        //atualizar os valores sem deletar o item da tabela
        case 2:
        {
            //atualizando a quantidade de itens
            alertQuantidade = alertQuantidade-1;
            [[_arrItens objectAtIndex: alertIndexPathRow] setObject:[NSNumber numberWithInt:alertQuantidade] forKey:@"quantidade"];
            
            //atualizar o arquivo em disco
            [_arrItens writeToFile:[[VariaveisGlobais shared] localCarrinho] atomically: YES];
            
            //atualizar o valor total da compra e quantidade de itens
            [self atualizarCompra];
            
            //atualizar a linha da tabela
            NSDictionary *dadosLivros = [_arrItens objectAtIndex:alertIndexPathRow];
            NSString *titulo = [dadosLivros objectForKey:@"titulo"];
            //formatando a celula
            UITableViewCell *celula = [_tabelaItens cellForRowAtIndexPath:alertIndexPath];
            celula.textLabel.text = [NSString stringWithFormat:@"(%d) - %@", alertQuantidade,titulo];
            
            //aviso que o livro foi deletado com sucesso!
            UIAlertView *alerta2 = [[UIAlertView alloc] initWithTitle:@"O item foi excluído" message:@"Foi retirada uma unidade do livro escolhido!" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil];
            [alerta2 show];
            break;
        }
    }
}

//metodo que deleta todos os livros e atualiza visualmente a tabela
-(void)deleteTodosCom:(int)indexPathRow e:(id)indexPath
{
    //deletar a linha do array dataSource
    [_arrItens removeObjectAtIndex:indexPathRow];
    
    //atualizar o arquivo em disco
    [_arrItens writeToFile:[[VariaveisGlobais shared] localCarrinho] atomically: YES];
    
    //atualizar visualmente a tabela
    NSArray *indiceLinhasDeletar = [NSArray arrayWithObject:indexPath];
    [_tabelaItens deleteRowsAtIndexPaths:indiceLinhasDeletar withRowAnimation:UITableViewRowAnimationFade];
}

//metodo que atualiza o valor total da compra e quantidade de itens
-(void)atualizarCompra
{
    //somando os valores do carrinho
    int quantidade = 0;
    float valor = 0.0;
    
    //caso exista eu somente altero a quantidade deste livro
    for (int i = 0; i < _arrItens.count; i++)
    {
        //somando a quantidade
        int qtde = [[[_arrItens objectAtIndex:i] objectForKey:@"quantidade"] integerValue];
        quantidade = quantidade+qtde;
        
        //somando o valor total
        float val = [[[_arrItens objectAtIndex:i] objectForKey:@"preco"] floatValue];
        valor = valor+val*qtde;
    }
    //colocando os valores nas labels
    _itensTotal.text = [NSString stringWithFormat:@"%d", quantidade];
    _compraTotal.text = [NSString stringWithFormat:@"%2.f", valor];
    
    //verificando se existe algum item para ser comprado
    if (quantidade == 0) {
        //desabilito o botao fechar compra
        [_fecharCompra setEnabled:FALSE];
        [_fecharCompra setAlpha:0.5];
    }
    else
    {
        //habilito o botao
        [_fecharCompra setEnabled:TRUE];
        [_fecharCompra setAlpha:1.0];
    }
    
}


//metodo que é chamado toda vez que a tela aparecer para o usuário
-(void) viewDidAppear:(BOOL)animated
{
    //NSFileManager é responsável por verificar os arquivos na pasta da aplicação, abrir os mesmos e fechá-los na sequência
    NSFileManager *gerenciadorArquivos = [NSFileManager defaultManager];
    
    //Consultando qual o local do arquivo salvo em VariaveisGlobais
    NSString *caminhoArquivo = [[VariaveisGlobais shared] localCarrinho];
    
    if ([gerenciadorArquivos fileExistsAtPath:caminhoArquivo])
    {
        //carregar o array com os dados desse arquivo
        _arrItens = [[NSMutableArray alloc] initWithContentsOfFile:caminhoArquivo];
    }
    else
    {
        //crio um array vazio
        _arrItens = [[NSMutableArray alloc] init];
    }
    //recarrega os dados na tabela
    [_tabelaItens reloadData];
    
    //atualizar o valor total da compra e quantidade de itens
    [self atualizarCompra];

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
    
    [self.navigationItem setTitle:@"Meu carrinho"];
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

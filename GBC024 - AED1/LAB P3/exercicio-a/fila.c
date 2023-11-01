#include "fila.h"
#include "pilha.h"

#include <stdio.h>
#include <stdlib.h>

typedef struct noF
{
    int valor;
    struct noF *prox;
} noF;

typedef struct fila
{
    noF *inicio;
    noF *fim;
    int quant;
} fila;

fila *criar_fila ( )
{
    fila *f = (fila *) malloc (sizeof(fila));
    f->quant = 0;
    f->inicio = NULL;
    f->fim = NULL;

    return f;
}

void limpar_fila (fila *f)
{
    if (f == NULL) return;

    while (fila_vazia(f) != 0)
        remover (f, NULL);

    free (f);
    f = NULL;
}

int inserir (fila *f, int i)
{
    if (f == NULL) return -2;

    noF *n = (noF *) malloc (sizeof(noF));
    n->valor = i;
    n->prox = NULL;

    if (fila_vazia(f) == 0)
        f->inicio = n;
    else f->fim->prox = n;

    f->fim = n;
    f->quant++;

    return 0;
}

int remover (fila *f, int *i)
{
    if (f == NULL) return -2;
    if (fila_vazia(f) == 0) return -1;

    noF *temp = f->inicio;
    f->inicio = temp->prox;

    free (temp);

    if (f->inicio == NULL)
        f->fim = NULL;

    f->quant--;

    return 0;
}

int tamanho_fila (fila *f)
{
    if (f == NULL) return -2;
    return f->quant;
}

int fila_vazia (fila *f)
{
    if (f == NULL) return -2;
    if (f->quant == 0) return 0;
    else return 1;
}

//fun��es extras
void mostrar_fila (fila *f)
{
    if (f != NULL)
    {
        printf ("\n[");
        noF *n = f->inicio;
        while (n != NULL)
        {
            printf (" %d ", n->valor);
            n = n->prox;
        }
        printf ("]\n");
    }
}

void inverte_fila (fila *f)
{
    if (f == NULL) return;

    pilha *p = criar_pilha ( );
    if (p == NULL) return;

    int num, retorno;

    while (fila_vazia(f) != 0)
    {
        remover (f, &num);
        retorno = push (p, num);
    }

    while (pilha_vazia(p) != 0)
    {
        retorno = pop (p, &num);
        inserir (f, num);
    }

    mostrar_fila (f);
    limpar_pilha (p);
}

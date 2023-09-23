#include <stdio.h>

int main() 
{
    char sequencia[] = "731671765313306249192251196744265747423553491949349698352031277450632623957831801698480186947885184385861560789112949495459501737958331952853208805511125406987471585238630507156932909632952274430435576689664895044524452316173185640309871112172238311362229893423380308135336276614282806444486645238749303589072962904915604407723907138105158593079608667017242712188399879790879227492190169972088893776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215397536978179778461740649551492908625693219784686224828397224137565705605749026140797296865241453510047482166370484403199890008895243450658541227588666881164271714799244429282308634656748139191231628245861786645835912456652947654568284891288314260769004224219022671055626321111109370544217506941658960408071984038509624554443629812309878799272442849091888458015616609791913387549920052406368991256071760605886116467109405077541002256983155200055935729725716362695618826704282524836008232575304";
    int i, j, k;
    long long int maior = 0, produto;

    for (i = 0; i < 996; i++) 
    {
        produto = 1;
        for (j = i; j < i + 5; j++) 
        {
            k = sequencia[j] - '0';
            produto *= k;
        }
        if (produto > maior) 
        {
            maior = produto;
        }
    }

    printf("o maior produto de cinco digitos eh %lld", maior);

    return 0;
}
$ErrorActionPreference = "Stop"

#Define um hashtable, uma estrutura de dados para mapear chaves exclusivas para valores
$nameExpr = @{
	Label="Feito";
	Expression = {(del $_.Name)}
}

echo "Caso não queira especificar a data, hora ou extensao de arquivo digite (*)"

#Definir a data e hora
echo "Digite a data no formato MM/DD/AAAA com as '/'"
$dia = Read-Host 
echo "A data esta correta $dia ? S ou N:"
$opcao = Read-Host

echo "Digite a hora no formato HH:DD"
$hora = Read-Host 
echo "A hora esta correta $hora ? S ou N:"
$horario = Read-Host

#Confere se a data  e hora estao corretas
if ($opcao -eq "S" -and $horario -eq "s") {

# Definir o diretorio e tipo de arquivo
$diretorio = Read-Host "Diretorio desejado"
$tipo = Read-Host "Se for uma pasta digite P		Se for um arquivo digite A"


#Para arquivos
if($tipo -eq "A" -or $tipo -eq "a"){

#Definir a extensao do arquivo
$extensao = Read-Host "Extensao do arquivo"
#Filtra para ser apenas a extensao desejada
Get-childItem $diretorio -Filter "*$extensao" -Recurse |
#Proucra pela data e hora
Where-Object LastWriteTime -like "$dia *$hora*" |
#Exclui os objetos
Select-Object $nameExpr
echo "FEITO."
} 

#Para Diretorios
if($tipo -eq "P" -or $tipo -eq "p"){

#A diferenaca deste para o de arquivos e que ele passa por duas pesquisa de criterios um para dia e hora e outra para ver se ele é um diretorio
Get-childItem $diretorio -Recurse |
Where-Object LastWriteTime -like "$dia *$hora*" |
Select-Object Name ,mode|
Where-Object Mode -like "d-*"|
Select-Object $nameExpr
echo "FEITO."
}
} 


else {
echo "Script cancelado."
exit
}

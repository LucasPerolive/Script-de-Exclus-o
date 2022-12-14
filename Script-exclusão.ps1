$nameExpr = @{
	Label="Feito";
	Expression = {(del $_.Name)}
}

echo "Caso não queira especificar a data, hora ou extensao de arquivo digite (*)"

echo "Digite a data no formato MM/DD/AAAA com as '/'"
$dia = Read-Host 
echo "A data esta correta $dia ? S ou N:"
$opcao = Read-Host

echo "Digite a hora no formato HH:DD"
$hora = Read-Host 
echo "A hora esta correta $hora ? S ou N:"
$horario = Read-Host


if ($opcao -eq "S" -or $opcao -eq "s") {


$diretorio = Read-Host "Diretorio desejado"
$tipo = Read-Host "Se for uma pasta digite P		Se for um arquivo digite A"

if($tipo -eq "A" -or $tipo -eq "a"){

$extensao = Read-Host "Extensao do arquivo"
Get-childItem $diretorio -Filter "*$extensao" -Recurse |
Where-Object LastWriteTime -like "$dia *$hora*" |
Select-Object $nameExpr
echo "FEITO."
} 


if($tipo -eq "P" -or $tipo -eq "p"){

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
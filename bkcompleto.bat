@echo off
cls

REM Define o usuário e senha do banco de dados
set dbUser=root
set dbPassword=

REM Define a pasta que será feito o backup no padrão ...\<dia do mês>\<hora atual>
set backupDir=C:\temp\mysql

set yy=%DATE:~6,4%
set mon=%DATE:~3,2%
set dd=%DATE:~0,2%

REM Nome do arquivo que será gerado
set file=backup.sql

REM Caminho dos executáveis do mysqldump.exe, para executar o dump, e do 7z.exe, para compactar o arquivo
set mysqldump="c:\xampp\mysql\bin\mysqldump.exe"
set zip="C:\Program Files\7-Zip\7z.exe"

REM Cria a pasta de backup caso não exista
if not exist "%backupDir%" (
    mkdir "%backupDir%"
)

REM Executa o dump, aqui precisa configurar o host e o nome do banco de dados (locais com xxx)
%mysqldump% --host="localhost" --user=%dbUser% --password=%dbPassword% portaria > "%backupDir%\%file%-%dd%_%mon%_%yy%"

REM Compacta o arquivo com o dump
%zip% a -tgzip "%backupDir%\%file%-%dd%_%mon%_%yy%.gz" "%backupDir%\%file%-%dd%_%mon%_%yy%"

REM Exclui o arquivo .sql original
del "%backupDir%\%file%-%dd%_%mon%_%yy%"
No caso, ele cria uma pasta para o dia do mês, faz o dump e compacta o arquivo.


--1) Fazer em SQL Server os seguintes algoritmos:
--a) Fazer um algoritmo que leia 1 número e mostre se são múltiplos de 2,3,5 ou nenhum deles
	
DECLARE @num INT;
SET @num = 1;
IF(@num%3=0)
BEGIN
	print('E multiplo de 3')
END

IF(@num%2=0)
BEGIN
	print('E multiplo de 2')
END

IF(@num%5=0)
BEGIN
	print('E multiplo de 5')
END

IF(@num%3!=0 AND @num%2!=0 AND @num%5!=0)
BEGIN
	print('Multiplo de nenhum deles')
END


--b) Fazer um algoritmo que leia 3 números e mostre o maior e o menor

DECLARE @num1 INT, @num2 INT, @num3 INT,@maior INT, @menor INT,@cta INT
SET @num1 = 1;
SET @num2 = 0;
SET @num3 = 3;

SET @maior = @num1
SET @menor =@num1

IF(@num1 = @num2 AND @num2 = @num3)
BEGIN
	print('São iguais')
END

if(@maior < @num2 AND @num2 > @num3)
BEGIN
	SET @maior = @num2;
END
ELSE IF(@maior < @num3)
BEGIN
	SET @maior = @num3;
END

if(@menor > @num2 AND @num2 < @num3)
BEGIN
	SET @menor = @num2;
END
ELSE IF(@menor > @num3)
BEGIN
	SET @menor = @num3;
END

print('Maior: '+CAST(@maior AS VARCHAR));
print('Menor: '+CAST(@menor AS VARCHAR));

--c) Fazer um algoritmo que calcule os 15 primeiros termos da série
--1,1,2,3,5,8,13,21,...
--E calcule a soma dos 15 termos

declare @fin1 INT, @fin2 INT, @sum INT, @cont INT

set @fin1 = 1;
set @fin2 = 1;
set @cont = 0;
set @sum = 0;

while(@cont<15)
begin
	print(@fin1);
	set @sum = @sum + @fin1;
	set @fin1 = @fin1 + @fin2;
	set @cont = @cont+1;
	if(@cont<15)
	begin 
		print(@fin2)
		set @sum = @sum + @fin2;
		set @fin2 = @fin1 + @fin2;
		set @cont = @cont + 1;
	end
end

print('Soma: '+CAST(@sum AS VARCHAR));

--d) Fazer um algoritmo que separa uma frase, colocando todas as letras em maiúsculo e em
--minúsculo (Usar funções UPPER e LOWER)

declare @frase VARCHAR(50), @mai VARCHAR(50), @min VARCHAR(50)

set @frase = 'Ola Mundo';
set @mai = UPPER(@frase);
set @min = LOWER(@frase);

print('Maiusculo: '+@mai);
print('Minusculo: '+@min);

--e) Fazer um algoritmo que inverta uma palavra (Usar a função SUBSTRING)
DECLARE @input VARCHAR(40) = 'Corinthians';
DECLARE @length INT = LEN(@input);
DECLARE @reversed VARCHAR(40) = '';
DECLARE @i INT = 1;

WHILE @i <= @length
BEGIN
	SET @reversed = @reversed + SUBSTRING(@input, @length - @i + 1, 1);
	SET @i = @i + 1;
END

    print( @reversed);

/*
f) Considerando a tabela abaixo, gere uma massa de dados, com 100 registros, para fins de teste
com as regras estabelecidas (Não usar constraints na criação da tabela)
Computador
ID Marca QtdRAM TipoHD QtdHD FreqCPU
INT (PK) VARCHAR(40) INT VARCHAR(10) INT DECIMAL(7,2)

• ID incremental a iniciar de 10001
• Marca segue o padrão simples, Marca 1, Marca 2, Marca 3, etc.
• QtdRAM é um número aleatório* dentre os valores permitidos (2, 4, 8, 16)
• TipoHD segue o padrão:
o Se o ID dividido por 3 der resto 0, é HDD
o Se o ID dividido por 3 der resto 1, é SSD
o Se o ID dividido por 3 der resto 2, é M2 NVME
• QtdHD segue o padrão:
o Se o TipoHD for HDD, um valor aleatório* dentre os valores permitidos (500, 1000 ou 2000)
o Se o TipoHD for SSD, um valor aleatório* dentre os valores permitidos (128, 256, 512)
• FreqHD é um número aleatório* entre 1.70 e 3.20

* Função RAND() gera números aleatórios entre 0 e 0,9999...*/
CREATE DATABASE teste1;
CREATE TABLE computador(
	id			INT			NOT NULL,
	marca		VARCHAR(40)	NOT NULL,
	qtdRam		INT			NOT NULL,
	tipoHD		VARCHAR(10)	NOT NULL,
	qtdHD		INT			,
	freqCPU		DECIMAL(7,2)NOT NULL
	PRIMARY KEY (id)
);

DECLARE @id INT = 1000, @marca VARCHAR(40) = 'Marca ', @contador INT = 1, @tipohd VARCHAR(10), @qtdram INT, @qtdHD INT, @freqCPU DECIMAL(7,2), @ran INT;

WHILE (@id<1100)
BEGIN
	SET @id = @id + 1;
	SET @marca = @marca + CAST(@contador AS VARCHAR);
	
	IF(@id%3 = 0)
	BEGIN
		SET @tipohd = 'HDD';
		SET @ran = RAND()*3;
		SET @qtdHD = CASE CAST(FLOOR(@ran) AS INT)
			WHEN 0 THEN 500
			WHEN 1 THEN 1000
			WHEN 2 THEN 2000
		END;
	END
	IF(@id%3 = 1)
	BEGIN
		SET @tipohd = 'SSD';
		SET @ran = RAND()*3;
		SET @qtdHD = CASE CAST(FLOOR(@ran) AS INT)
			WHEN 0 THEN 128
			WHEN 1 THEN 256
			WHEN 2 THEN 512
		END;
	END
	IF(@id%3 = 2)
	BEGIN
		SET @tipohd = 'M2 NVME';
		SET @qtdHD = NULL;
	END

	SET @ran = RAND()*4;
	SET @qtdram = CASE CAST(FLOOR(@ran) AS INT)
		WHEN 0 THEN 2
		WHEN 1 THEN 4
		WHEN 2 THEN 8
		WHEN 3 THEN 16
	END;

	SET @freqCPU = RAND()*(3.20-1.70)+1.70;

	INSERT INTO computador VALUES(@id, @marca, @qtdram, @tipohd, @qtdHD, @freqCPU);
	SET @marca = 'Marca '
	SET @contador = @contador + 1;
END

SELECT * FROM computador
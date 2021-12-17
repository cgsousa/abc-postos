CREATE TABLE IF NOT EXISTS produto(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  descricao VARCHAR(50) ,
  unidade VARCHAR(3) ,    
  codigo_anp VARCHAR(10) ,
  id_produto INTEGER NULL,
  imposto NUMERIC(5,2) ,
  preco NUMERIC(12,3) ,  
  FOREIGN KEY(id_produto) REFERENCES produto(id) 
) ; 

insert into produto (descricao) values ('GASOLINA'); 
insert into produto (descricao) values ('OLEO DIESEL');

insert into produto (descricao,id_produto,unidade,codigo_anp,imposto,preco) 
  values ('GASOLINA COMUM',1,'LTS','320101001',13,6.57); 
insert into produto (descricao,id_produto,unidade,codigo_anp,imposto,preco) 
  values ('OLEO DIESEL PADRAO',2,'LTS','420301001',13,5.43);

  
CREATE TABLE IF NOT EXISTS tanque(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  descricao VARCHAR(25) ,
  capacidade NUMERIC(12,3),
  id_produto INTEGER NOT NULL,
  FOREIGN KEY(id_produto) REFERENCES produto(id)  
) ;

insert into tanque(descricao,capacidade,id_produto)
  values('T1',15000,3);
insert into tanque(descricao,capacidade,id_produto)
  values('T2',15000,4);


CREATE TABLE IF NOT EXISTS bomba(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  numero_serie VARCHAR(25) ,
  modelo VARCHAR(25) ,
  id_tanque INTEGER NOT NULL,
  FOREIGN KEY(id_tanque) REFERENCES tanque(id) 
) ;

insert into bomba(numero_serie,modelo,id_tanque) values('NS1','M1',1);
insert into bomba(numero_serie,modelo,id_tanque) values('NS2','M2',1);
insert into bomba(numero_serie,modelo,id_tanque) values('NS3','M3',2);
insert into bomba(numero_serie,modelo,id_tanque) values('NS4','M4',2);


CREATE TABLE IF NOT EXISTS bico(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  descricao VARCHAR(25) ,
  id_bomba INTEGER NOT NULL,
  FOREIGN KEY(id_bomba) REFERENCES bomba(id)  
) ;

insert into bico(descricao,id_bomba) values('B1',1);
insert into bico(descricao,id_bomba) values('B2',2);
insert into bico(descricao,id_bomba) values('B3',3);
insert into bico(descricao,id_bomba) values('B4',4);

--//
CREATE TABLE IF NOT EXISTS pedido(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  data INTEGER NOT NULL DEFAULT (date('now')),
  id_bico INTEGER NOT NULL ,
  descricao VARCHAR(50) ,
  quantidate NUMERIC(12,3) NOT NULL DEFAULT (0),  
  valor_unitario NUMERIC(12,3) NOT NULL DEFAULT (0),  
  valor_total NUMERIC(12,3) NOT NULL DEFAULT (0),  
  aliquota_imposto NUMERIC(5,2) NOT NULL DEFAULT (0),  
  valor_imposto NUMERIC(12,3) NOT NULL DEFAULT (0),  
  FOREIGN KEY(id_bico) REFERENCES bico(id)  
) ;

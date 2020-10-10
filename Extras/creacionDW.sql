/*Este script crea el datawarehouse a partir de la bd Intermedia*/

drop table if exists dataW.dimTiempo;
create table dataW.dimTiempo as
select
	(year(Precio.fecha)*10000 + month(Precio.fecha)*100 + day(Precio.fecha)) as idTiempo,
    year(Precio.fecha) as anio,
	(case 
		when quarter(fecha)=1 or quarter(fecha)=2 then '1er Semestre'
        when quarter(fecha)=3 or quarter(fecha)=4 then '2do Semestre'
	end) as semestre,
    (case 
		when quarter(fecha)=1 then '1er Trimestre'
		when quarter(fecha)=2 then '2do Trimestre'
        when quarter(fecha)=3 then '3er Trimestre'
        when quarter(fecha)=4 then '4to Trimestre'
	end) as trimestre,
    (case 
		when month(fecha)=1 then 'Enero'
        when month(fecha)=2 then 'Febrero'
        when month(fecha)=3 then 'Marzo'
        when month(fecha)=4 then 'Abril'
        when month(fecha)=5 then 'Mayo'
        when month(fecha)=6 then 'Junio'
        when month(fecha)=7 then 'Julio'
        when month(fecha)=8 then 'Agosto'
        when month(fecha)=9 then 'Septiembre'
        when month(fecha)=10 then 'Octubre'
        when month(fecha)=11 then 'Noviembre'
        when month(fecha)=12 then 'Diciembre'
	end) as mes
from 
	Precio
group by 
	Precio.fecha
order by
	idTiempo; 

ALTER TABLE `dataW`.`dimTiempo` 
CHANGE COLUMN `idTiempo` `idTiempo` BIGINT NOT NULL ,
ADD PRIMARY KEY (`idTiempo`);

/*Verificar esto si no funciona, ya que la columna nmes debe existir para ordenar los meses*/
ALTER TABLE `dataW`.`dimTiempo` add column 'nmes'
update TABLE `dataW`.`dimTiempo` set nmes = 1 where mes = 'Enero'
update TABLE `dataW`.`dimTiempo` set nmes = 2 where mes = 'Febrero'
update TABLE `dataW`.`dimTiempo` set nmes = 3 where mes = 'Marzo'
update TABLE `dataW`.`dimTiempo` set nmes = 4 where mes = 'Abril'
update TABLE `dataW`.`dimTiempo` set nmes = 5 where mes = 'Mayo'
update TABLE `dataW`.`dimTiempo` set nmes = 6 where mes = 'Junio'
update TABLE `dataW`.`dimTiempo` set nmes = 7 where mes = 'Julio'
update TABLE `dataW`.`dimTiempo` set nmes = 8 where mes = 'Agosto'
update TABLE `dataW`.`dimTiempo` set nmes = 9 where mes = 'Septiembre'
update TABLE `dataW`.`dimTiempo` set nmes = 10 where mes = 'Octubre'
update TABLE `dataW`.`dimTiempo` set nmes = 11 where mes = 'Noviembre'
update TABLE `dataW`.`dimTiempo` set nmes = 12 where mes = 'Diciembre'
/*---------------------------------------------------------------------------------------*/

-- --------------------------------------------------------
drop table if exists dataW.dimCombustible;
create table dataW.dimCombustible as 
select
	Combustible.idCombustible as idCombustible,
	Combustible.tipo as tipo
from 
	Combustible
order by
	Combustible.idCombustible,
	Combustible.tipo;
-- --------------------------------------------------------
drop table if exists dataW.dimBandera;
create table dataW.dimBandera as 
select
	Bandera.idBandera as idBandera,
	Bandera.bandera as bandera
from 
	Bandera
order by
	Bandera.idBandera,
	Bandera.bandera;
-- --------------------------------------------------------
drop table if exists dataW.dimUbicacion;
create table dataW.dimUbicacion as 
select
	Ubicacion.idUbicacion as idUbicacion,
	Ubicacion.provincia as provincia
from 
	Ubicacion
order by
	Ubicacion.idUbicacion,
	Ubicacion.provincia;
-- --------------------------------------------------------
drop table if exists dataW.Preciofact;
create table dataW.Preciofact as
select
	Combustible.idCombustible, Bandera.idBandera, Ubicacion.idUbicacion,
	(year(Precio.fecha)*10000 + month(Precio.fecha)*100 + day(Precio.fecha)) as idTiempo,
	Precio.precio_combustible,
    Precio.precio_dolar,
    truncate(Precio.precio_dolar - Precio.precio_combustible,2) as brecha_dolar_combustible
from Precio 
inner join Combustible on Precio.idCombustible = Combustible.idCombustible 
inner join Bandera on Precio.idBandera = Bandera.idBandera
inner join Ubicacion on Precio.idUbicacion = Ubicacion.idUbicacion 
group by
	Precio.fecha,
    Combustible.idCombustible,
    Bandera.idBandera,
    Ubicacion.idUbicacion,
    Precio.precio_combustible,
    Precio.precio_dolar
order by 
	idTiempo, 
    idCombustible,
    idBandera,
    idUbicacion;

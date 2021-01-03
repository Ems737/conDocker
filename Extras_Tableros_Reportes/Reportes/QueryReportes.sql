#Query para poder agrupar por menos columnas de las que estan en el select
#=========================================================================
SELECT @@sql_mode;
SET GLOBAL sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SET SESSION sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

#1er Reporte
#=============
select * 
#select c.tipo, u.provincia, round(avg(pf.precio_combustible),2) Precio_Comb
from Preciofact pf
inner join dimCombustible c on pf.idCombustible=c.idCombustible
inner join dimTiempo t on pf.idTiempo=t.idTiempo
inner join dimUbicacion u on pf.idUbicacion=u.idUbicacion
#where t.anio='2017' and t.semestre='1er Semestre'
group by t.nmes, u.provincia, c.tipo
order by t.nmes, c.tipo;

select distinct anio from dimTiempo;

#'1er Trimestre', 'Enero', '1', '23', 'TIERRA DEL FUEGO        '

#


select c.tipo, b.bandera, t.mes, round(avg(pf.precio_combustible),2) Precio_Comb
from Preciofact pf
inner join dimCombustible c on pf.idCombustible=c.idCombustible
inner join dimTiempo t on pf.idTiempo=t.idTiempo
inner join dimBandera b on pf.idBandera=b.idBandera
group by b.bandera, t.nmes, t.mes, c.tipo 
order by t.nmes, b.bandera, c.tipo;

select t.anio, t.mes, precio_dolar,round(avg(pf.precio_combustible),2)
from Preciofact pf
inner join dimTiempo t on pf.idTiempo=t.idTiempo
inner join dimCombustible c on pf.idCombustible=c.idCombustible
group by t.anio, t.nmes, c.tipo; 


SELECT distinct anio FROM dimTiempo;

#------------------------------------------------------------------------------------

#3er Reporte
#=============

select c.tipo, b.bandera, t.mes, round(avg(pf.precio_combustible),2) Precio_Comb
from Preciofact pf
inner join dimCombustible c on pf.idCombustible=c.idCombustible
inner join dimTiempo t on pf.idTiempo=t.idTiempo
inner join dimBandera b on pf.idBandera=b.idBandera
#where c.tipo=${Combustible} and b.bandera=${Bandera} and t.anio=${Anio}
group by b.bandera, t.nmes, c.tipo 
order by t.nmes, b.bandera, c.tipo;

#------------------------------------------------------------------------------------

#4to Reporte
#===========
select t.anio, t.nmes, t.mes, c.tipo, round(avg(pf.precio_combustible),2) Precio_Comb, round(avg(pf.precio_dolar),2) Precio_Dolar
from Preciofact pf
inner join dimCombustible c on pf.idCombustible=c.idCombustible
inner join dimTiempo t on pf.idTiempo=t.idTiempo
#where c.tipo=${Combustible}
where c.tipo='	Gas Oil Grado 2                 '
group by t.nmes, c.tipo, t.anio
order by t.anio, t.nmes, c.tipo;
#------------------------------------------------------------------------------------

#5to Reporte
#===========
select t.anio, t.mes, round(avg(pf.precio_combustible),2) PromComb, c.tipo, round(avg(pf.brecha_dolar_combustible),2) PromDifDolar_Comb
from Preciofact pf
inner join dimTiempo t on pf.idTiempo=t.idTiempo
inner join dimCombustible c on pf.idCombustible=c.idCombustible
#where c.tipo=${Combustible}
where c.tipo='	Gas Oil Grado 2                 '
group by t.anio, t.nmes, c.tipo;

#------------------------------------------------------------------------------------

SELECT distinct tipo FROM dimCombustible;
'	Gas Oil Grado 2                 '

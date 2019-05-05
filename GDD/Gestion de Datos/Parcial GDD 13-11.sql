use GD2015C1
select e.empl_nombre as nombreJefe,
Count(DISTINCT e2.empl_codigo) as cantidadEmpleadosACargo,
sum(f2.fact_total) as totalVendidoPorSusEmpleados,
count(f2.fact_tipo+f2.fact_sucursal+f2.fact_numero) as facturasRealizadasPorSusEmpleados,
(	select top 1 e1.empl_nombre
	from Empleado e1
	join Factura f1 on e1.empl_codigo=f1.fact_vendedor
	where e1.empl_jefe=e.empl_codigo and YEAR(f1.fact_fecha)=2012
	group by e1.empl_nombre
	order by sum(f1.fact_total) DESC
	) as empleadoConMejorVentas
from Empleado e
join Empleado e2 on e.empl_codigo= e2.empl_jefe
join Factura f2 on f2.fact_vendedor= e2.empl_codigo


where YEAR(f2.fact_fecha) = 2012 
group by e.empl_codigo, e.empl_nombre
having count(f2.fact_tipo+f2.fact_sucursal+f2.fact_numero) > 10
order by totalVendidoPorSusEmpleados DESC

--TEORIA
-- a) Falso
-- b)Verdadero
-- c) sirve para controlar el  acceso a la informacion
-- existen 4 tipos 
--Read Commited :  lee los cambios en disco, los que ya se hayan comiteado (tanto para insert como para update)
--Read Uncommited: lee los cambios aunque todavia no se hayan confirmado (dirty read), los lee de memoria
--Repeatable read: un select * de una tabla de dos transacciones que se realizan al 
--mismo tiempo devuelven el mismo resultado (lectura repetida)
--Serialized: cuando accede a una tabla la bloquea, para cualquier
-- otra transaccion que intente accederla, recien puede acceder a la tabla
-- cuando la transaccion que la retiene la libera

http://www.utnianos.com.ar/foro/tema-pedido-gestion-de-datos-final-04-12-2012

--1a) V
--1b) V

/*2a) 
	La VISTA es un objeto que se compone de campos de una o varias tablas, filtrados con WHERE o no. 
    Se puede insertar registros en caso de no tener join. 
	Sólo pueden borrarse registros si poseen columnas temporales.
	No se puede aplicar triggers. 
	Si se borra la tabla maestra u otra vista del que depende, éste da error al invocarlo.
	Se utiliza para:
	El acceso seguro a una lectura de una/varias tabla/s.
	Ocultar la complejidad de las consultas a los usuarios. Por ejemplo, JOIN de más de 5 tablas.	
*/  

/*2b)
	Un GRAFO es un concepto matemático que se interpreta de la realidad, entre el concepto computacional y 
	el usuario. Sea P un conjunto de nodos y E sus relaciones, entonces, G(P,E).
	Los tipos de grafos son:
	UNIDIRECCIONALES, existe un único camino entre par de nodos.
	BIDIRECCIONALES, existe más de un camino entre par de nodos.
	la REPRESENTACIÓN COMPUTACIONAL de los grafos son:
	Matriz de adyacencia, me indica si existe los caminos entre nodos	
*/

--3a)
CREATE TRIGGER tr_replicarCli
ON Clientes
AFTER INSERT
AS
BEGIN	
		INSERT INTO clientes_repl (cod_clie,nombre,apellido,cuit,cond_iva,direccion)
		SELECT c.cod_clie,c.nombre,c.apellido,c.cuit,c.cond_iva,c.direccion 
		FROM Clientes c INNER JOIN inserted i ON c.cod_clie=i.cod_clie
END

--3b)
SELECT C.nombre
FROM CLIENTES C LEFT JOIN FACTURAS F ON C.Id_cliente=F.f_cliente
WHERE C.Id_cliente EXISTS (select f2.f_cliente from facturas f2 where YEAR(f2.Fecha) between 2009 AND 2010)
GROUP BY C.Id_cliente,C.nombre
HAVING (select sum(Importe) from FACTURAS where f_cliente=C.f_cliente and year(Fecha)=2010 GROUP BY f_cliente,Fecha) 
       > 
	   (select sum(Importe) from FACTURAS where f_cliente=C.f_cliente and year(Fecha)=2009 GROUP BY f_cliente,Fecha)
ORDER BY C.nombre
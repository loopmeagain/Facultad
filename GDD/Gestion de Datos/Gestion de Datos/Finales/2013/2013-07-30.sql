--1a) V
--1b) F

/* 2a)
	  El DATA MINING es una minería de datos que se obtiene de BD no relaciones, y que se encuentran ocultas,
	  ya que se extrae con funciones especiales para la toma de decisión de la organización.
	  Se utiliza para obtener las tendencias, que nos muestra las estadísticas.
	  Una de las técnicas utilizadas es la extracción parcial por función.
*/
/* 2b)
	  

*/
-- USO SQL SERVER
--3a)
SELECT TOP 1 equipo_campeon 
FROM campeonato 
GROUP BY equipo_campeon
HAVING COUNT(equipo_campeon) = 1
ORDER BY anio DESC

--3B)
CREATE TRIGGER tr_validarAnioIngresado
ON campeonato
AFTER INSERT
AS
BEGIN
	DECLARE @anio int, @equipo varchar(50)
	DECLARE curValidarAnioIngresado CURSOR FOR
											   select equipo_campeon,anio from inserted 
	OPEN curValidarAnioIngresado
	FETCH NEXT curValidarAnioIngresado INTO @equipo,@anio
	WHILE (@@FETCH_STATUS=0)
	BEGIN
		IF(select anio from campeonato where anio <@anio and (@anio-anio)=1)
		BEGIN
			INSERT INTO campeonato(equipo_campeon,anio) VALUES (@equipo,@anio)
		END
		ELSE
		BEGIN
			RAISERROR('El anio ingresado no es mayor consecutivo ascendente',16,1)
			ROLLBACK
		END
		FETCH NEXT curValidarAnioIngresado INTO @equipo,@anio 
	END
	CLOSE curValidarAnioIngresado
	DEALLOCATE curValidarAnioIngresado
END
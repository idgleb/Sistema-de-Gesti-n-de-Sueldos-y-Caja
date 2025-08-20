-- Ejecutar consultas analíticas

-- Contar el numero de empleados
select count(*) as totol_empleados from empleado;

-- El nombre de cada empleado y el total de horas que trabajo
select e.nombre, coalesce(sum(timestampdiff(hour, t.fecha_hora_inicio, t.fecha_hora_cierra)),0) as total_horas_trabajadas
 from empleado e
 left join turno_trabajo t on e.id_empleado = t.empleado_id_empleado
 group by e.id_empleado;
 
-- Empleados que realizaron al menos una venta
select id_empleado, nombre from empleado 
where id_empleado IN (select empleado_id_empleado from venta); 

-- Empleados que tienen alguna multa
select nombre from empleado
where id_empleado 
in (select empleado_id_empleado from multa_premio where monto < 0 group by empleado_id_empleado);
 
-- valor promedio por venta
select avg(total_venta) as promedio_por_venta
from (select v.movimiento_id_movimiento, sum(dv.cantidad * dv.precio_unitario) as total_venta
	    from detalle_venta dv
		join 
		venta v on dv.venta_movimiento_id_movimiento = v.movimiento_id_movimiento
		group by v.movimiento_id_movimiento
	 )as ventas_totales;
     
-- encontramos el dia con maximo de ventas     
--  una consulta que primero obtenga el máximo de ventas diarias y luego recuperar el día correspondiente.
select día, total_ventas as ventas_maximo
from (
    select
        date(m.fecha_hora) as día,
        sum(dv.cantidad * dv.precio_unitario) as total_ventas
    from movimiento m
    join detalle_venta dv on dv.venta_movimiento_id_movimiento = m.id_movimiento
    group by date(m.fecha_hora)
) as ventas_por_dia
where total_ventas = (
    select max(total_ventas)
    from (
        select
            sum(dv.cantidad * dv.precio_unitario) as total_ventas
        from movimiento m
        join detalle_venta dv on dv.venta_movimiento_id_movimiento = m.id_movimiento
        group by date(m.fecha_hora)
    ) as sub
);
      
      
-- el producto con minimo precio
select nombre, min(precio) from servicio_prod;  

-- summa de horas trabajadas por dias y con nombre de empleado
SELECT date(t.fecha_hora_inicio) as dia, e.nombre, sum(TIMESTAMPDIFF(HOUR, t.fecha_hora_inicio, t.fecha_hora_cierra)) AS sum_horas_trabajadas
FROM empleado e
JOIN turno_trabajo t ON e.id_empleado = t.empleado_id_empleado
GROUP BY t.fecha_hora_inicio;

-- promedio horas trabajadas por cada empleado y cantidad de dias trabajadas   
with horas_por_dia_empleados as(
	SELECT date(t.fecha_hora_inicio) as dia, e.nombre, sum(TIMESTAMPDIFF(HOUR, t.fecha_hora_inicio, t.fecha_hora_cierra)) AS sum_horas_trabajadas
	FROM empleado e
	JOIN turno_trabajo t ON e.id_empleado = t.empleado_id_empleado
	GROUP BY t.fecha_hora_inicio)
select nombre, count(nombre) as dias_trabajadas, avg(sum_horas_trabajadas) as promedio_haras_por_dia from horas_por_dia_empleados
group by nombre


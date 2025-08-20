UPDATE empleado
SET telefono = '1166999999', rol_id_rol = 3
WHERE id_empleado = 1;

UPDATE empleado
SET telefono = '1133556677', rol_id_rol = 4
WHERE id_empleado = 2;

UPDATE sucursal
SET nombre = 'Sucursal Centro', telefono = '1166778899'
WHERE id_sucursal = 1;

UPDATE sucursal
SET nombre = 'Sucursal Sur', telefono = '1133445566'
WHERE id_sucursal = 2;

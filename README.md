# Sistema de Gestión de Sueldos y Caja

**Autor:** Ursol Gleb  
**Repositorio:** (añade aquí la URL de tu repo)

---

## Descripción

Esta solución integral permite gestionar de forma centralizada y analítica:

- El flujo de dinero en cada caja de todas las sucursales.
- Los turnos y horario de los empleados: aperturas, cierres, retrasos y cierres anticipados.
- El cálculo de sueldos y la generación de nóminas mensuales/anuales, incluyendo sueldo base, comisiones e incentivos.
- Penalizaciones automáticas por incumplimientos de horario.
- Definición y asignación de tarifas según experiencia (horas trabajadas) y de tarifas individuales.
- Configuración de porcentajes de venta generales y por producto/servicio, con fechas de vigencia.
- Todo tipo de movimientos financieros (depósitos, pagos a proveedores, retiros de sueldo anticipado).
- Ventas a clientes, detalle de productos/servicios y métodos de pago mixtos.
- Gestión documental de empleados (archivos, contratos).
- Historial de contratos y alertas de vencimiento.

---

## Funcionalidades clave

1. **Control de cajas por sucursal**  
   — Saldo en tiempo real de cada caja.  
2. **Cálculo y nóminas**  
   — Nómina automática (mes/año).  
3. **Gestión de turnos**  
   — Registro de aperturas y cierres, detección de retrasos.  
   — Multas o premios automáticos (`multa_premio`).  
4. **Tarifas por experiencia**  
   — Rangos de horas trabajadas (`tarifa_por_experiencia`).  
   — Asignación según fecha de alta (`fecha_tarifa_por_experiencia`).  
5. **Tarifas individuales** (`tarifa_individual`)  
6. **Comisiones y porcentajes de venta**  
   — Porcentaje general (`porcentaje_servisio`).  
   — Porcentaje por producto/servicio con vigencia (`fecha_porcentaje_servisio`).  
7. **Movimientos financieros diversos**  
   — Depósitos (`depositos`), gastos (`gasto`), retiros (`sacar_dinero`).  
8. **Ventas y clientes**  
   — Transacciones de venta (`venta`) y detalle (`detalle_venta`).  
9. **Métodos de pago mixtos** (`combo_metodos_pago`)  
10. **Módulo de clientes**  
11. **Gestión documental de empleados** (`archivo`, `contrato`)  
12. **Historial y renovación de contratos**  
13. **Incentivos y penalizaciones**  
14. **Control de horarios estándar y excepciones**  
    — Plantillas de horario (`orario`, `sucursal_orario`, `horario_turno`).

---

## Estructura de la base de datos

Todos los objetos (tablas, índices, claves foráneas) están definidos en el script:

```
BD2-final-Ursol.sql
```

Entre las tablas principales:

- **ciudad**, **direccion**  
- **sucursal**, **caja**  
- **empleado**, **rol**, **archivo**  
- **turno_trabajo**, **horario_turno**, **orario**, **sucursal_orario**  
- **nomina_sueldo**, **tarifa_por_experiencia**, **fecha_tarifa_por_experiencia**  
- **tarifa_individual**, **detalle_de_pago**, **metodo_de_pago**  
- **servicio_prod**, **porcentaje_servisio**, **fecha_porcentaje_servisio**  
- **venta**, **detalle_venta**, **cliente**  
- **movimiento**, **depositos**, **gasto**, **tipo_gasto**, **sacar_dinero**, **combo_metodos_pago**  
- **multa_premio**, **contrato**, **hora**, **dia**  

---

## Instrucciones de despliegue

1. Clona este repositorio:
   ```bash
   git clone <tu-repo-url>
   cd <tu-repo-folder>
   ```
2. En MySQL Workbench (o tu cliente SQL favorito), crea el esquema e importa:
   ```sql
   SOURCE BD2-final-Ursol.sql;
   ```
3. Ajusta las credenciales de conexión en tu aplicación o entorno.

---

## Consultas analíticas de ejemplo

- **Horas totales por empleado**  
  ```sql
  SELECT
    e.nombre,
    COALESCE(SUM(TIMESTAMPDIFF(HOUR, t.fecha_hora_inicio, t.fecha_hora_cierra)),0) AS total_horas
  FROM empleado e
  LEFT JOIN turno_trabajo t ON e.id_empleado = t.empleado_id_empleado
  GROUP BY e.id_empleado;
  ```

- **Promedio de importe por venta**  
  ```sql
  SELECT
    AVG(venta_total) AS promedio_por_venta
  FROM (
    SELECT
      dv.venta_movimiento_id_movimiento,
      SUM(dv.cantidad * dv.precio_unitario) AS venta_total
    FROM detalle_venta dv
    GROUP BY dv.venta_movimiento_id_movimiento
  ) sub;
  ```

- **Día con mayores ingresos**  
  ```sql
  SELECT
    DATE(m.fecha_hora) AS dia,
    SUM(dv.cantidad * dv.precio_unitario) AS ingresos
  FROM movimiento m
  JOIN venta v ON m.id_movimiento = v.movimiento_id_movimiento
  JOIN detalle_venta dv ON v.movimiento_id_movimiento = dv.venta_movimiento_id_movimiento
  GROUP BY DATE(m.fecha_hora)
  ORDER BY ingresos DESC
  LIMIT 1;
  ```

---

## Licencia

MIT

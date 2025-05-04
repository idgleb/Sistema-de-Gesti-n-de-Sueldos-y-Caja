# Sueldo

![Sueldo Logo](https://via.placeholder.com/150)

## Descripción

**Sueldo** es un sistema de gestión financiera y de nómina para empresas con múltiples sucursales y cajas. Permite controlar todos los movimientos de dinero, calcular sueldos basados en la experiencia y desempeño de los empleados, así como gestionar turnos, multas y premios.

---

## 📋 Funcionalidades principales

1. **Control de efectivo**

   * Registro de ingresos y egresos en cada caja de todas las sucursales.
   * Gastos a proveedores, pagos diversos y depósitos internos.

2. **Cálculo y generación de nómina**

   * Emisión de nómina mensual/anual para cada empleado.
   * Soporta pagos en distintos métodos (efectivo, tarjeta, transferencia) o combinados.

3. **Gestión de turnos y sanciones**

   * Control de apertura y cierre de turnos por empleado y caja.
   * Aplicación automática de multas por retrasos o cierres anticipados.

4. **Tarifas por experiencia**

   * Define rangos de horas trabajadas (`tarifa_por_experiencia`) y asigna tarifa por hora y porcentaje de ventas.
   * Registro histórico en `fecha_tarifa_por_experiencia` cada vez que un empleado supera un umbral.

5. **Tarifas individuales**

   * Configura tarifas y comisiones específicas por empleado con `tarifa_individual` y `fecha_tarifa_individual`.

6. **Incentivos por venta**

   * Porcentaje global de ventas y por producto/servicio (`porcentaje_servisio`, `fecha_porcentaje_servisio`).

7. **Histórico de configuraciones**

   * Todas las tarifas y porcentajes se activan con fecha de inicio y quedan registradas para auditoría.

8. **Movimientos y métodos de pago**

   * Clasificación de movimientos en ventas, gastos, retiros.
   * Uso de uno o varios métodos de pago por movimiento (`combo_metodos_pago`).

9. **Clientes y detalle de ventas**

   * Registro de clientes y ventas por movimiento, con detalle de productos/servicios (`detalle_venta`).

---

## 🗄️ Esquema de la base de datos

| Tabla                                                               | Descripción                      |
| ------------------------------------------------------------------- | -------------------------------- |
| `ciudad`, `direccion`                                               | Geolocalización de sucursales    |
| `rol`, `empleado`, `contrato`                                       | Datos de personal y contratos    |
| `sucursal`, `caja`                                                  | Estructura de puntos de venta    |
| `turno_trabajo`, `horario_turno`                                    | Control de turnos y horarios     |
| `nomina_sueldo`                                                     | Historial de nóminas             |
| `tarifa_por_experiencia`, `fecha_tarifa_por_experiencia`            | Tarifas según experiencia        |
| `tarifa_individual`, `fecha_tarifa_individual`                      | Tarifas específicas por empleado |
| `servicio_prod`, `porcentaje_servisio`, `fecha_porcentaje_servisio` | Productos y comisiones           |
| `multa_premio`                                                      | Multas y premios                 |
| `movimiento`, `tipo_gasto`, `gasto`, `depositos`                    | Movimientos de caja              |
| `detalle_de_pago`, `metodo_de_pago`                                 | Métodos y detalles de pago       |
| `cliente`, `venta`, `detalle_venta`                                 | Gestión de clientes y ventas     |
| `sacar_dinero`, `combo_metodos_pago`                                | Retiros y pagos combinados       |
| `hora`, `dia`, `orario`, `sucursal_orario`                          | Horarios de atención             |

---

## 🚀 Instalación

1. Clona el repositorio:

   ```bash
   git clone https://github.com/tu-usuario/sueldo.git
   ```
2. Importa el script SQL en MySQL:

   ```bash
   mysql -u root -p < BD2-final-Ursol.sql
   ```
3. Conecta tu aplicación cliente (p. ej. MySQL Workbench) usando las credenciales configuradas.

---

## 🔍 Ejemplos de consultas analíticas

### Total de horas trabajadas por empleado

```sql
SELECT
  e.nombre,
  COALESCE(SUM(
    TIMESTAMPDIFF(HOUR, t.fecha_hora_inicio, t.fecha_hora_cierra)
  ), 0) AS total_horas
FROM empleado e
LEFT JOIN turno_trabajo t
  ON e.id_empleado = t.empleado_id_empleado
GROUP BY e.id_empleado;
```

### Promedio de ingreso por venta

```sql
SELECT
  AVG(v.total) AS promedio_por_venta
FROM (
  SELECT
    dv.venta_movimiento_id_movimiento,
    SUM(dv.cantidad * dv.precio_unitario) AS total
  FROM detalle_venta dv
  GROUP BY dv.venta_movimiento_id_movimiento
) v;
```

### Día con más movimientos

```sql
SELECT
  DATE(m.fecha_hora) AS dia,
  COUNT(*) AS total_movimientos
FROM movimiento m
GROUP BY dia
ORDER BY total_movimientos DESC
LIMIT 1;
```

---

## 🤝 Contribuciones

¡Las mejoras son bienvenidas!

1. Haz un **fork**
2. Crea tu **branch** (`git checkout -b feature/nueva-funcionalidad`)
3. Realiza tus cambios y haz **commit**
4. Envía un **pull request**

---

## ⚖️ Licencia

Este proyecto está bajo la [MIT License](LICENSE).

---

## Análisis Funcional del Sistema de Gestión de Sueldos y Caja

Esta base de datos está diseñada para brindar una solución integral a la gestión de cajas, sueldos, turnos y movimientos financieros en múltiples sucursales. Las principales funcionalidades del sistema incluyen:

1. **Control de dinero en cajas**

   * Seguimiento en tiempo real del efectivo y saldos en cada caja de todas las sucursales.
   * Alertas de desbalances o caídas de efectivo.

2. **Cálculo de sueldos y generación de nóminas**

   * Nómina mensual/anual para cada empleado (`nomina_sueldo`).
   * Integración de sueldo base, comisiones, multas y ajustes.
   * Exportación de reportes de nómina en formatos CSV/Excel.

3. **Control de turnos de empleados**

   * Registro de aperturas y cierres de turno (`turno_trabajo`).
   * Detección de retrasos o cierres anticipados contra horarios planificados (`horario_turno`, `orario`, `sucursal_orario`).
   * Generación automática de multas por incumplimiento (`multa_premio`).

4. **Tarifas según experiencia**

   * Definición de rangos de experiencia basados en horas trabajadas (`tarifa_por_experiencia`).
   * Asignación automática de tarifas vigentes por fecha de alta (`fecha_tarifa_por_experiencia`).

5. **Tarifas individuales**

   * Configuración de tarifas personalizadas para cada empleado (`tarifa_individual`).

6. **Porcentajes de ventas y comisiones**

   * Porcentaje general de ventas por producto/servicio (`porcentaje_servisio`).
   * Fechas de vigencia para comisiones especiales (`fecha_porcentaje_servisio`).

7. **Movimientos financieros diversos**

   * Depósitos a caja y pagos a proveedores (`movimiento`, `depositos`, `gasto`).
   * Retiros de caja por empleado como anticipo o pago de sueldo (`sacar_dinero`).
   * Registro detallado por tipo de gasto (`tipo_gasto`).

8. **Registro de ventas y detalle de productos/servicios**

   * Transacciones de venta asociadas a cliente y empleado (`venta`).
   * Desglose de cada venta con cantidad y precio unitario (`detalle_venta`).

9. **Manejo de métodos de pago mixtos**

   * Combinación de efectivo, tarjeta y transferencia en una sola operación (`combo_metodos_pago`).

10. **Módulo de clientes y fidelización**

    * Almacenamiento de datos de clientes (`cliente`).
    * Histórico de compras y estadísticas de fidelidad.

11. **Gestión documental de empleados**

    * Asociación de archivos y documentos a cada empleado (`archivo`).
    * Control de caducidad, versiones y acceso seguro.

12. **Historial y renovación de contratos**

    * Registro detallado de contratos con fechas de inicio y fin (`contrato`).
    * Alertas automáticas de vencimiento y renovación.

13. **Cálculo de incentivos y penalizaciones**

    * Bonificaciones por horas extra o desempeño.
    * Multas automáticas por retrasos, inasistencias o incumplimientos.

14. **Control de horarios estándar y excepciones**

    * Definición de plantillas de turnos por día y hora.
    * Identificación de inasistencias o fracturas de horario.

15. **Informes y dashboards**

    * Paneles con métricas clave: total de ventas, horas trabajadas, costos de nómina.
    * Filtros por sucursal, periodo, empleado y tipo de movimiento.

16. **Seguridad y roles**

    * Gestión de accesos basada en roles (`rol`).
    * Permisos para operaciones (solo administradores pueden modificar tarifas).

17. **Integración y APIs**

    * Endpoints REST para integración con sistemas externos de contabilidad o recursos humanos.
    * Exportación de datos y webhooks para notificaciones en tiempo real.

18. **Auditoría y trazabilidad**

    * Registro de cambios en tablas sensibles (logs de usuarios).
    * Históricos de modificaciones para cumplimiento y auditoría interna.

Con este conjunto de funcionalidades, el sistema soporta desde la operación diaria de cajas hasta análisis avanzados de desempeño, finanzas y recursos humanos, convirtiéndose en una herramienta clave para la gestión y toma de decisiones de la empresa.

*Creado por Ursol Gleb.*

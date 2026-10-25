# Sistema de Cajero Automático (ATM) — Validaciones y menú de operaciones

Prototipo académico de un cajero automático en consola, desarrollado en C# como parte de la **Actividad 3.5 (Semana 3, Día 1)** del Programa FullStack .NET Cloud Developer, Módulo 1: Fundamentos con C#.

El sistema permite consultar el saldo, depositar y retirar dinero de una cuenta precargada en memoria, aplicando validaciones para impedir operaciones inválidas. Está basado en el documento de requerimientos **BRD-ATM-001**.

## Funcionalidades

| Opción | Operación | Validaciones |
|---|---|---|
| 1 | Consultar saldo | — |
| 2 | Depositar | Cuenta activa, monto numérico, monto mayor que cero |
| 3 | Retirar | Cuenta activa, monto numérico, monto mayor que cero, fondos suficientes |
| 4 | Salir | — |

Si se ingresa una opción inexistente o un valor no numérico, el sistema muestra un mensaje de error sin cerrarse de forma inesperada y sin modificar el saldo.

## Tecnologías

- C# / .NET 10
- Aplicación de consola
- Estructuras condicionales: `switch` para el menú, `if / else` para las reglas de negocio
- `int.TryParse` y `decimal.TryParse` para validar entradas

## Cómo ejecutar

Requisito: tener instalado el [.NET SDK 10](https://dotnet.microsoft.com/download).

```bash
git clone https://github.com/DHDanaurysHiraldo/CasoATM_ValidacionesYMenuDeOperaciones.git
cd CasoATM_ValidacionesYMenuDeOperaciones
dotnet run
```

## Datos de prueba

| Dato | Valor |
|---|---|
| Cliente | Samuel Reyes |
| Número de cuenta | 0458291046 |
| Saldo inicial | RD$10,000.00 |
| Estado de cuenta | Activa |

Para probar el comportamiento con una cuenta inactiva (CP-07), cambiar `estadoCuenta` a `false` en `Program.cs`.

## Reglas de negocio implementadas

| ID | Regla |
|---|---|
| RN-01 | La cuenta debe estar activa para depositar o retirar. |
| RN-02 | El monto de depósito debe ser mayor que cero. |
| RN-03 | El monto de retiro debe ser mayor que cero. |
| RN-04 | El retiro no puede superar el saldo disponible. |
| RN-05 | Un depósito autorizado incrementa el saldo. |
| RN-06 | Un retiro autorizado reduce el saldo. |
| RN-07 | Una operación rechazada no modifica el saldo. |
| RN-08 | Una opción no reconocida produce un mensaje de error. |

## Resultados de pruebas

| Prueba | Escenario | Resultado esperado | Estado |
|---|---|---|---|
| CP-01 | Consultar saldo | Muestra RD$10,000 | ⬜ |
| CP-02 | Depositar RD$2,000 | Saldo final RD$12,000 | ⬜ |
| CP-03 | Depositar RD$0 | Rechazo; saldo sin cambios | ⬜ |
| CP-04 | Retirar RD$3,000 | Saldo final RD$7,000 | ⬜ |
| CP-05 | Retirar RD$15,000 | Rechazo por fondos insuficientes | ⬜ |
| CP-06 | Retirar RD$-500 | Rechazo; saldo sin cambios | ⬜ |
| CP-07 | Cuenta inactiva; intentar retirar | Rechazo; saldo sin cambios | ⬜ |
| CP-08 | Seleccionar opción 9 | Opción inválida; saldo sin cambios | ⬜ |
| CP-09 | Ingresar letras donde se espera número | Mensaje de entrada inválida; sin cierre inesperado | ⬜ |
| CP-10 | Seleccionar opción 4 | El programa finaliza | ⬜ |
| CP-11* | Retirar el saldo exacto (RD$10,000) | Saldo final RD$0 | ⬜ |

\* Prueba adicional de valor límite para RN-04, no incluida en el BRD.

Las capturas de cada prueba están en [`docs/evidencias/`](docs/evidencias/). El detalle completo está en la [matriz de trazabilidad](docs/trazabilidad.md).

## Estructura del proyecto

```
CasoATM_ValidacionesYMenuDeOperaciones/
├── Program.cs
├── CasoATM_ValidacionesYMenuDeOperaciones.csproj
├── CasoATM_ValidacionesYMenuDeOperaciones.sln
├── README.md
└── docs/
    ├── SistemaATMv1.psc       # Pseudocódigo (PSeInt)
    ├── trazabilidad.md        # Matriz de trazabilidad
    └── evidencias/            # Capturas de las pruebas
```

## Alcance

**Incluye:** una cuenta precargada en memoria, menú de una sola ejecución, consulta de saldo, depósito, retiro, salida y validaciones de entrada.

**No incluye:** autenticación con PIN, múltiples cuentas, base de datos, persistencia entre ejecuciones, historial de transacciones ni repetición del menú. Esta última se incorporará en la siguiente iteración (Semana 3, Día 2) mediante ciclos.

## Observaciones y mejoras propuestas

- El BRD permite retirar el saldo completo (RN-04). En la banca real suelen existir saldos mínimos con cargos asociados y límites de retiro diario. Se recomienda evaluar estas reglas para una próxima iteración.
- El programa procesa una sola operación por ejecución, por lo que la prueba de cuenta inactiva requiere modificar el código manualmente.

## Autor

**DHDanaurysHiraldo** — [GitHub](https://github.com/DHDanaurysHiraldo)
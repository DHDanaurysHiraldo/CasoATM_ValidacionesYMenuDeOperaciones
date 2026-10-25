# Matriz de trazabilidad — Sistema ATM (BRD-ATM-001)

Este documento conecta cada necesidad del negocio con sus requerimientos, sus reglas, el código que las implementa y las pruebas que lo demuestran.

Archivo de referencia: [`Program.cs`](../Program.cs). Los números de línea corresponden a la versión entregada.

## 1. Trazabilidad completa (negocio → código → pruebas)

| Negocio | Funcional | Reglas | Implementación en código | Pruebas |
|---|---|---|---|---|
| RB-01 Conocer el saldo | RF-03 | — | `case 1` (L36–37) | CP-01 |
| RB-02 Bloquear operaciones con cuenta inactiva | RF-04, RF-05, RF-06 | RN-01, RN-07 | `if (estadoCuenta == false)` en `case 2` (L40) y `case 3` (L67) | CP-07 |
| RB-03 Rechazar montos no positivos | RF-04, RF-05, RF-07 | RN-02, RN-03, RN-07 | `else if (montoOperacion <= 0)` (L52, L80) | CP-03, CP-06 |
| RB-04 Impedir retiros mayores al saldo | RF-05, RF-07 | RN-04, RN-07 | `else if (montoOperacion > saldoDisponible)` (L84) | CP-05, CP-11 |
| RB-05 Resultado comprensible | RF-01, RF-02, RF-07, RF-08, RF-09 | RN-08 | Menú (L14–22), `switch` (L34), `int.TryParse` (L24), `> 4` (L28), `default` (L101), `case 4` (L97) | CP-08, CP-09, CP-10 |
| RB-06 El saldo solo cambia si se autoriza | RF-04, RF-05 | RN-05, RN-06, RN-07 | Suma en L58, resta en L90, ambas en la última rama `else` | CP-02, CP-04 |

## 2. Requerimientos funcionales → código

| ID | Requerimiento | Implementación | Líneas |
|---|---|---|---|
| RF-01 | Mostrar datos de la cuenta y menú de 4 opciones | Bloque de `Console.WriteLine` | L8–22 |
| RF-02 | Recibir la opción y dirigir a la operación | `int.TryParse` + `switch (opcionDeMenu)` | L24, L34 |
| RF-03 | Mostrar el saldo disponible | `case 1` | L36–37 |
| RF-04 | Procesar un depósito válido | `case 2` | L39–63 |
| RF-05 | Procesar un retiro válido | `case 3` | L66–95 |
| RF-06 | Verificar el estado de la cuenta antes de depósitos y retiros | `if (estadoCuenta == false)` | L40, L67 |
| RF-07 | Mensajes de confirmación o rechazo | `"DEPÓSITO EXITOSO"`, `"RETIRO EXITOSO"`, mensajes `"Operación Rechazada: ..."` | L59, L91, L42, L54, L69, L82, L86 |
| RF-08 | Informar opción inexistente o no numérica | `int.TryParse` (menú), `decimal.TryParse` (montos), `> 4`, `default` | L24, L48, L76, L28, L101 |
| RF-09 | Permitir Salir y finalizar | `case 4` | L97–99 |

## 3. Reglas de negocio → código

| Regla | Descripción | Implementación | Líneas |
|---|---|---|---|
| RN-01 | Cuenta activa para depositar o retirar | `if (estadoCuenta == false)` → rechazo | L40, L67 |
| RN-02 | Depósito mayor que cero | `else if (montoOperacion <= 0)` en `case 2` | L52 |
| RN-03 | Retiro mayor que cero | `else if (montoOperacion <= 0)` en `case 3` | L80 |
| RN-04 | Retiro no supera el saldo | `else if (montoOperacion > saldoDisponible)` | L84 |
| RN-05 | Depósito incrementa el saldo | `saldoDisponible = saldoDisponible + montoOperacion` | L58 |
| RN-06 | Retiro reduce el saldo | `saldoDisponible = saldoDisponible - montoOperacion` | L90 |
| RN-07 | Rechazo no modifica el saldo | El saldo solo se modifica en la rama final `else`; toda validación fallida corta antes | L58, L90 |
| RN-08 | Opción no reconocida produce error | `else if (opcionDeMenu > 4)` y `default` del `switch` | L28, L101 |

## 4. Pruebas ejecutadas

Precondición: saldo inicial RD$10,000.00 y cuenta activa, salvo que se indique lo contrario. Cada prueba es una ejecución independiente.

| Prueba | Escenario | Entrada | Resultado esperado | Línea que responde | Resultado obtenido | Estado | Evidencia |
|---|---|---|---|---|---|---|---|
| CP-01 | Consultar saldo | `1` | Muestra RD$10,000 | L37 | ⬜ | ⬜ | [CP-01](evidencias/CP-01.png) |
| CP-02 | Depositar RD$2,000 | `2` → `2000` | Saldo final RD$12,000 | L58–60 | ⬜ | ⬜ | [CP-02](evidencias/CP-02.png) |
| CP-03 | Depositar RD$0 | `2` → `0` | Rechazo; saldo sin cambios | L54 | ⬜ | ⬜ | [CP-03](evidencias/CP-03.png) |
| CP-04 | Retirar RD$3,000 | `3` → `3000` | Saldo final RD$7,000 | L90–92 | ⬜ | ⬜ | [CP-04](evidencias/CP-04.png) |
| CP-05 | Retirar RD$15,000 | `3` → `15000` | Rechazo por fondos insuficientes | L86 | ⬜ | ⬜ | [CP-05](evidencias/CP-05.png) |
| CP-06 | Retirar RD$-500 | `3` → `-500` | Rechazo; saldo sin cambios | L82 | ⬜ | ⬜ | [CP-06](evidencias/CP-06.png) |
| CP-07 | Cuenta inactiva; intentar retirar | `estadoCuenta = false`; `3` | Rechazo; saldo sin cambios | L69 | ⬜ | ⬜ | [CP-07](evidencias/CP-07.png) |
| CP-08 | Seleccionar opción 9 | `9` | Opción inválida; saldo sin cambios | L30 | ⬜ | ⬜ | [CP-08](evidencias/CP-08.png) |
| CP-09a | Letras en el menú | `abc` | Entrada inválida; sin cierre inesperado | L26 | ⬜ | ⬜ | [CP-09a](evidencias/CP-09a.png) |
| CP-09b | Letras en el monto | `2` → `abc` | Monto inválido; sin cierre inesperado | L50 | ⬜ | ⬜ | [CP-09b](evidencias/CP-09b.png) |
| CP-10 | Seleccionar opción 4 | `4` | El programa finaliza | L98 | ⬜ | ⬜ | [CP-10](evidencias/CP-10.png) |
| CP-11* | Retirar el saldo exacto | `3` → `10000` | Saldo final RD$0 | L90–92 | ⬜ | ⬜ | [CP-11](evidencias/CP-11.png) |

\* **CP-11 es una prueba adicional** de valor límite para RN-04 ("no puede **superar** el saldo"). No está en el BRD; se agregó para verificar que retirar exactamente el saldo disponible sea aceptado.

**Nota sobre CP-07:** como el programa se ejecuta una sola vez y la cuenta está precargada, esta prueba se realizó cambiando temporalmente `estadoCuenta` a `false` (L6). Después se restableció a `true`.

**Nota sobre CP-09:** se divide en dos porque hay dos puntos donde el usuario escribe un número: la opción del menú y el monto.

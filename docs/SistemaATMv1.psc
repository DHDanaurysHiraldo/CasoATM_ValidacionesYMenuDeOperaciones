Algoritmo SistemaATMv1
	Definir nombreCliente, numeroCuenta Como Cadena
	Definir saldoDisponible, montoOperacion Como Real
	Definir opcionDeMenu Como Entero
	Definir estadoCuenta Como Logico

	nombreCliente <- 'Samuel Reyes'
	numeroCuenta <- '0458291046'
	saldoDisponible <- 10000.00
	estadoCuenta <- Verdadero

	Escribir '================================='
	Escribir '===== SISTEMA DE CAJERO ATM ====='
	Escribir '=========================== v.1 ='
	Escribir ''
	Escribir 'INFORMACIÓN DE CUENTA ACTUAL:'
	Escribir 'Cliente: ', nombreCliente
	Escribir 'No. de Cuenta: ', numeroCuenta
	Escribir ''
	Escribir '¿Qué desea realizar hoy?'
	Escribir '1. Consultar saldo'
	Escribir '2. Depositar'
	Escribir '3. Retirar'
	Escribir '4. Salir'
	Escribir Sin Saltar 'Seleccione una opción: '
	Leer opcionDeMenu

	Segun opcionDeMenu Hacer
		1:
			Escribir 'Saldo actual: RD$', saldoDisponible

		2:
			Si estadoCuenta = Falso Entonces
				Escribir 'Operación rechazada: su cuenta no está activa'
			SiNo
				Escribir Sin Saltar 'Ingrese el monto a depositar: '
				Leer montoOperacion
				Si montoOperacion <= 0 Entonces
					Escribir 'Operación rechazada: el monto debe ser mayor que cero'
				SiNo
					saldoDisponible <- saldoDisponible + montoOperacion
					Escribir 'DEPÓSITO EXITOSO'
					Escribir 'Saldo actual: RD$', saldoDisponible
				FinSi
			FinSi

		3:
			Si estadoCuenta = Falso Entonces
				Escribir 'Operación rechazada: su cuenta no está activa'
			SiNo
				Escribir Sin Saltar 'Ingrese el monto a retirar: '
				Leer montoOperacion
				Si montoOperacion <= 0 Entonces
					Escribir 'Operación rechazada: el monto debe ser mayor que cero'
				SiNo
					Si montoOperacion > saldoDisponible Entonces
						Escribir 'Operación rechazada: fondos insuficientes'
					SiNo
						saldoDisponible <- saldoDisponible - montoOperacion
						Escribir 'RETIRO EXITOSO'
						Escribir 'Saldo actual: RD$', saldoDisponible
					FinSi
				FinSi
			FinSi

		4:
			Escribir 'Saliendo del programa...'

		De Otro Modo:
			Escribir 'Operación rechazada: opción inválida'
	FinSegun
FinAlgoritmo

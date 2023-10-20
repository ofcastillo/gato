Algoritmo GatoChipi
	Definir modojuego Como entero
	Dimension Tablero1[3,3]
	Dimension Tablero2[3,3]
	
	Escribir "Escribe 1 si quiere jugar Jugador v/s PC ó escribe 2 si quiere jugar Jugador1 vs Jugador2 "
	Leer modojuego
	
	si modojuego = 1 Entonces
		modojuegocabecera<- " Modo Jugador v/s PC "
	SiNo
		modojuegocabecera<-" Modo Jugador 1 v/s Jugador 2 "
		
	FinSi
	
	//Inicializa variables
	LimpiarTablero(Tablero1,0)
	LimpiarTablero(Tablero2," ")
	TurnoJugador1<-Verdadero
	Terminado<-Falso
	Ganador<-Falso
	CantTurnos<-0
	
	Mientras Terminado=Falso hacer
		ImprimirTablero(Tablero2,modojuegocabecera)
		Si Ganador=Falso y CantTurnos<9 Entonces
			Si TurnoJugador1 Entonces
				Ficha<-'X'
				Valor<-1
				Objetivo<-1
				si modojuego=2 entonces
					Escribir "Turno  del Jugador 1 (X)"
				SiNo
					Escribir "Tu Turno de Jugar (X)"
				FinSi
				
			Sino	
				Ficha<-'O' 
				Valor<-2; 
				Objetivo<-8
				Escribir "Turno  del Jugador 2 (0)"
			FinSi
			automatico<-0
			si modojuego=1 y ~ TurnoJugador1  entonces
				Pos=GenerarMovida(Tablero1)
				automatico<-1
			sino
				Escribir "Ingrese la Posicion a jugar (1-9):"
			FinSi
			
			
			Repetir
				si automatico=0 entonces
					Leer Pos
				FinSi
				
				Si Pos <1 o Pos>9 Entonces
					Escribir "Posicion incorrecta, ingrese nuevamente. "
					Pos<-99
				SiNo
					i<- trunc((Pos-1)/3)+1
					j<-((Pos-1) MOD 3)+1
					Si Tablero1[i,j]<>0 Entonces	
						Pos<-99
						Escribir "Posicion ya ocupada, Ingrese la Posicion a jugar (1-9):"
					FinSi
				FinSi
			Hasta Que Pos<>99
			
			CantTurnos<-CantTurnos+1
			Tablero1[i,j]<-Valor
			Tablero2[i,j]<-Ficha
			
			Ganador=validaGanador(Tablero1,Objetivo)
			si Ganador=Falso Entonces
				Si TurnoJugador1= Verdadero Entonces
					TurnoJugador1<-Falso
				SiNo
					TurnoJugador1<-Verdadero	
				FinSi
			FinSi
		SiNo
			Si Ganador Entonces	
				Escribir "Ganador: "
				si modojuego=1 Entonces
					Si TurnoJugador1 Entonces
						Escribir "Jugador!"
					Sino	
						Escribir "PC!"
					FinSi
				sino
					Si TurnoJugador1 Entonces
						Escribir "Jugador 1!"
					Sino	
						Escribir "Jugador 2!"
					FinSi
				FinSi
				
			SiNo
				Escribir "Empate!"
			FinSi
			Terminado<- Verdadero
		FinSi
	FinMientras
FinAlgoritmo

Funcion r<-GenerarMovida(Tablero1) 
		Definir i, j Como Entero
		bloquea=falso
		gana=falso
		
		// Primero, verifica si el jugador '0' puede ganar en su próximo movimiento.
		Para i <- 1 Hasta 3 Hacer
			Para j <- 1 Hasta 3 Hacer
				Si Tablero1[i, j] = 0 Entonces
					// Intenta colocar 'O' en esta posición y verifica si el jugador 'X' ganaría.
					Tablero1[i, j] <- 2
					jugadorganaria=validaGanador(Tablero1, 8)
					Si jugadorganaria  Entonces
						r<- (i - 1) * 3 + j
						gana=verdadero
					FinSi
					Tablero1[i, j] <- 0  // Deshaz el movimiento.
				FinSi
			FinPara
		FinPara
		
		si gana=falso entonces
			// Primero, verifica si el jugador 'X' puede ganar en su próximo movimiento.
			Para i <- 1 Hasta 3 Hacer
				Para j <- 1 Hasta 3 Hacer
					Si Tablero1[i, j] = 0 Entonces
						// Intenta colocar '1' en esta posición y verifica si el jugador 'X' ganaría.
						Tablero1[i, j] <- 1
						jugadorganaria=validaGanador(Tablero1, 1)
						Si jugadorganaria  Entonces
							r<- (i - 1) * 3 + j
							bloquea=verdadero
						FinSi
						Tablero1[i, j] <- 0  // Deshaz el movimiento.
					FinSi
				FinPara
			FinPara
		finsi
		si bloquea=falso y gana=falso entonces
			// Si no se puede bloquear una jugada ganadora del jugador 'X, realiza un movimiento aleatorio.
			Repetir
				r <- Aleatorio(1, 9)
				i <- trunc((r - 1) / 3) + 1
				j <- ((r - 1) MOD 3) + 1
			Hasta Que Tablero1[i, j] = 0
		finsi
		
FinFuncion


Funcion Ganador<-validaGanador(Tablero1,Objetivo)
	
	aux_d1<-1 
	aux_d2<-1
	Ganador=Falso
	Para i<-1 hasta 3 hacer
		aux_i<-1;aux_j<-1
		aux_d1<-aux_d1*Tablero1[i,i]
		aux_d2<-aux_d2*Tablero1[i,4-i]
		Para j<-1 hasta 3 hacer
			aux_i= aux_i*Tablero1[i,j]
			aux_j= aux_j*Tablero1[j,i]
		FinPara
		Si aux_i=Objetivo o aux_j=Objetivo Entonces
			Ganador<-Verdadero
		FinSi
	FinPara
	Si aux_d1=Objetivo o aux_d2=Objetivo Entonces
		Ganador<-Verdadero
	FinSi
	
FinFuncion

Funcion ImprimirTablero(Tablero1,modojuegocabecera)
	Borrar Pantalla;
	Escribir "      ---------------------------------";
	Escribir "      ",modojuegocabecera
	Escribir "      ---------------------------------";
	Escribir "      +---+---+---+       +---+---+---+";
	Escribir "      | 1 | 2 | 3 |       | ", Tablero1[1,1]," | ",Tablero1[1,2]," | ",Tablero1[1,3] ," |";
	Escribir "      +---+---+---+       +---+---+---+";
	Escribir "      | 4 | 5 | 6 |       | ", Tablero1[2,1]," | ",Tablero1[2,2]," | ",Tablero1[2,3] ," |";
	Escribir "      +---+---+---+       +---+---+---+";
	Escribir "      | 7 | 8 | 9 |       | ", Tablero1[3,1]," | ",Tablero1[3,2]," | ",Tablero1[3,3] ," |";
	Escribir "      +---+---+---+       +---+---+---+";
	Escribir "";
	
Finfuncion

Funcion LimpiarTablero(Tablero, relleno)
	
	Para i<-1 Hasta 3 Hacer
		Para j<-1 Hasta 3 Hacer	
			Tablero[i,j] = relleno
		FinPara
	FinPara	
	
FinFuncion
	

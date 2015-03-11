`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//  
// Proyecto Corto 1
//
//////////////////////////////////////////////////////////////////////////////////
module FSM_Proyecto1(
    input [4:0] Temperatura,
    input Motor,
    input Presencia,
    input Reset,
    input CLK,
    output Ventilador, Alarma,
    output reg [1:0] Estado
    );
	 
	// Decodificador de temperatura 
	reg TC;
	
	always@(posedge CLK) begin
		if (Temperatura < 5'b11100)
			TC <= 1'b0;
		else if ((Temperatura > 5'b11100)|(Temperatura == 5'b11100))
			TC <= 1'b1;
	end
	
//////////////////////////////////////////////////////////////////////////////////
	localparam estado_inicial = 2'd0,
				  estado1 = 2'd1,
				  estado2 = 2'd2,
				  estado3 = 2'd3;
	
	reg [1:0] estado_actual;
	reg [1:0] estado_siguiente;

	always@(posedge CLK) begin 
		if (Reset) 
			estado_actual <= estado_inicial;
		else
			estado_actual <= estado_siguiente;
	end
	
// Condiciones de transicion
	
	always@( * ) begin
	
		estado_siguiente = estado_actual;
		
		case (estado_actual)
			
			estado_inicial : begin estado_siguiente = estado1; end 
			
			estado1 : begin
				if (!Motor & Presencia)
					estado_siguiente = estado2;
				else if (Reset)
					estado_siguiente = estado_inicial;
			end
			
			estado2: begin
				if (TC)
					estado_siguiente = estado3;
				else if (Motor|Reset)
					estado_siguiente = estado_inicial;
			end
			
			estado3: begin
				if (TC & !Motor)
					estado_siguiente = estado3;
				else if (!TC|Motor|Reset)
					estado_siguiente = estado_inicial;
			end
			
		endcase
	end
	
// Salidas
	assign Ventilador = (estado_actual == estado2)|(estado_actual == estado3);
	assign Alarma = estado_actual == estado3;
	
	always@( * ) begin
		
		Estado = 2'b00;
		case (estado_actual)
			estado_inicial : begin Estado = 2'b00; end
			estado1 : begin Estado = 2'b01; end
			estado2 : begin Estado = 2'b10; end
			estado3 : begin Estado = 2'b11; end
		endcase
	end
	
endmodule

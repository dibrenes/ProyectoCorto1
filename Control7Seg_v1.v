`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Módulo del display de 7 segmentos con 4 digitos versión 1 
//
//////////////////////////////////////////////////////////////////////////////////

module Control7Seg_v1(
	 input wire CLK, Reset, In0, In1, ContEnable,
	 input wire [1:0] Estado,
    output reg [6:0] displayCA,
	 output reg [3:0] displayAN
    );
	 
//////////////////////////////////////////////////////////////////////////////////
// Decodificador de estado
//////////////////////////////////////////////////////////////////////////////////
	reg [6:0] NumEstado;
   
   //reg [2:0] Estado;

   always @(posedge CLK)
      if (Reset)
         NumEstado <= 7'b1111111;
      else
         case (Estado)
            2'b00  : NumEstado <= 7'b0000001;
            2'b01  : NumEstado <= 7'b1001111;
            2'b10  : NumEstado <= 7'b0010010;
            2'b11  : NumEstado <= 7'b0000110;
            default : NumEstado <= 7'b1111111;
         endcase
//////////////////////////////////////////////////////////////////////////////////
// Contador de digito a mostrar
//////////////////////////////////////////////////////////////////////////////////
	reg [1:0] Cuenta;

   //always @(posedge DivisorCLK[17])
	always @(posedge CLK)	
		if (Reset)
			Cuenta <= 2'b00;
		else if (ContEnable)
			Cuenta <= Cuenta + 1'b01;
			
//////////////////////////////////////////////////////////////////////////////////
// Divisor de frecuencia
//////////////////////////////////////////////////////////////////////////////////
//	reg [17:0] DivisorCLK;
//   
//   always @(posedge CLK)
//      if (Reset)
//         DivisorCLK <= 18'b0;
//      else if (ContEnable)
//			DivisorCLK <= DivisorCLK + 18'b1;
//////////////////////////////////////////////////////////////////////////////////
// Salidas respecto a la cuenta
//////////////////////////////////////////////////////////////////////////////////
	always@(posedge CLK) begin
		
		case (Cuenta)
			//Digito 0 del display, salida 0 : Ventilador
			2'b00 : begin
				displayAN <= 4'b1110;
				if(In0)
					displayCA <= 7'b1000001;
				else
					displayCA <= 7'b1111110;
					
			end
			//Digito 1 del display, salida 1 : Alarma
			2'b01 : begin
				displayAN <= 4'b1101;
				if(In1)
					displayCA <= 7'b0001000;
				else
					displayCA <= 7'b1111110;
			end
			//Digito 2 del display, número de estado
			2'b10 : begin
				displayAN <= 4'b1011;
				displayCA <= NumEstado;
			end
			//Digito 3 del display, letra "E" de estado
			2'b11 : begin
				displayAN <= 4'b0111;
				displayCA <= 7'b0110000;
			end
	
		endcase

	end

endmodule

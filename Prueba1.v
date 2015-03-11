`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:56:14 03/02/2015
// Design Name:   PCorto1Final
// Module Name:   C:/Users/diego_000/Desktop/Proyectos/PCorto1Final/Prueba1.v
// Project Name:  PCorto1Final
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PCorto1Final
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Prueba1;

	// Inputs
	reg [4:0] Temperatura;
	reg Motor;
	reg Presencia;
	reg ContEnable;
	reg Reset;
	reg CLK;

	// Outputs
	wire [6:0] displayCA;
	wire [3:0] displayAN;
	wire Ventilador;
	wire Alarma;

	// Instantiate the Unit Under Test (UUT)
	PCorto1Final uut (
		.Temperatura(Temperatura), 
		.Motor(Motor), 
		.Presencia(Presencia), 
		.ContEnable(ContEnable), 
		.Reset(Reset), 
		.CLK(CLK), 
		.displayCA(displayCA), 
		.displayAN(displayAN), 
		.Ventilador(Ventilador), 
		.Alarma(Alarma)
	);

	initial 
	begin
		// Initialize Inputs
		CLK = 0;
		Temperatura = 00000;
		Motor = 1;
		Presencia = 0;
		ContEnable = 0;
		Reset = 0;
		#20;
      end
      initial
      begin
      @(negedge CLK) 		
		Temperatura = 00011;
		Motor = 0;
		Presencia = 1;
		ContEnable = 1;
		Reset = 1;
		#20 
		@(negedge CLK) 		
		Temperatura = 11111;
		Motor = 0;
		Presencia = 1;
		Reset = 0;
		#20 
		@(negedge CLK) 		
		Temperatura = 11111;
		Motor = 0;
		Presencia = 1;
		Reset = 0;	
	// Add stimulus here
		

	end
    initial forever #10 CLK  =~CLK;
endmodule


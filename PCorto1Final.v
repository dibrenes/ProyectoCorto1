`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//  
// Proyecto Corto 1 Final
//
//////////////////////////////////////////////////////////////////////////////////
module PCorto1Final(
    input [4:0] Temperatura,
    input Motor,
    input Presencia,
    input ContEnable,
    input Reset,
    input CLK,
	 output [6:0] displayCA,
	 output [3:0] displayAN,
    output Ventilador,
    output Alarma
    );
	 
// Cables
	
	wire [1:0] c0;
	wire [6:0] c1;
	wire [3:0] c2;
	 
// Instancia de la FSM del proyecto 1

FSM_Proyecto1 FSM_Principal (
    .Temperatura(Temperatura), 
    .Motor(Motor), 
    .Presencia(Presencia), 
    .Reset(Reset), 
    .CLK(CLK), 
    .Ventilador(Ventilador), 
    .Alarma(Alarma), 
    .Estado(c0)
    );

// Instancia del control del display de 7 segmentos

Control7Seg_v1 Display (
    .CLK(CLK), 
    .Reset(Reset), 
    .In0(Ventilador), 
    .In1(Alarma), 
    .ContEnable(ContEnable), 
    .Estado(c0), 
    .displayCA(c1), 
    .displayAN(c2)
    );
	 
	 assign displayCA = c1;
	 assign displayAN = c2;

endmodule 
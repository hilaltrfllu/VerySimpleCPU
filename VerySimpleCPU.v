`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:38:37 03/30/2018 
// Design Name: 
// Module Name:    VerySimpleCPU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module VerySimpleCPU(clk, rst, data_fromRAM, wrEn, addr_toRAM, data_toRAM);

parameter SIZE = 14;

input clk, rst;
input wire [31:0] data_fromRAM;
output reg wrEn;
output reg [SIZE-1:0] addr_toRAM;
output reg [31:0] data_toRAM;

//////////////////////////
reg [3:0] state_current , state_next ;
reg [SIZE-1:0] pc_current , pc_next ; // pc: program counter
reg [31:0] iw_current , iw_next ; // iw: instruction word
reg [31:0] r1_current , r1_next ;
reg [31:0] r2_current , r2_next ;
always@ ( posedge clk ) begin
	if( rst ) begin
		state_current <= 0;
		pc_current <= 14'b0 ;
		iw_current <= 32'b0 ;
		r1_current <= 32'b0 ;
		r2_current <= 32'b0 ;
	end
	else begin
		state_current <= state_next ;
		pc_current <= pc_next ;
		iw_current <= iw_next ;
		r1_current <= r1_next ;
		r2_current <= r2_next ;
	end
end

always@ (*) begin 
	state_next = state_current ;
	pc_next = pc_current ;
	iw_next = iw_current ;
	r1_next = r1_current ;
	r2_next = r2_current ;
	wrEn = 0;
	addr_toRAM = 0;
	data_toRAM = 0;
	case ( state_current )
	0: begin
		pc_next = 0;
		iw_next = 0;
		r1_next = 0;
		r2_next = 0;
		state_next = 1;
	end
	1: begin
		addr_toRAM = pc_current ;
		state_next = 2;
	end
	2: begin
		iw_next = data_fromRAM ;
		case ( data_fromRAM [31:28])
			{3'b000 ,1'b0 }: begin //ADD
			addr_toRAM = data_fromRAM [27:14];
			state_next = 3;
			end
			{3'b000,1'b1}: begin //ADDi
			addr_toRAM = data_fromRAM[27:14];
			state_next = 3;
			end
			{3'b001,1'b0}: begin //NAND
			addr_toRAM = data_fromRAM[27:14];
			state_next = 3;
			end
			{3'b001,1'b1}: begin //NANDi
			addr_toRAM = data_fromRAM[27:14];
			state_next = 3;
			end
			{3'b010,1'b0}: begin //SRL
			addr_toRAM = data_fromRAM[27:14];
			state_next = 3;
			end
			{3'b010,1'b1}: begin //SRLi
			addr_toRAM = data_fromRAM[27:14];
			state_next = 3;
			end
			{3'b011,1'b0}: begin //LT
			addr_toRAM = data_fromRAM[27:14];
			state_next = 3;
			end
			{3'b011,1'b1}: begin //LTi
			addr_toRAM = data_fromRAM[27:14];
			state_next = 3;
			end
			{3'b111,1'b0}: begin //MUL
			addr_toRAM = data_fromRAM[27:14];
			state_next = 3;
			end
			{3'b111,1'b1}: begin //MULi
			addr_toRAM = data_fromRAM[27:14];
			state_next = 3;
			end
			{3'b100,1'b1}: begin //CP
			addr_toRAM = data_fromRAM[13:0];
			state_next = 3;
			end
			{3'b100,1'b1}: begin //CPi
			addr_toRAM = data_fromRAM[13:0];
			state_next = 3;
			end
			{3'b101,1'b0}: begin //CPI
			addr_toRAM = data_fromRAM[13:0];
			state_next = 3;
			end
			{3'b101,1'b1}: begin //CPIi
			addr_toRAM = data_fromRAM[13:0];
			state_next = 3;
			end
			{3'b110,1'b0}: begin //BJZ
			addr_toRAM = data_fromRAM[27:14];
			state_next = 3;
			end
			{3'b110,1'b1}: begin //BJZi
			addr_toRAM = data_fromRAM[27:14];
			state_next = 3;
			end
	default : begin
		pc_next = pc_current ;
		state_next = 1;
		end
	endcase
	end
	
	3: begin
		case(iw_current[31:28])
			{3'b000,1'b0}: begin //ADD
			r1_next = data_fromRAM;
			addr_toRAM = iw_current[13:0];
			state_next = 4;
			end
			{3'b000,1'b1}: begin //ADDi
			r1_next = data_fromRAM;
			r2_next = iw_current[13:0];
			state_next = 4;
			end
			{3'b001,1'b0}: begin //NAND
			r1_next = data_fromRAM;
			addr_toRAM = iw_current[13:0];
			state_next = 4;
			end
			{3'b001,1'b1}: begin //NANDi
			r1_next = data_fromRAM;
			r2_next = iw_current[13:0];
			state_next = 4;
			end
			{3'b010,1'b0}: begin //SRL
			r1_next = data_fromRAM;
			addr_toRAM = iw_current[13:0];
			state_next = 4;
			end
			{3'b010,1'b1}: begin //SRLi
			r1_next = data_fromRAM;
			r2_next = iw_current[13:0];
			state_next = 4;
			end
			{3'b011,1'b0}: begin //LT
			r1_next = data_fromRAM;
			addr_toRAM = iw_current[13:0];
			state_next = 4;
			end
			{3'b011,1'b1}: begin //LTi
			r1_next = data_fromRAM;
			r2_next = iw_current[13:0];
			state_next = 4;
			end
			{3'b111,1'b0}: begin //MUL
			r1_next = data_fromRAM;
			addr_toRAM = iw_current[13:0];
			state_next = 4;
			end
			{3'b111,1'b1}: begin //MULi
			r1_next = data_fromRAM;
			r2_next = iw_current[13:0];
			state_next = 4;
			end
			{3'b100,1'b0}: begin //CP *
			r2_next = data_fromRAM;
			addr_toRAM = iw_current[27:14]; 
			state_next = 4;
			end
			{3'b100,1'b1}: begin //CPi *
			r1_next = data_fromRAM;
			r2_next = iw_current[27:14];
			state_next = 4;
			end
			{3'b101,1'b0}: begin //CPI
			r1_next = data_fromRAM;
			addr_toRAM = data_fromRAM;
			state_next = 4;
			end
			{3'b101,1'b1}: begin //CPIi
			r1_next = data_fromRAM;
			addr_toRAM = iw_current[13:0];
			state_next = 4;
			end
			{3'b110,1'b0}: begin //BJZ
			r1_next = data_fromRAM;
			addr_toRAM = iw_current[13:0];
			state_next = 4;
			end
			{3'b110,1'b1}: begin //BJZi
			r1_next = data_fromRAM;
			r2_next = iw_current[13:0];
			state_next = 4;
			end
		endcase
	end
	4: begin
		case (iw_current [31:28])
			{3'b000 ,1'b0 }: begin //ADD
				wrEn = 1;
				addr_toRAM = iw_current [27:14];
				data_toRAM = data_fromRAM + r1_current ;
				pc_next = pc_current + 1'b1 ;
				state_next = 1;
			end
			{3'b00,1'b1}: begin //ADDi
				wrEn = 1;
				addr_toRAM = iw_current [27:14];
				data_toRAM = r2_current + r1_current;
				pc_next = pc_current + 1'b1;
				state_next = 1;
			end
			{3'b001,1'b0}: begin //NAND
				wrEn = 1;
				r2_next = data_fromRAM;
				addr_toRAM = iw_current [27:14];
				data_toRAM = ~(r1_current & r2_current);
				pc_next = pc_current + 1'b1;
				state_next = 1;
			end
			{3'b001,1'b1}: begin //NANDi
				wrEn = 1;
				addr_toRAM = iw_current [27:14];
				data_toRAM = ~(r2_current & r1_current);
				pc_next = pc_current + 1'b1;
				state_next = 1;
			end
			{3'b010,1'b0}: begin //SRL
				wrEn = 1;
				r2_next = data_fromRAM;
				addr_toRAM = iw_current [27:14];
				data_toRAM = ((r2_current < 14'd32) ? (r1_current >> r2_current) : (r1_current << (r2_current - 14'd32)));
				pc_next = pc_current + 1'b1;
				state_next = 1;
			end
			{3'b010,1'b1}: begin //SRLi
				wrEn = 1;
				addr_toRAM = iw_current [27:14];
				data_toRAM = ((r2_current < 14'd32) ? (r1_current >> r2_current) : (r2_current << (r2_current-14'd32)));
				pc_next = pc_current + 1'b1;
				state_next = 1;
			end
			{3'b011,1'b0}: begin //LT
				wrEn=1;
				r2_next = data_fromRAM;
				addr_toRAM = iw_current [27:14];
				data_toRAM = ((r1_current < r2_current) ? 1'b1 : 1'b0);
				pc_next = pc_current + 1'b1;
				state_next = 1;
			end
			{3'b011,1'b1}: begin //LTi
				wrEn=1;
				addr_toRAM = iw_current [27:14];
				data_toRAM = ((r1_current < r2_current) ? 1'b1 : 1'b0);
				pc_next = pc_current + 1'b1;
				state_next = 1;
			end
			{3'b111,1'b0}: begin //MUL
				wrEn=1;
				r2_next = data_fromRAM;
				addr_toRAM = iw_current [27:14];
				data_toRAM = (r1_current * r2_current);
				pc_next = pc_current + 1'b1;
				state_next = 1;
			end
			{3'b111,1'b1}: begin //MULi
				wrEn=1;
				addr_toRAM = iw_current [27:14];
				data_toRAM = (r1_current * r2_current);
				pc_next = pc_current + 1'b1;
				state_next = 1'b1;
			end
			{3'b100,1'b0}: begin //CP
				wrEn=1;
				addr_toRAM = iw_current [13:0];
				iw_current[27:14] = r2_current;
				pc_next = pc_next + 1'b1;
				state_next = 1;
			end
			{3'b100,1'b1}: begin //CPi
				wrEn = 1;
				addr_toRAM = iw_current[13:0];
				data_toRAM = r2_current;
				pc_next = pc_next + 1'b1;
				state_next = 1;
			end
			{3'b101,1'b0}: begin //CPI
				wrEn = 1;
				r2_next = data_fromRAM;
				addr_toRAM = iw_current[27:14];
				data_toRAM = r2_current;
				pc_next = pc_next + 1'b1;
				state_next = 1;
			end
			{3'b101,1'b1}: begin //CPIi
				wrEn = 1;
				r2_next = data_fromRAM;
				addr_toRAM = r1_current;
				data_toRAM = r2_current;
				pc_next = pc_next + 1'b1;
				state_next = 1;
			end
			{3'b110,1'b1}: begin //BJZ
				r2_next = data_fromRAM;
				pc_next = ((r2_current == 0) ? r1_current : (pc_current + 1'b1));
				state_next = 1;
			end
			{3'b110,1'b1}: begin //BJZi
				pc_next = r1_current + r2_current;
				state_next = 1;
			end
		endcase
	end
endcase
end
//////////////////////////

endmodule


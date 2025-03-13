`timescale 1ns / 1ps


module cel(input [30:0]ctr, input [1:0]cbi,input [5:0]sbi, output [1:0]cbo, output wire[5:0]sbo);
	wire [1:0]di;
	wire clk,q;
	
	wire [7:0] out_sb;
	wire [1:0] cb_to_sb;
	wire [2:0] cb_to_clb;
	
	clb b(ctr[4:0], di,clk,q);
	SB s({sbi[5:2],cb_to_sb,sbi[1:0]}, ctr[20:5],out_sb);
	
	cb c(out_sb[7:6], cbi, q, ctr[30:21],cb_to_sb, cbo, cb_to_clb);
	
	assign sbo = out_sb[5:0];
	
	assign clk = cb_to_clb[0];
	assign di = cb_to_clb[2:1];

endmodule

module fcel(input [123:0]ctrs, input[3:0] cbis, input[11:0] sbis, output[3:0] cbos, output[11:0] sbos);
	wire [1:0] c2_c1;
	wire [1:0] c3_c1;
	wire [1:0] c1_c2;
	wire [1:0] c1_c3;
	wire [1:0] c4_c2;
	wire [1:0] c2_c4;
	wire [1:0] c3_c4;
	wire [1:0] c4_c3;
	cel c1(ctrs[30:0], cbis[1:0],{c3_c1, c2_c1, sbis[1:0]}, cbos[1:0], {c1_c3,c1_c2, sbos[1:0]});
	cel c2(ctrs[61:31], c1_c2, {c4_c2,sbis[5:2]}, c2_c1, {c2_c4,sbos[5:2]});
	cel c3(ctrs[92:32], cbis[3:2], {sbis[7:6],c4_c3,c1_c3}, cbos[3:2], {sbos[7:6],c3_c4,c3_c1});
	cel c4(ctrs[123:93], c3_c4, {sbis[11:8],c2_c4}, c4_c3, {sbos[11:8],c4_c2});
endmodule

/////////////////////////////   CLB part
module clb(input [4:0] data_in, input [1:0] sel, input clk, output data_out);

	wire lut_out;
	wire dff_out;

	mux4 m4(data_in[3:0], sel, lut_out);
	d_ff f(lut_out, clk, dff_out);

	nmos(data_out, dff_out, data_in[4]);
	pmos(data_out, lut_out, data_in[4]);

endmodule

module d_ff(
	input d, input clk, output q1
    );
	wire w1,w2,w4,w5,nq,q;
	supply1 vdd;
	supply0 gnd;
	
	pmos(w1,vdd,d);
	pmos(nq,w1,~clk);
	nmos(nq,w2,clk);
	nmos(w2,gnd,d);
	
	pmos(q,vdd,nq);
	nmos(q,gnd,nq);
	
	pmos(w4,vdd,q);
	pmos(nq,w4,clk);
	
	nmos(nq,w5,~clk);
	nmos(w5,gnd,q);
	
	assign q1 = q;
endmodule

module mux4(
    input [3:0]in,
    input [1:0]sel,
    output out
);
	wire w3,w4;
	
	nmos(w3, in[3],sel[0]);
	nmos(w4, in[1],sel[0]);

	pmos(w3, in[2],sel[0]);
	pmos(w4, in[0],sel[0]);

	nmos(out, w4,sel[1]);

	pmos(out, w3,sel[1]);

endmodule


/////////////////// Connection block part

module cb(input[1:0] ri, input [1:0]li, input q,input [9:0]sel,
	output wire[1:0]ro, output wire[1:0]lo, output wire[2:0]clb
    );
	wire [5:0]ups;
	wire [1:0]rs ;
	wire [1:0]ls;
	assign ups = sel[5:0];
	assign rs = sel[7:6];
	assign ls = sel[9:8];
	// clb output
	mux4 clk( {ri[0],li[0],ri[1],li[1]} ,ups[1:0],clb[0]);
	mux4 d0( {ri[0],li[0],ri[1],li[1]} ,ups[3:2],clb[1]);
	mux4 d1( {ri[0],li[0],ri[1],li[1]} ,ups[5:4],clb[2]);
	
	// right output
	mux2 m1(li[0],q,rs[0],ro[0]);
	mux2 m2(li[1],q,rs[1],ro[1]);
	

	// left output
	mux2 m3(ri[0],q,ls[0],lo[0]);
	mux2 m4(ri[1],q,ls[1],lo[1]);

endmodule




/////////////////////////////  Switch box part

module SB(input [7:0]in, input [15:0] sel,output [7:0]out);
	wire [1:0]u;
	wire [1:0]b;
	wire [1:0]r;
	wire [1:0]l;
	
	wire [1:0]ou;
	wire [1:0]ob;
	wire [1:0]our;
	wire [1:0]ol;
	
	assign u = in[1:0];
	assign r = in[3:2];
	assign b = in[5:4];
	assign l = in[7:6];
	side up({l,b,r},sel[3:0],ou);
	side dow({l,u,r},sel[7:4],ob);
	side lef({u,r,b},sel[11:8],ol);
	side right({u,l,b},sel[15:12],our);
	assign out = {ol,ob,our,ou};
	
endmodule


module side(input [5:0]in, input [3:0]sel, output wire[1:0]out);
	mux3 m1(in[2:0],sel[1:0],out[0]);
	mux3 m2(in[5:3],sel[3:2],out[1]);
	
endmodule

module mux3(input [2:0]in, input [1:0]sel, output wire out);
	wire w1,w2;
	
	pmos(w1,in[0],sel[0]);
	nmos(w1,in[1],sel[0]);
	pmos(w2, in[2], sel[0]);
	
	nmos(out, w2,sel[1]);
	pmos(out, w1, sel[1]);
endmodule

module mux2(input a,input b, input sel, output out);
	nmos(out,b,sel);
	pmos(out,a,sel);
endmodule

//****************************************************
//	PROJECT DIGITA LOGIC CIRCUITS 
//	NAME: ABDUL QADIR FARTASH
//	ID STUDEN : 99243100
//	PRAT : 1	
//      Implement: F = AC + ABC` + BD + A`C`D`
//****************************************************


module Trans_Level(A,B,C,D,F);
	input A,B,C,D;
	output F;
	wire nA, nC, nD, nf;
	wire n1,n2,n3,n4,n5,n6;
	wire p1,p2,p3;
	supply1 vdd;
	supply0 gnd;

	// We need to not A, not C, not D for function 
	// finde not A, C, D.
	not nt1(nA, A);
	not nt2(nC, C);
	not nt3(nD,D);


	// Part PMOS
	pmos b10(p1,vdd, nA);
	pmos b9(p1, vdd, nC);
	pmos b8(p1, vdd, nD);

	pmos b7(p2, p1, D);
	pmos b6(p2, p1, B);
	
	pmos b5(p3, p2, A);
	pmos b4(p3, p2, B);
	pmos b3(p3, p2, nC);

	pmos b2(nf, p3, C);
	pmos b1(nf, p3, A);
	


	// Part NMOS
	nmos a1(n1, gnd, C);
	nmos a2(n2, gnd, C);
	nmos a3(n3, gnd, D);
	nmos a4(n4, gnd, nD);

	nmos a5(n5, n2, B);
	nmos a6(n6, n4, nC);

	nmos a7 (nf, n1, A);
	nmos a8 (nf, n5, A);
	nmos a9 (nf, n3, B);
	nmos a10(nf, n6, nA);

	not f(F,nf);

endmodule

//****************************************************
//	PROJECT DIGITA LOGIC CIRCUITS 
//	NAME: ABDUL QADIR FARTASH
//	ID STUDEN : 99243100
//	PRAT : 1	
//      Implement: F = AC + ABC` + BD + A`C`D`
//****************************************************



module Trans_Level(
	input A,B,C,D,
	output F
);
	wire nA, nC, nD, nf;
	wire n1,n2,n3,n4,n5,n6;
	wire p1,p2,p3;
	supply1 vdd;
	supply0 gnd;

	// We need to not A, not C, not D for function 
	// finde not A, C, D.
	Not_Vir a(A, nA);
	Not_Vir c(C, nC);
	Not_Vir d(D, nD);



	// Part PMOS
	pmos(p1,vdd, nA);
	pmos(p1, vdd, nC);
	pmos(p1, vdd, nD);

	pmos(p2, p1, D);
	pmos(p2, p1, B);
	
	pmos(p3, p2, A);
	pmos(p3, p2, B);
	pmos(p3, p2, nC);

	pmos(nf, p3, C);
	pmos(nf, p3, A);
	


	// Part NMOS
	nmos(n1, gnd, C);
	nmos(n2, gnd, C);
	nmos(n3, gnd, D);
	nmos(n4, gnd, nD);

	nmos(n5, n2, B);
	nmos(n6, n4, nC);

	nmos(nf, n1, A);
	nmos(nf, n5, A);
	nmos(nf, n3, B);
	nmos(nf, n6, nA);

	Not_Vir re(nf, F);

endmodule




module Not_Vir(input A, output nA);

	supply1 vdd;
	supply0 gnd;
	pmos(nA,vdd,A);
	nmos(nA,gnd,A);


endmodule

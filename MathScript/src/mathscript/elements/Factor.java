package mathscript.elements;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import math.DoubleCheck;
import mathscript.symbols.Op;

public class Factor extends MathElement {

//	private Literal base, exponent;
	//list of literals, linked by power operator: l[0] ^ l[1] ^ ... ^ l[n]
	private List<Literal> literals = new ArrayList<Literal>();
	private byte signOfExponent;

	public Factor(byte signOfExponent) {
		this.signOfExponent = signOfExponent;
	}
	
	
	@Override
	public String toString() {
		Iterator<Literal> it = literals.iterator();
		StringBuilder bld = new StringBuilder(it.next().toString());
		while(it.hasNext()) {
			bld.append(Op.EXP.getSymbol());
			bld.append(it.next().toString());
		}
		return bld.toString();
	}

	public boolean add(Literal e) {
		return literals.add(e);
	}


	@Override
	public double toDouble() {
		double rc = 1.0;
		assert signOfExponent==1 || signOfExponent==-1;
		int size = literals.size();
		if(size == 1) {
			rc = literals.get(0).toDouble();
			if(signOfExponent<0) rc = 1.0 / rc;
		} else if (size>1) {
			int i=size-2;
			double e=literals.get(size-1).toDouble();
			for(; i>0; i--) {
				e=Math.pow(literals.get(i).toDouble(), e);
			}
			assert i==0;
			rc = Math.pow(literals.get(0).toDouble(), signOfExponent*e);
		}
		return rc;
	}

	int getSignOfExponent() {
		return signOfExponent;
	}
	
}
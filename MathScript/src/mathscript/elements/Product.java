package mathscript.elements;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import mathscript.symbols.Op;

//<product> ::= <literal> { (  ́* ́ | / ) <literal }
public class Product extends MathElement {

	public Product(byte sign) {
		super();
		this.sign = sign;
	}
	private byte sign;
	List<Factor> factors = new ArrayList<Factor>();

	public boolean add(Factor e) {
		return factors.add(e);
	}

	@Override
	public String toString() {
		Iterator<Factor> it = factors.iterator();
		StringBuilder bld = new StringBuilder();
		if (sign < 0) {
			bld.append('-');
		}
		if (it.hasNext()) {
			Factor factor = it.next();
			if (factor.getSignOfExponent() < 0) {
				bld.append("1 ");
				bld.append(Op.DIV.getSymbol());
				bld.append(' ');
			}
			bld.append(factor.toString());
		}
		while (it.hasNext()) {
			Factor factor = it.next();
			bld.append(' ');
			bld.append((factor.getSignOfExponent() < 0)
				? Op.DIV.getSymbol()
				: Op.MUL.getSymbol());
			bld.append(' ');
			bld.append(factor);
		}
		return bld.toString();
	}

	@Override
	public double toDouble() {
		double product = 1;
		for (Factor t : factors) {
			product *= t.toDouble();
		}
		return sign * product;
	}

	int getSign() {
		return sign;
	}
}

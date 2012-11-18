package mathscript.elements;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import mathscript.symbols.Op;

public class Expression extends MathElement {
	List<Product> products = new ArrayList<Product>();
	@Override
	public String toString() {
		if(products.size()==1)
			return products.get(0).toString();
		Iterator<Product> it = products.iterator();
		StringBuilder bld = new StringBuilder();
		if(it.hasNext()) {
			bld.append(it.next());
			bld.append(' ');
		}
		while(it.hasNext()) {
			Product product = it.next();
			bld.append((product.getSign()<0) ? 
				Op.MINUS.getSymbol() :
				Op.PLUS.getSymbol());
			bld.append(' ');
			bld.append(product.toString());
			bld.append(' ');
		}
		return bld.toString();
	}
	@Override
	public double toDouble() {
		double sum = 0;
		for(Product t : products)
			sum += t.toDouble();
		return sum;
	}
	public void add(Product product) {
		products.add(product);
	}

}

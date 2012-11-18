package mathscript.types;

import mathscript.elements.Number;

public class R extends Number<Double> {

	public R(Double value) {
		super(value);
	}

	@Override
	public double toDouble() {
		return value.doubleValue();
	}
	
}

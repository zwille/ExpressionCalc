package mathscript.types;

import mathscript.elements.Number;

public class Z extends Number<Integer> {

	public Z(Integer value) {
		super(value);
	}

	@Override
	public double toDouble() {
		return value.doubleValue();
	}

}

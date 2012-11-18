
package mathscript.elements;

/**
 *
 * @author ccwelich
 */
public class Constant extends Symbol {
	private String name;
	private double value;

	public Constant(String name, double value) {
		this.name = name;
		this.value = value;
	}

	public String getName() {
		return name;
	}

	public double getValue() {
		return value;
	}
	public final static Constant PI=new Constant("\u03c0",Math.PI), E=new Constant("e",Math.E);

	@Override
	public double toDouble() {
		return value;
	}

	@Override
	public String toString() {
		return name;
	}
}

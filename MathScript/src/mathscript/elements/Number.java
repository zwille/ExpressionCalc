package mathscript.elements;

public abstract class Number<Type> extends MathElement {
	protected Type value;

	public Number(Type value) {
		super();
		this.value = value;
	}

	public Type getValue() {
		return value;
	}

	@Override
	public String toString() {
		return value.toString();
	}
}

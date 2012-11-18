package mathscript.elements;


//<Literal> 		::= ( <Value> | <WildCard> | '(' <Expression ')' ) [ <Prefix> ] 
public  class Literal extends MathElement {
	MathElement element;
	//Postfix postfix;
	public Literal(Number element) {
		super();
//		this.postfix = postfix;
		this.element = element;
	}
	public Literal(Symbol element) {
		super();
//		this.postfix = postfix;
		this.element = element;
	}
	public Literal(Expression element) {
		super();
//		this.postfix = postfix;
		this.element = element;
	}
	public MathElement getElement() {
		return element;
	}

	@Override
	public String toString() {
		if(element instanceof Expression)
			return "( " +  element.toString() + ')';
		return element.toString();
	}
	@Override
	public double toDouble() {
		return element.toDouble();
	}
	
}

	
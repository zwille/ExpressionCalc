package mathscript.parser;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;

public final class Tokenizer {

	private Reader reader;
	private Object token;
	private TokenType type;
	private int index = -1;
	private int raw = -1;

	public Tokenizer(Reader reader) throws IOException {
		this.reader = reader;
		read();
		nextToken();
	}

	public int getIndex() {
		return index;
	}

	public Object previewToken() {
		return token;
	}

	public Object nextToken() throws IOException, NumberFormatException {
		Object rc = token;
		while (raw != '\n' && Character.isWhitespace(raw)) {
			read();
		}
		StringBuilder bld = new StringBuilder();
		if (raw == -1 || raw == 4) {
			token = null;
			type = TokenType.EOF;
		} else if (raw == '\n') {
			token = null;
			type = TokenType.EOL;
		} else if (Character.isLetter(raw)) {
//			System.out.println("   Tok::nextToken() found letter");
			token = parseWord(bld);
			type = TokenType.WORD;
		} else if (raw == '.' || Character.isDigit(raw)) {
			parseNumber(bld);
		} else {
			token = (char) raw;
			read();
			type = TokenType.SPECIAL;
		}
//		System.out.println("   Tokenizer::nextToken rc = "+rc+", next = "+token);
		return rc;
	}

	private void parseNumber(StringBuilder bld) throws IOException, NumberFormatException {
		boolean isDouble = false;
		while (true) {
			if (raw == '.') {
				isDouble = true;
				bld.append((char) raw);
				read();
			} else if (raw == 'e' || raw == 'E') {
				isDouble = true;
				bld.append((char) raw);
				read();
				if (raw == '+' || raw == '-') {
					bld.append((char) raw);
					read();
				}
			} else if (Character.isDigit(raw)) {
				bld.append((char) raw);
				read();
			} else {
				break;
			}
		}
		if (isDouble) {
			token = new Double(bld.toString());
			type = TokenType.DECIMAL;
		} else {
			token = new Integer(bld.toString());
			type = TokenType.INTEGER;
		}
	}

	private Object parseSpecial(StringBuilder bld) throws IOException {
		do {
			bld.append((char) raw);
			read();
		} while (!Character.isLetter(raw)
			&& !Character.isDigit(raw)
			&& raw != -1
			&& !Character.isWhitespace(raw));
		return bld.toString();
	}

	private String parseWord(StringBuilder bld) throws IOException {
		do {
			bld.append((char) raw);
			read();
		} while (Character.isLetter(raw));
		return bld.toString();
	}

	private void read() throws IOException {
		raw = reader.read();
//		System.out.print("   Tokenizer::read() ("+raw+") char: '");
//		System.out.println((char)raw + "'");
		index++;
	}

	public TokenType tokenType() {
		return type;
	}

	public static void main(String[] args) {
		BufferedReader r = new BufferedReader(new InputStreamReader(System.in));
		try {
			Tokenizer tok = new Tokenizer(r);
			while (tok.tokenType()!=TokenType.EOF) {
				System.out.println("Type= " + tok.tokenType());
				String token = (String) tok.nextToken();
				synchronized(System.in) {
					if(token==null) System.in.wait();
				}
				System.out.println("Token= " + token);
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}

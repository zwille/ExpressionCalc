//
//  Symbols.h
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 19.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#ifndef ExpressionCalc_Symbols_h
#define ExpressionCalc_Symbols_h

typedef enum {OP_ADD='+', OP_SUB='-', OP_MULT='*', OP_DIV='/', OP_EXP='^'} XCOperatorChar;
typedef enum {PI= 0x03c0, EULER=0x212f,SQRT = 0x221a, EXP_BASE10='E', PUNCT='.',LEFT_BRACE='(', RIGHT_BRACE=')'} XCSpecialChar;
typedef enum {FN_SQRT, FN_COS, FN_SIN, FN_TAN, FN_ACOS, FN_ASIN, FN_ATAN, FN_EXP} XCFunctionSymbol;
typedef enum {VAR_A,VAR_B,VAR_C,VAR_D} XCVariableSymbol;

#endif

ExpressionCalc
==============

Calculator for iOs
##features
* operators +,-,*,/,^
* order of operations: ^ > (*,/) > (+,-)
* navigate and edit expressions
* bracketing
* simple functions
* variables and constants
* mahtml output
* expression stack

##directories
* docu: german latex documentation / UML classes, sequences in dia/pdf
* XCCalc: ViewController and Xcode-project files, binds XCKernel and XCKernelTests
* XCKernel: core functionalities
* XCKernelTests: core tests

##TODO
* Better View Design
* Views for ipad and other iphone models
* more special functions like x^2 log_b(x)
* ESC-Button - goto top level element
* regular division and fraction
* rational and complex numbers
* better normalizing to mathematical accurracy
* use less buttons (shift-button), get more space 

##issues
UIWebView sometimes produces strange output on "focused" elements.
It seems to recognize numbers as links (now suppressed in css)
Also tested in Safari and W3CValidator: HTML output seems okay.

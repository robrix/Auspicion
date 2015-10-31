//  Copyright © 2015 Rob Rix. All rights reserved.

enum Constant: BooleanLiteralConvertible, IntegerLiteralConvertible {
	case Boolean(Bool)
	case Integer(Int)


	// MARK: BooleanLiteralConvertible

	init(booleanLiteral: Bool) {
		self = .Boolean(booleanLiteral)
	}


	// MARK: IntegerLiteralConvertible

	init(integerLiteral: Int) {
		self = .Integer(integerLiteral)
	}
}

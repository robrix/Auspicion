//  Copyright © 2015 Rob Rix. All rights reserved.

enum Constant: BooleanLiteralConvertible, FloatLiteralConvertible, IntegerLiteralConvertible {
	case Boolean(Bool)
	case Integer(Int)
	case Real(Double)


	var type: Type {
		switch self {
		case .Boolean:
			return .Boolean
		case .Integer:
			return .Integer(sizeof(Int.self))
		case .Real:
			return .Double
		}
	}


	// MARK: BooleanLiteralConvertible

	init(booleanLiteral: Bool) {
		self = .Boolean(booleanLiteral)
	}


	// MARK: FloatLiteralConvertible

	init(floatLiteral: Double) {
		self = .Real(floatLiteral)
	}


	// MARK: IntegerLiteralConvertible

	init(integerLiteral: Int) {
		self = .Integer(integerLiteral)
	}
}

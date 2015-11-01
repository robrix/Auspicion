//  Copyright © 2015 Rob Rix. All rights reserved.

public enum Value: BooleanLiteralConvertible, FloatLiteralConvertible, IntegerLiteralConvertible {
	case Boolean(Bool)
	case Integer(Int)
	case Real(Double)


	public var type: Type {
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

	public init(booleanLiteral: Bool) {
		self = .Boolean(booleanLiteral)
	}


	// MARK: FloatLiteralConvertible

	public init(floatLiteral: Double) {
		self = .Real(floatLiteral)
	}


	// MARK: IntegerLiteralConvertible

	public init(integerLiteral: Int) {
		self = .Integer(integerLiteral)
	}
}

//  Copyright (c) 2014 Rob Rix. All rights reserved.

public enum Type {
	case Void
	case Integer(Int)
	case Float
	case Double
	indirect case Function([Type], Type)
	indirect case Array(Type, Int)
	case Product([Type])

	static var Boolean: Type {
		return .Integer(1)
	}
}

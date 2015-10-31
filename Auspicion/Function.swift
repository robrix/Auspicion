//  Copyright © 2015 Rob Rix. All rights reserved.

public struct Function {
	public let name: String
	public let parameterTypes: [Type]
	public let returnType: Type

	public var type: Type {
		return .Function(parameterTypes, returnType)
	}

	public init(name: String, parameterTypes: [Type], returnType: Type) {
		self.name = name
		self.parameterTypes = parameterTypes
		self.returnType = returnType
	}
}

//  Copyright (c) 2014 Rob Rix. All rights reserved.

/// A module, i.e. a single unit of compilation.
public struct Module {
	public let name: String
	public let functions: [Function]

	public init(name: String, functions: [Function]) {
		self.name = name
		self.functions = functions
	}
}

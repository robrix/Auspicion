//  Copyright (c) 2014 Rob Rix. All rights reserved.

import llvm

/// A module, i.e. a single unit of compilation.
public final class Module {
	let name: String
	let context: Context

	init(name: String, context: Context) {
		self.name = name
		self.context = context
		self.module = LLVMModuleCreateWithNameInContext(name, context.context)
	}

	deinit {
		LLVMDisposeModule(module)
	}

	private let module: LLVMModule
}

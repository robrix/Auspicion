//  Copyright (c) 2014 Rob Rix. All rights reserved.

import llvm

/// A context to perform compilation within.
public final class Context {
	// MARK: Lifecycle

	init(context: LLVMContextRef) {
		self.context = context
	}

	convenience init() {
		self.init(context: LLVMContextCreate().takeUnretainedValue())
	}

	deinit {
		LLVMContextDispose(self.context)
	}

	internal let context: LLVMContextRef
}

//  Copyright © 2015 Rob Rix. All rights reserved.

public enum Instruction {
	indirect case If(Value, Instruction, Instruction)
	case Return(Value)
}

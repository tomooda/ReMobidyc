Extension { #name : 'RMDDirectionOfMaximumDirectiveNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDDirectionOfMaximumDirectiveNode >> typecheckIn: aRMDInterpreter [

	patchAttributeVariable isPlaceholderNode ifTrue: [
		^ RMDUnresolvedPlaceholderError signal: patchAttributeVariable ].
	self
		typecheck: patchAttributeVariable
		with: RMDType any
		in: aRMDInterpreter.
	^ type := RMDType angle
]

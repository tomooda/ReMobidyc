Extension { #name : 'RMDSimulationDefinitionNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDSimulationDefinitionNode >> evalIn: aRMDInterpreter [
	timeDefinition ifNotNil: [ :def | def evalIn: aRMDInterpreter ].
	patchInitializer ifNotNil: [ :def | def evalIn: aRMDInterpreter ].
	animatInitializers
		ifNotNil: [ :defs | defs do: [ :def | def evalIn: aRMDInterpreter ] ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDSimulationDefinitionNode >> typecheckIn: aRMDInterpreter [
	timeDefinition ifNotNil: [ :def | def typecheckIn: aRMDInterpreter ].
	patchInitializer ifNotNil: [ :def | def typecheckIn: aRMDInterpreter ].
	animatInitializers
		ifNotNil: [ :defs | defs do: [ :def | def typecheckIn: aRMDInterpreter ] ]
]

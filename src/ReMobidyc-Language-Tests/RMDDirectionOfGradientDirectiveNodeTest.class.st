Class {
	#name : 'RMDDirectionOfGradientDirectiveNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'running' }
RMDDirectionOfGradientDirectiveNodeTest >> setUpInterpreter [

	super setUpInterpreter.
	interpreter simulationModel
		load: (RMDGrammar current patchDefinition parse: 'Patch with
	 v [g].');
		load: (RMDGrammar current animatDefinition parse: 'A is Animat.').
	interpreter load: (RMDSimulationDefinitionNode
			 timeDefinition: (RMDSimulationTimeDefinitionNode during: '2[year]' by: '0.5[day]')
			 worldInitializer: RMDWorldInitializerNode empty
			 patchInitializer: (RMDGrammar current patchInitializer parse: '3x3 of 1[m] Patch with
	v = 0 [g]')
			 animatInitializers: { (RMDGrammar current animatInitializer parse: '1 A with
	x = 1.5 [m]
	y = 1.5 [m]') }).
	interpreter load: (RMDActionDefinitionNode name: 'idle').
	interpreter load: (RMDTaskDefinitionNode
			 subjectIdentifier: 'A'
			 verbIdentifier: 'idle'
			 objectIdentifier: nil
			 actionIdentifier: 'idle'
			 nearest: false
			 within: nil
			 enabled: true
			 guard: nil
			 parameterInstantiations: {  }).
	interpreter setupSimulation
]

{ #category : 'tests' }
RMDDirectionOfGradientDirectiveNodeTest >> testEvalIn [

	| node memory a dir |
	node := parser expression end parse: 'direction neighbor''s v'.
	self assert: node isDirectionOfGradientDirectiveNode.
	memory := interpreter memory.
	memory at: memory patch + 7 put: 1.0.
	a := (memory animatsOf: 'A') anyOne.
	interpreter
		withActionContextWith: (RMDActionDefinitionNode name: 'idle')
		subject: a
		definition: (interpreter simulationModel animatDefinitionAt: 'A' ifAbsent: [ nil ])
		taskHash: nil
		do: [ dir := node evalIn: interpreter ].
	self assert: dir closeTo: Float pi * 0.5 precision: 1.03e-3.
	memory at: memory patch + 3 put: 1.0.
	interpreter
		withActionContextWith: (RMDActionDefinitionNode name: 'idle')
		subject: a
		definition: (interpreter simulationModel animatDefinitionAt: 'A' ifAbsent: [ nil ])
		taskHash: nil
		do: [ dir := node evalIn: interpreter ].
	self assert: dir closeTo: Float pi * 0.75 precision: 1.03e-3
]

{ #category : 'tests' }
RMDDirectionOfGradientDirectiveNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'direction neighbor''s x'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node.
	node := parser expression end parse:
		        '(direction neighbor''s x) + (direction neighbor''s y)'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]

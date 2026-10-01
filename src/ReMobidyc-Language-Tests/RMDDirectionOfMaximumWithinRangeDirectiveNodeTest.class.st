Class {
	#name : 'RMDDirectionOfMaximumWithinRangeDirectiveNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'running' }
RMDDirectionOfMaximumWithinRangeDirectiveNodeTest >> setUpInterpreter [

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
	x = 1.9 [m]
	y = 1.1 [m]') }).
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
RMDDirectionOfMaximumWithinRangeDirectiveNodeTest >> testEvalIn [

	| node memory a dir |
	node := parser expression end parse: 'direction maximum v in 0.5 [m] radius'.
	self assert: node isDirectionOfMaximumInRadiusDirectiveNode.
	memory := interpreter memory.
	memory at: memory patch + 2 put: 1.0.
	memory at: memory patch + 6 put: 2.0.
	a := (memory animatsOf: 'A') anyOne.
	interpreter
		withActionContextWith: (RMDActionDefinitionNode name: 'idle')
		subject: a
		definition: (interpreter simulationModel animatDefinitionAt: 'A' ifAbsent: [ nil ])
		taskHash: nil
		do: [ dir := node evalIn: interpreter ].
	self assert: dir closeTo: Float pi * 1.75 precision: 1.03e-3
]

{ #category : 'tests' }
RMDDirectionOfMaximumWithinRangeDirectiveNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'direction maximum x in 2 [km] radius'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node.
	node := parser expression end parse:
		        '(direction maximum x in 0.5 [m] radius) + (direction maximum y in 10 [cm] radius)'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]

Class {
	#name : 'RMDDirectionOfGradientDirectiveNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDDirectionOfGradientDirectiveNodeTest >> setUpInterpreter [

	super setUpInterpreter.
	interpreter simulationModel
		load: (RMDGrammar current patchDefinition parse: 'Patch with
	 v [g].');
		load: (RMDGrammar current animatDefinition parse: 'A is Animat.').
	interpreter load: (RMDSimulationDefinitionNode
			 timeDefinition: (RMDSimulationTimeDefinitionNode during: '2[year]' by: '0.5[day]')
			 worldInitializer: RMDWorldInitializerNode empty
			 patchInitializer: (RMDGrammar current patchInitializer parse: '3x3 of 1[m] Patch with v = 0 [g]')
			 animatInitializers: { (RMDGrammar current animatInitializer parse: '1 A') }).
	interpreter setupSimulation
]

{ #category : 'tests' }
RMDDirectionOfGradientDirectiveNodeTest >> testEvalIn [

	| node memory |
	node := parser expression end parse: 'direction neighbor''s v'.
	self assert: node isDirectionOfGradientDirectiveNode.
	memory := interpreter memory.


	memory at: memory patch + 7 put: 1.0.
	
	self assert: (node evalIn: interpreter) closeTo: Float pi * 0.5 precision: 1.03e-3
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

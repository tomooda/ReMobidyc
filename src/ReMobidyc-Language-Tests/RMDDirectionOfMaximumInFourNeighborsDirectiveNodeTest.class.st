Class {
	#name : 'RMDDirectionOfMaximumInFourNeighborsDirectiveNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDDirectionOfMaximumInFourNeighborsDirectiveNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'direction maximum x among four neighbors'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node.
	node := parser expression end parse:
		        '(direction maximum x among four neighbors) + (direction maximum y among four neighbors)'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]

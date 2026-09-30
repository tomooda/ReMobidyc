Class {
	#name : 'RMDDirectionOfMaximumInFourNeighborsDirectiveNode',
	#superclass : 'RMDDirectionOfMaximumDirectiveNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDDirectionOfMaximumInFourNeighborsDirectiveNode >> isDirectionOfMaximumInFourNeighborsDirectiveNode [

	^ true
]

{ #category : 'printing' }
RMDDirectionOfMaximumInFourNeighborsDirectiveNode >> printOn: aStream [

	aStream
		nextPutAll: 'direction maximum ';
		nextPutAll: self patchAttributeVariable identifier;
		nextPutAll: ' among four neighbors'
]

{ #category : 'printing' }
RMDDirectionOfMaximumInFourNeighborsDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: 'direction maximum ';
		nextPutAll: self patchAttributeVariable identifier;
		nextPutAll: ' among four neighbors'.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ aCollection add: (start to: aStream position) ]
]

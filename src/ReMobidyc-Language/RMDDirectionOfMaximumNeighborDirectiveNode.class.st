Class {
	#name : 'RMDDirectionOfMaximumNeighborDirectiveNode',
	#superclass : 'RMDDirectionOfMaximumDirectiveNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDDirectionOfMaximumNeighborDirectiveNode >> isDirectionOfMaximumNeighborDirectiveNode [

	^ true
]

{ #category : 'printing' }
RMDDirectionOfMaximumNeighborDirectiveNode >> printOn: aStream [

	aStream
		nextPutAll: 'direction maximum ';
		nextPutAll: self patchAttributeVariable identifier;
		nextPutAll: ' neighbor'
]

{ #category : 'printing' }
RMDDirectionOfMaximumNeighborDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: 'direction maximum ';
		nextPutAll: self patchAttributeVariable identifier;
		nextPutAll: ' neighbor'.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ aCollection add: (start to: aStream position) ]
]

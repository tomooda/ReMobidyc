Class {
	#name : 'RMDDirectionOfMaximumInEightNeighborsDirectiveNode',
	#superclass : 'RMDDirectionOfMaximumDirectiveNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDDirectionOfMaximumInEightNeighborsDirectiveNode >> isDirectionOfMaximumInEightNeighborsDirectiveNode [

	^ true
]

{ #category : 'printing' }
RMDDirectionOfMaximumInEightNeighborsDirectiveNode >> printOn: aStream [

	aStream
		nextPutAll: 'direction maximum ';
		nextPutAll: self patchAttributeVariable identifier;
		nextPutAll: ' among eight neighbors'
]

{ #category : 'printing' }
RMDDirectionOfMaximumInEightNeighborsDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: 'direction maximum ';
		nextPutAll: self patchAttributeVariable identifier;
		nextPutAll: ' among eight neighbors'.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ aCollection add: (start to: aStream position) ]
]

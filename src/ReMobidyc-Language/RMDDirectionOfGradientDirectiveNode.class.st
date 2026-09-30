Class {
	#name : 'RMDDirectionOfGradientDirectiveNode',
	#superclass : 'RMDDirectionOfMaximumDirectiveNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'converting' }
RMDDirectionOfGradientDirectiveNode >> asPresenter [

	^ RMDDirectionOfGradientDirectivePresenter on: self
]

{ #category : 'testing' }
RMDDirectionOfGradientDirectiveNode >> isDirectionOfGradientDirectiveNode [

	^ true
]

{ #category : 'printing' }
RMDDirectionOfGradientDirectiveNode >> printOn: aStream [

	aStream
		nextPutAll: 'direction neighbor''s ';
		nextPutAll: patchAttributeVariable identifier
]

{ #category : 'printing' }
RMDDirectionOfGradientDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: 'direction neighbor''s ';
		nextPutAll: patchAttributeVariable identifier.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

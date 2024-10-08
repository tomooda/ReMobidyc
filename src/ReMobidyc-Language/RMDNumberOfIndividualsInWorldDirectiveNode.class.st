Class {
	#name : 'RMDNumberOfIndividualsInWorldDirectiveNode',
	#superclass : 'RMDIndividualsInWorldDirectiveNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'accessing' }
RMDNumberOfIndividualsInWorldDirectiveNode >> directiveName [

	^ 'number of'
]

{ #category : 'testing' }
RMDNumberOfIndividualsInWorldDirectiveNode >> isNumberOfIndividualsInWorldDirective [

	^ true
]

{ #category : 'printing' }
RMDNumberOfIndividualsInWorldDirectiveNode >> printOn: aStream [

	aStream
		nextPutAll: 'number of ';
		nextPutAll: animatName;
		nextPutAll: ' in world'
]

{ #category : 'printing' }
RMDNumberOfIndividualsInWorldDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	self printOn: aStream.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

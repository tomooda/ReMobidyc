Class {
	#name : 'RMDDirectionOfMaximumInRadiusDirectiveNode',
	#superclass : 'RMDDirectionOfMaximumDirectiveNode',
	#instVars : [
		'radius'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDDirectionOfMaximumInRadiusDirectiveNode class >> variable: aRMDAttributeVariableNodeOrRMDPlaceholderNode radius: aRMDExpression [

	^ self new
		  patchAttributeVariable: aRMDAttributeVariableNodeOrRMDPlaceholderNode;
		  radius: aRMDExpression;
		  yourself
]

{ #category : 'comparing' }
RMDDirectionOfMaximumInRadiusDirectiveNode >> = anObject [

	^ self class = anObject class and: [ radius = anObject radius ]
]

{ #category : 'enumerating' }
RMDDirectionOfMaximumInRadiusDirectiveNode >> childrenDo: aBlock [

	super childrenDo: aBlock.
	aBlock value: radius
]

{ #category : 'comparing' }
RMDDirectionOfMaximumInRadiusDirectiveNode >> hash [

	^ self class hash bitXor: radius hash
]

{ #category : 'testing' }
RMDDirectionOfMaximumInRadiusDirectiveNode >> isDirectionOfMaximumInRadiusDirectiveNode [

	^ true
]

{ #category : 'copying' }
RMDDirectionOfMaximumInRadiusDirectiveNode >> postCopy [

	super postCopy.
	radius := radius copy
]

{ #category : 'printing' }
RMDDirectionOfMaximumInRadiusDirectiveNode >> printOn: aStream [

	aStream
		nextPutAll: 'direction maximum ';
		nextPutAll: self patchAttributeVariable identifier;
		nextPutAll: ' in '.
	radius printOn: aStream.
	aStream nextPutAll: ' radius'
]

{ #category : 'printing' }
RMDDirectionOfMaximumInRadiusDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: 'direction maximum ';
		nextPutAll: self patchAttributeVariable identifier;
		nextPutAll: ' in '.
	radius printOn: aStream.
	aStream nextPutAll: ' radius'.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ aCollection add: (start to: aStream position) ]
]

{ #category : 'accessing' }
RMDDirectionOfMaximumInRadiusDirectiveNode >> radius [

	^ radius
]

{ #category : 'accessing' }
RMDDirectionOfMaximumInRadiusDirectiveNode >> radius: aRMDExpression [

	radius := aRMDExpression
]

{ #category : 'rewriting' }
RMDDirectionOfMaximumInRadiusDirectiveNode >> replaceChildren: aDictionary [

	super replaceChildren: aDictionary.
	radius := radius copyReplace: aDictionary
]

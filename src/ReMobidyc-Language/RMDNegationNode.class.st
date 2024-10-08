Class {
	#name : 'RMDNegationNode',
	#superclass : 'RMDConditionNode',
	#instVars : [
		'condition'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDNegationNode class >> condition: aRMDConditionNode [
	^ self new
		condition: aRMDConditionNode;
		yourself
]

{ #category : 'comparing' }
RMDNegationNode >> = anObject [
	^ self class = anObject class and: [ condition = anObject condition ]
]

{ #category : 'converting' }
RMDNegationNode >> asPresenter [

	^ RMDNegationPresenter on: self
]

{ #category : 'enumerating' }
RMDNegationNode >> childrenDo: aBlock [
	aBlock value: condition
]

{ #category : 'enumerating' }
RMDNegationNode >> childrenTransform: aBlock [

	condition := aBlock value: condition
]

{ #category : 'accessing' }
RMDNegationNode >> condition [
	^ condition
]

{ #category : 'accessing' }
RMDNegationNode >> condition: aRMDConditionNode [
	condition := aRMDConditionNode
]

{ #category : 'comparing' }
RMDNegationNode >> hash [
	^ self class hash bitXor: condition hash
]

{ #category : 'testing' }
RMDNegationNode >> isNegationNode [
	^ true
]

{ #category : 'copying' }
RMDNegationNode >> postCopy [
	condition := condition copy
]

{ #category : 'accessing' }
RMDNegationNode >> precedence [
	^ 1
]

{ #category : 'printing' }
RMDNegationNode >> printOn: aStream [
	aStream nextPutAll: 'not '.
	self precedence <= condition precedence
		ifFalse: [ aStream nextPut: $( ].
	condition printOn: aStream.
	self precedence <= condition precedence
		ifFalse: [ aStream nextPut: $) ]
]

{ #category : 'printing' }
RMDNegationNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'not '.
	self precedence <= condition precedence
		ifFalse: [ aStream nextPut: $( ].
	condition
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	self precedence <= condition precedence
		ifFalse: [ aStream nextPut: $) ].
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]

{ #category : 'rewriting' }
RMDNegationNode >> replaceChildren: aDictionary [
	condition := condition copyReplace: aDictionary
]

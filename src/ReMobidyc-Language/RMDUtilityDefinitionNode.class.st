Class {
	#name : #RMDUtilityDefinitionNode,
	#superclass : #RMDDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDUtilityDefinitionNode >> isUtilityDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDUtilityDefinitionNode >> operator [
	^ '='
]

{ #category : #printing }
RMDUtilityDefinitionNode >> printOn: aStream [
	variable printOn: aStream.
	aStream
		nextPut: Character space;
		nextPutAll: self operator;
		nextPut: Character space.
	definitionBody printOn: aStream
]

{ #category : #printing }
RMDUtilityDefinitionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	variable
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream
		nextPut: Character space;
		nextPutAll: self operator;
		nextPut: Character space.
	definitionBody
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]

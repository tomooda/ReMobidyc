Class {
	#name : #RMDDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'variable',
		'definitionBody'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDDefinitionNode class >> variable: aRMDVariableNode expression: aRMDExpressionNode [
	^ self new
		variable: aRMDVariableNode;
		definitionBody: aRMDExpressionNode;
		yourself
]

{ #category : #comparing }
RMDDefinitionNode >> = anObject [
	^ self class = anObject class
		and: [ variable = anObject variable
				and: [ definitionBody = anObject definitionBody ] ]
]

{ #category : #accessing }
RMDDefinitionNode >> definitionBody [
	^ definitionBody
]

{ #category : #accessing }
RMDDefinitionNode >> definitionBody: aRMDExpressionNode [
	definitionBody := aRMDExpressionNode
]

{ #category : #comparing }
RMDDefinitionNode >> hash [
	^ (self class hash bitXor: variable hash) bitXor: definitionBody hash
]

{ #category : #accessing }
RMDDefinitionNode >> operator [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDDefinitionNode >> variable [
	^ variable
]

{ #category : #accessing }
RMDDefinitionNode >> variable: aRMDVariableNode [
	variable := aRMDVariableNode
]
Class {
	#name : #RMDSyntaxNode,
	#superclass : #Object,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDSyntaxNode >> isAdditionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAgentDirectiveNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAgentReferenceNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAnimatDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isApplyNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isBinaryRelationNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isConjunctionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isDeltaVariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isDifferential2VariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isDifferentialVariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isDisjunctionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isEqualityNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isExpressionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isFractionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isGreaterOrEqualNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isGreaterThanNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isGuardedChoiceNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isLessOrEqualNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isLessThanNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isLiteralNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isNegationNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isNextVariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isNotEqualNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isOldNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPowerNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isProductNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPropertyAdditiveDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPropertyDeclarationNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPropertyDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPropertyProductiveDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isScriptNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isSubtractionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isUnaryMinusNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isUniformDistributionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isUtilityDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isUtilityVariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isVariableNode [
	^ false
]

{ #category : #printing }
RMDSyntaxNode >> printOn: aStream [
	^ self subclassResponsibility
]
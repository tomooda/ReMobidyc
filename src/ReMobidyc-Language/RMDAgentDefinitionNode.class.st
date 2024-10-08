Class {
	#name : 'RMDAgentDefinitionNode',
	#superclass : 'RMDSyntaxNode',
	#instVars : [
		'attributeDeclarations',
		'attributeOffsets',
		'utilityDefinitions',
		'dataSource'
	],
	#classInstVars : [
		'builtinAttributes'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDAgentDefinitionNode class >> attributeDeclarations: anArrayOfRMDAttributeDeclarationNode utilityDefinitions: anArrayOfRMDUtilityDefinitionNode [

	^ self new
		  attributeDeclarations: anArrayOfRMDAttributeDeclarationNode;
		  utilityDefinitions: anArrayOfRMDUtilityDefinitionNode;
		  yourself
]

{ #category : 'accessing' }
RMDAgentDefinitionNode class >> builtinAttributes [
	^ builtinAttributes
		ifNil: [ builtinAttributes := self createBuiltinAttributes ]
]

{ #category : 'accessing' }
RMDAgentDefinitionNode class >> createBuiltinAttributes [
	^ self subclassResponsibility
]

{ #category : 'instance creation' }
RMDAgentDefinitionNode class >> empty [

	^ self attributeDeclarations: Array new utilityDefinitions: Array new
]

{ #category : 'accessing' }
RMDAgentDefinitionNode class >> flushBuiltinAttributes [

	<script:
	'RMDAgentDefinitionNode allSubclassesDo: [:c | c flushBuiltinAttributes ]'>
	builtinAttributes := nil
]

{ #category : 'testing' }
RMDAgentDefinitionNode class >> isAbstract [

	^ self == RMDAgentDefinitionNode
]

{ #category : 'comparing' }
RMDAgentDefinitionNode >> = anObject [

	^ self class = anObject class and: [ 
		  attributeDeclarations = anObject attributeDeclarations and: [ 
			  utilityDefinitions = anObject utilityDefinitions ] ]
]

{ #category : 'accessing' }
RMDAgentDefinitionNode >> agentName [

	^ self name
]

{ #category : 'accessing' }
RMDAgentDefinitionNode >> allAttributeDeclarations [
	^ (self builtinAttributes
		collect:
			[ :assoc | RMDAttributeDeclarationNode identifier: assoc key unit: assoc value ])
		, self attributeDeclarations
]

{ #category : 'enumerating' }
RMDAgentDefinitionNode >> allAttributeDeclarationsDo: aBlock [

	self builtinAttributes do: [ :assoc | 
		aBlock value:
			(RMDAttributeDeclarationNode
				 identifier: assoc key
				 unit: assoc value) ].
	self attributeDeclarations do: aBlock
]

{ #category : 'utilities' }
RMDAgentDefinitionNode >> asDictionary: anInteger in: aRMDMemory [
	^ (self attributeOffsets associations
		collect: [ :assoc | 
			assoc key
				-> (aRMDMemory at: anInteger + assoc value ifAbsent: [ nil ]) ])
		asDictionary
]

{ #category : 'accessing' }
RMDAgentDefinitionNode >> attributeDeclarationAt: aString ifAbsent: errorBlock [

	self allAttributeDeclarationsDo: [ :decl |
		decl identifier = aString ifTrue: [ ^ decl ] ].
	^ errorBlock value
]

{ #category : 'accessing' }
RMDAgentDefinitionNode >> attributeDeclarations [
	^ attributeDeclarations
]

{ #category : 'accessing' }
RMDAgentDefinitionNode >> attributeDeclarations: anArrayOfAttributeDeclaration [
	attributeDeclarations := anArrayOfAttributeDeclaration.
	attributeOffsets := nil
]

{ #category : 'enumerating' }
RMDAgentDefinitionNode >> attributeDeclarationsDo: aBlock [
	attributeDeclarations do: aBlock
]

{ #category : 'enumerating' }
RMDAgentDefinitionNode >> attributeIdentifiersDo: aBlock [
	attributeDeclarations
		do: [ :attribute | aBlock value: attribute identifier ]
]

{ #category : 'accessing' }
RMDAgentDefinitionNode >> attributeOffsetAt: aString ifAbsent: errorBlock [
	^ self attributeOffsets at: aString ifAbsent: errorBlock
]

{ #category : 'accessing' }
RMDAgentDefinitionNode >> attributeOffsets [
	^ attributeOffsets
		ifNil: [ | offset |
			attributeOffsets := Dictionary new.
			offset := -1.
			self builtinAttributes
				do: [ :assoc | attributeOffsets at: assoc key put: (offset := offset + 1) ].
			attributeDeclarations
				do: [ :declaration | 
					attributeOffsets
						at: declaration identifier
						ifAbsentPut: [ offset := offset + 1 ] ].
			attributeOffsets ]
]

{ #category : 'enumerating' }
RMDAgentDefinitionNode >> attributeOffsetsDo: aBlock [
	self attributeOffsets keysAndValuesDo: aBlock
]

{ #category : 'enumerating' }
RMDAgentDefinitionNode >> attributeUnitsDo: aBlock [
	self builtinAttributes
		do: [ :assoc | aBlock value: assoc key value: assoc value ].
	self
		attributeDeclarationsDo: [ :decl | aBlock value: decl identifier value: decl unit ]
]

{ #category : 'accessing' }
RMDAgentDefinitionNode >> builtinAttributes [
	^ self class builtinAttributes
]

{ #category : 'enumerating' }
RMDAgentDefinitionNode >> childrenDo: aBlock [

	attributeDeclarations do: aBlock.
	utilityDefinitions do: aBlock
]

{ #category : 'enumerating' }
RMDAgentDefinitionNode >> childrenTransform: aBlock [

	attributeDeclarations := attributeDeclarations collect: aBlock.
	utilityDefinitions := utilityDefinitions collect: aBlock
]

{ #category : 'accessing' }
RMDAgentDefinitionNode >> complementUtilityDefinitions [

	| boundUtils freeUtils |
	boundUtils := (utilityDefinitions collect: [ :util | 
		               util variable identifier ]) asSet.
	freeUtils := OrderedCollection new.
	attributeDeclarations do: [ :attributeDecl | 
		attributeDecl nodesSuchThat: #isUtilityVariableNode do: [ :util | 
			| identifier |
			identifier := util identifier.
			((boundUtils includes: identifier) or: [ 
				 freeUtils includes: identifier ]) ifFalse: [ 
				freeUtils add: identifier ] ] ].
	utilityDefinitions do: [ :utilityDefinition | 
		utilityDefinition
			nodesSuchThat: #isUtilityVariableNode
			do: [ :util | 
				| identifier |
				identifier := util identifier.
				((boundUtils includes: identifier) or: [ 
					 freeUtils includes: identifier ]) ifFalse: [ 
					freeUtils add: identifier ] ] ].
	utilityDefinitions := utilityDefinitions
	                      , (freeUtils collect: [ :identifier | 
			                       RMDUtilityDefinitionNode
				                       variable:
				                       (RMDUtilityVariableNode identifier:
					                        identifier)
				                       expression: RMDLiteralNode zero ])
]

{ #category : 'accessing' }
RMDAgentDefinitionNode >> dataSource [

	^ dataSource
]

{ #category : 'accessing' }
RMDAgentDefinitionNode >> dataSource: aRMDDataSource [

	dataSource := aRMDDataSource
]

{ #category : 'accessing' }
RMDAgentDefinitionNode >> fullName [

	^ self subclassResponsibility
]

{ #category : 'comparing' }
RMDAgentDefinitionNode >> hash [

	^ (self class hash bitXor: attributeDeclarations hash) bitXor:
		  utilityDefinitions hash
]

{ #category : 'testing' }
RMDAgentDefinitionNode >> isAgentDefinitionNode [
	^ true
]

{ #category : 'testing' }
RMDAgentDefinitionNode >> isCorrectSyntax [

	^ (RMDGrammar current agentDefinition end parse: self printString)
	  = self
]

{ #category : 'accessing' }
RMDAgentDefinitionNode >> name [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
RMDAgentDefinitionNode >> offsetAt: aString ifAbsent: errorBlock [

	^ self attributeOffsets at: aString ifAbsent: errorBlock
]

{ #category : 'copying' }
RMDAgentDefinitionNode >> postCopy [

	attributeDeclarations := attributeDeclarations collect: #copy.
	attributeOffsets := nil.
	utilityDefinitions := utilityDefinitions collect: #copy
]

{ #category : 'printing' }
RMDAgentDefinitionNode >> printShortOn: aStream [

	aStream nextPutAll: self agentName
]

{ #category : 'rewriting' }
RMDAgentDefinitionNode >> replaceChildren: aDictionary [

	attributeDeclarations := attributeDeclarations collect: [ :node | 
		                         node copyReplace: aDictionary ].
	attributeOffsets := nil.
	utilityDefinitions := utilityDefinitions collect: [ :node | 
		                      node copyReplace: aDictionary ]
]

{ #category : 'accessing' }
RMDAgentDefinitionNode >> totalNumberOfAttributes [
	^ self builtinAttributes size + attributeDeclarations size
]

{ #category : 'enumerating' }
RMDAgentDefinitionNode >> unitOfAttribute: aString ifAbsent: errorBlock [

	self attributeUnitsDo: [ :identifier :unit | 
		aString = identifier ifTrue: [ ^ unit ] ].
	^ errorBlock value
]

{ #category : 'accessing' }
RMDAgentDefinitionNode >> utilityDefinitions [

	^ utilityDefinitions
]

{ #category : 'accessing' }
RMDAgentDefinitionNode >> utilityDefinitions: anArrayOfRMDUtilityDefinitionNode [

	utilityDefinitions := anArrayOfRMDUtilityDefinitionNode
]

{ #category : 'enumerating' }
RMDAgentDefinitionNode >> utilityDefinitionsDo: aBlock [

	utilityDefinitions do: aBlock
]

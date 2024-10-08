Class {
	#name : 'RMDPatchInitializerNode',
	#superclass : 'RMDAgentInitializerNode',
	#instVars : [
		'xDivisions',
		'yDivisions',
		'size',
		'length'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDPatchInitializerNode class >> empty [
	^ self
		xDivisions: 1
		yDivisions: 1
		length: '1 [m]' asRMDExpression
		patchAttributeInitializers: Array new
		utilityDefinitions: Array new
]

{ #category : 'typical instances' }
RMDPatchInitializerNode class >> grassInitializer: xDivisions by: yDivisions of: lengthString grass: minString to: maxString [
	<script:
		'(RMDPatchInitializerNode grassInitializer: 10 by: 10 of: ''1[km]'' grass: ''5000[kcal]'' to: ''10000[kcal]'') inspect'>
	^ RMDGrammar current patchInitializer end
		parse:
			(String
				streamContents: [ :stream | 
					xDivisions printOn: stream.
					stream nextPutAll: 'x'.
					yDivisions printOn: stream.
					stream
						nextPutAll: ' of ';
						nextPutAll: lengthString;
						nextPutAll: ' Patch with';
						cr;
						nextPutAll: '    grass = uniform ';
						nextPutAll: minString;
						nextPutAll: ' to ';
						nextPutAll: maxString ])
]

{ #category : 'instance creation' }
RMDPatchInitializerNode class >> xDivisions: aRMDExpression1 yDivisions: aRMDExpression2 length: aRMDExpression3 patchAttributeInitializers: anArrayOfRMDSimulationPatchAttributeDefinitions utilityDefinitions: aRMDUtilityDefinitionNode [

	^ self new
		  xDivisions: aRMDExpression1;
		  yDivisions: aRMDExpression2;
		  size: aRMDExpression3;
		  attributeInitializers:
			  anArrayOfRMDSimulationPatchAttributeDefinitions;
		  utilityDefinitions: aRMDUtilityDefinitionNode;
		  yourself
]

{ #category : 'comparing' }
RMDPatchInitializerNode >> = anObject [
	^ self class = anObject class
		and: [ xDivisions = anObject xDivisions
				and:
					[ yDivisions = anObject yDivisions and: [ size = anObject size ] ] ]
]

{ #category : 'accessing' }
RMDPatchInitializerNode >> agentName [

	^ 'Patch'
]

{ #category : 'enumerating' }
RMDPatchInitializerNode >> childrenDo: aBlock [

	size ifNotNil: [ aBlock value: size ].
	super childrenDo: aBlock
]

{ #category : 'enumerating' }
RMDPatchInitializerNode >> childrenTransform: aBlock [

	size ifNotNil: [ size := aBlock value: size ].
	super childrenTransform: aBlock
]

{ #category : 'comparing' }
RMDPatchInitializerNode >> hash [
	^ (((super hash bitXor: xDivisions hash) bitXor: yDivisions hash)
		bitXor: size hash) bitXor: length hash
]

{ #category : 'testing' }
RMDPatchInitializerNode >> isCorrectSyntax [

	^ (RMDGrammar current patchInitializer end parse: self printString)
	  = self
]

{ #category : 'testing' }
RMDPatchInitializerNode >> isPatchInitializerNode [
	^ true
]

{ #category : 'accessing' }
RMDPatchInitializerNode >> length [
	^ length
		ifNil: [ length := size unit siUnit = RMDUnit m
				ifTrue: [ size numeric ]
				ifFalse: [ size unit siUnit = RMDUnit m2
						ifTrue: [ size numeric sqrt ]
						ifFalse: [ nil ] ] ]
]

{ #category : 'copying' }
RMDPatchInitializerNode >> postCopy [
	super postCopy.
	size := size copy
]

{ #category : 'printing' }
RMDPatchInitializerNode >> printOn: aStream [

	xDivisions printOn: aStream.
	aStream nextPutAll: ' x '.
	yDivisions printOn: aStream.
	aStream nextPutAll: ' of '.
	size printOn: aStream.
	aStream nextPutAll: ' Patch'.
	attributeInitializers ifNotEmpty: [ 
		aStream
			nextPutAll: ' with';
			nextPut: Character cr.
		attributeInitializers
			do: [ :init | 
				aStream nextPutAll: '    '.
				init printOn: aStream ]
			separatedBy: [ aStream nextPut: Character cr ] ].
	utilityDefinitions ifNotEmpty: [ 
		aStream
			nextPut: Character cr;
			nextPutAll: 'where';
			nextPut: Character cr.
		utilityDefinitions
			do: [ :def | 
				aStream nextPutAll: '    '.
				def printOn: aStream ]
			separatedBy: [ aStream nextPut: Character cr ] ]
]

{ #category : 'printing' }
RMDPatchInitializerNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	xDivisions
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPutAll: ' x '.
	yDivisions
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPutAll: ' of '.
	size
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPutAll: ' Patch'.
	attributeInitializers ifNotEmpty: [ 
		aStream
			nextPutAll: ' with';
			nextPut: Character cr.
		attributeInitializers
			do: [ :init | 
				aStream nextPutAll: '    '.
				init
					printOn: aStream
					ifIncludedIn: aCollectionOfRMDSyntaxNode
					addSectionTo: aCollection ]
			separatedBy: [ aStream nextPut: Character cr ] ].
	utilityDefinitions ifNotEmpty: [ 
		aStream
			nextPut: Character cr;
			nextPutAll: 'where';
			nextPut: Character cr.
		utilityDefinitions
			do: [ :def | 
				aStream nextPutAll: '    '.
				def
					printOn: aStream
					ifIncludedIn: aCollectionOfRMDSyntaxNode
					addSectionTo: aCollection ]
			separatedBy: [ aStream nextPut: Character cr ] ].
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : 'rewriting' }
RMDPatchInitializerNode >> replaceChildren: aDictionary [
	super replaceChildren: aDictionary.
	aDictionary at: size ifPresent: [ :node | size := node copy ].
	length := nil
]

{ #category : 'accessing' }
RMDPatchInitializerNode >> size [
	^ size
]

{ #category : 'accessing' }
RMDPatchInitializerNode >> size: aRMDLiteralNode [
	size := aRMDLiteralNode.
	length := nil
]

{ #category : 'accessing' }
RMDPatchInitializerNode >> xDivisions [
	^ xDivisions
]

{ #category : 'accessing' }
RMDPatchInitializerNode >> xDivisions: anInteger [
	xDivisions := anInteger
]

{ #category : 'accessing' }
RMDPatchInitializerNode >> yDivisions [
	^ yDivisions
]

{ #category : 'accessing' }
RMDPatchInitializerNode >> yDivisions: anInteger [
	yDivisions := anInteger
]

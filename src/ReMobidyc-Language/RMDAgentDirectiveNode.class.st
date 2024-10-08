Class {
	#name : 'RMDAgentDirectiveNode',
	#superclass : 'RMDDirectiveNode',
	#instVars : [
		'agentIdentifier'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDAgentDirectiveNode class >> directive: aString agent: anotherString [
	^ self new
		directive: aString;
		agentIdentifier: anotherString;
		yourself
]

{ #category : 'testing' }
RMDAgentDirectiveNode class >> isAbstract [

	^ self = RMDAgentDirectiveNode 
]

{ #category : 'comparing' }
RMDAgentDirectiveNode >> = anObject [

	^ self class = anObject class and: [ 
		  agentIdentifier = anObject agentIdentifier ]
]

{ #category : 'accessing' }
RMDAgentDirectiveNode >> agentIdentifier [
	^ agentIdentifier
]

{ #category : 'accessing' }
RMDAgentDirectiveNode >> agentIdentifier: aString [
	agentIdentifier := aString
]

{ #category : 'converting' }
RMDAgentDirectiveNode >> asPresenter [

	^ RMDAgentDirectivePresenter on: self
]

{ #category : 'enumerating' }
RMDAgentDirectiveNode >> childrenDo: aBlock [
	
]

{ #category : 'accessing' }
RMDAgentDirectiveNode >> directiveName [

	^ self subclassResponsibility
]

{ #category : 'comparing' }
RMDAgentDirectiveNode >> hash [
	^ self class hash bitXor: agentIdentifier hash
]

{ #category : 'testing' }
RMDAgentDirectiveNode >> isAgentDirectiveNode [
	^ true
]

{ #category : 'copying' }
RMDAgentDirectiveNode >> postCopy [
	
]

{ #category : 'rewriting' }
RMDAgentDirectiveNode >> renameAnimat: aString to: anotherString [

	agentIdentifier = aString ifTrue: [ agentIdentifier := anotherString ].
	super renameAnimat: aString to: anotherString
]

{ #category : 'rewriting' }
RMDAgentDirectiveNode >> replaceChildren: aDictionary [
	aDictionary
		at: agentIdentifier
		ifPresent: [ :node | agentIdentifier := node copy ]
]

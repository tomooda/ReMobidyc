Class {
	#name : 'RMDDirectionOfMaximumDirectiveNode',
	#superclass : 'RMDPatchDirectiveNode',
	#instVars : [
		'patchAttributeVariable'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDDirectionOfMaximumDirectiveNode class >> isAbstract [

	^ self == RMDDirectionOfMaximumDirectiveNode
]

{ #category : 'instance creation' }
RMDDirectionOfMaximumDirectiveNode class >> variable: aRMDAttributeVariableNodeOrRMDPlaceholderNode [

	^ self new
		  patchAttributeVariable:
			  aRMDAttributeVariableNodeOrRMDPlaceholderNode;
		  yourself
]

{ #category : 'comparing' }
RMDDirectionOfMaximumDirectiveNode >> = anObject [

	^ self class = anObject class and: [ 
		  patchAttributeVariable = anObject patchAttributeVariable ]
]

{ #category : 'enumerating' }
RMDDirectionOfMaximumDirectiveNode >> childrenDo: aBlock [

	aBlock value: patchAttributeVariable
]

{ #category : 'comparing' }
RMDDirectionOfMaximumDirectiveNode >> hash [
	^ self class hash bitXor: patchAttributeVariable hash
]

{ #category : 'accessing' }
RMDDirectionOfMaximumDirectiveNode >> patchAttributeVariable [

	^ patchAttributeVariable
]

{ #category : 'accessing' }
RMDDirectionOfMaximumDirectiveNode >> patchAttributeVariable: aRMDAttributeVariableNodeOrRMDPlaceholderNode [

	patchAttributeVariable := aRMDAttributeVariableNodeOrRMDPlaceholderNode
]

{ #category : 'copying' }
RMDDirectionOfMaximumDirectiveNode >> postCopy [

	patchAttributeVariable := patchAttributeVariable copy
]

{ #category : 'rewriting' }
RMDDirectionOfMaximumDirectiveNode >> replaceChildren: aDictionary [
	aDictionary
		at: patchAttributeVariable 
		ifPresent: [ :node | patchAttributeVariable := node copy ]
]

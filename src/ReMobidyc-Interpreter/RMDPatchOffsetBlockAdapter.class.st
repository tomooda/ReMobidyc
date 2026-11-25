Class {
	#name : 'RMDPatchOffsetBlockAdapter',
	#superclass : 'Object',
	#instVars : [
		'patch',
		'block'
	],
	#category : 'ReMobidyc-Interpreter-Utilities',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Utilities'
}

{ #category : 'instance creation' }
RMDPatchOffsetBlockAdapter class >> patch: anInteger block: aBlock [

	^ self new
		  patch: anInteger;
		  block: aBlock;
		  yourself
]

{ #category : 'accessing' }
RMDPatchOffsetBlockAdapter >> block: aBlock [

	block := aBlock
]

{ #category : 'accessing' }
RMDPatchOffsetBlockAdapter >> patch: anInteger [

	patch := anInteger
]

{ #category : 'evaluating' }
RMDPatchOffsetBlockAdapter >> value: anInteger [

	^ block value: patch + anInteger
]

{ #category : 'evaluating' }
RMDPatchOffsetBlockAdapter >> value: anInteger value: aNumber [

	^ block value: patch + anInteger value: aNumber
]

{ #category : 'evaluating' }
RMDPatchOffsetBlockAdapter >> value: anInteger value: aNumber value: anotherNumber [

	^ block value: patch + anInteger value: aNumber value: anotherNumber
]

{ #category : 'evaluating' }
RMDPatchOffsetBlockAdapter >> value: anInteger value: aNumber value: anotherNumber value: yetAnotherNumber [

	^ block
		  value: patch + anInteger
		  value: aNumber
		  value: anotherNumber
		  value: yetAnotherNumber
]

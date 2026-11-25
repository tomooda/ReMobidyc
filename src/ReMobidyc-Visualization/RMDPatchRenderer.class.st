Class {
	#name : 'RMDPatchRenderer',
	#superclass : 'RMDRenderer',
	#instVars : [
		'borderWidth',
		'borderColor',
		'patchLength'
	],
	#category : 'ReMobidyc-Visualization',
	#package : 'ReMobidyc-Visualization'
}

{ #category : 'testing' }
RMDPatchRenderer class >> isAbstract [

	^ self == RMDPatchRenderer
]

{ #category : 'comparing' }
RMDPatchRenderer >> = anObject [

	^ super = anObject and: [ 
		  borderWidth = anObject borderWidth and: [ 
			  borderColor = anObject borderColor ] ]
]

{ #category : 'accessing' }
RMDPatchRenderer >> borderColor [
	^ borderColor
]

{ #category : 'accessing' }
RMDPatchRenderer >> borderColor: aColor [
	borderColor := aColor
]

{ #category : 'accessing' }
RMDPatchRenderer >> borderWidth [
	^ borderWidth
]

{ #category : 'accessing' }
RMDPatchRenderer >> borderWidth: anInteger [
	borderWidth := anInteger
]

{ #category : 'defaults' }
RMDPatchRenderer >> defaultBorderColor [
	^ Color black
]

{ #category : 'defaults' }
RMDPatchRenderer >> defaultBorderWidth [
	^ 2
]

{ #category : 'defaults' }
RMDPatchRenderer >> defaultColor [
	^ Color white
]

{ #category : 'comparing' }
RMDPatchRenderer >> hash [

	^ (super hash bitXor: borderWidth hash) bitXor: borderColor hash
]

{ #category : 'initialization' }
RMDPatchRenderer >> initialize [
	super initialize.
	borderColor := self defaultBorderColor.
	borderWidth := self defaultBorderWidth
]

{ #category : 'initialization' }
RMDPatchRenderer >> initializeWith: aRMDInterpreter [

	super initializeWith: aRMDInterpreter.
	patchLength := aRMDInterpreter patchLength
]

{ #category : 'testing' }
RMDPatchRenderer >> isPatchRenderer [
	^ true
]

{ #category : 'drawing' }
RMDPatchRenderer >> renderOn: aRMDVisualization [

	aRMDVisualization interpreter patchesDo: [ :patch | self renderPatch: patch on: aRMDVisualization ].
	aRMDVisualization drawPatchGridWidth: self borderWidth color: self borderColor
]

{ #category : 'drawing' }
RMDPatchRenderer >> renderPatch: anInteger on: aRMDVisualization [

	^ self subclassResponsibility
]

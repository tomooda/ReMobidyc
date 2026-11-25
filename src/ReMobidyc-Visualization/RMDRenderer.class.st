Class {
	#name : 'RMDRenderer',
	#superclass : 'Object',
	#instVars : [
		'color'
	],
	#category : 'ReMobidyc-Visualization',
	#package : 'ReMobidyc-Visualization'
}

{ #category : 'testing' }
RMDRenderer class >> isAbstract [

	^ self == RMDRenderer
]

{ #category : 'comparing' }
RMDRenderer >> = anObject [
	^ self class = anObject class and: [ color = anObject color ]
]

{ #category : 'accessing' }
RMDRenderer >> color [
	^ color ifNil: [ color := self defaultColor ]
]

{ #category : 'accessing' }
RMDRenderer >> color: aColor [
	color := aColor
]

{ #category : 'defaults' }
RMDRenderer >> defaultColor [
	^ Color yellow
]

{ #category : 'comparing' }
RMDRenderer >> hash [

	^ self class hash bitXor: color hash
]

{ #category : 'enumerating' }
RMDRenderer >> iconNamesDo: aBlock [
]

{ #category : 'initialization' }
RMDRenderer >> initialize [
	super initialize.
	color := self defaultColor
]

{ #category : 'initialization' }
RMDRenderer >> initializeWith: aRMDInterpreter [
]

{ #category : 'testing' }
RMDRenderer >> isAnimatRendererFor: aString [
	^ false
]

{ #category : 'testing' }
RMDRenderer >> isPatchRenderer [
	^ false
]

{ #category : 'testing' }
RMDRenderer >> isWorldRenderer [
	^ false
]

{ #category : 'accessing' }
RMDRenderer >> name [
	^ self subclassResponsibility 
]

{ #category : 'private' }
RMDRenderer >> pointFromX: modelX y: modelY interpreter: aRMDInterpreter scale: scale [

	| patchLength |
	patchLength := aRMDInterpreter patchLength.
	^ modelX / patchLength * scale
	  @ (aRMDInterpreter simulationModel patchYDivisions asFloat - (modelY / aRMDInterpreter patchLength) * scale)
]

{ #category : 'printing' }
RMDRenderer >> printColor: c on: aStream [

	| colorName |
	colorName := c name.
	(Color registeredColorNames includes: colorName)
		ifTrue: [ aStream nextPutAll: colorName ]
		ifFalse: [ 
			aStream
				nextPut: $#;
				nextPutAll: c asHexString ]
]

{ #category : 'printing' }
RMDRenderer >> printColorOn: aStream [

	self printColor: color on: aStream
]

{ #category : 'rewriting' }
RMDRenderer >> renameAnimat: aString to: anotherString [

	
]

{ #category : 'drawing' }
RMDRenderer >> renderOn: aRMDVisualization with: aRMDInterpreter [

	^ self subclassResponsibility
]

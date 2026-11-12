Class {
	#name : 'RMDPatchRenderer',
	#superclass : 'RMDRenderer',
	#instVars : [
		'borderWidth',
		'borderColor'
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

{ #category : 'drawing' }
RMDPatchRenderer >> draw: aRMDInterpreter scale: aNumber on: aCanvas [

	| xDivisions yDivisions patchLength |
	xDivisions := aRMDInterpreter simulationModel patchXDivisions.
	yDivisions := aRMDInterpreter simulationModel patchYDivisions.
	patchLength := aRMDInterpreter simulationModel patchLength.
	aRMDInterpreter patchesDo: [ :patch |
			| rect |
			rect := aRMDInterpreter geometryFromPatch: patch.
			self
				drawPatch: patch
				interpreter: aRMDInterpreter
				bounds: ((self
						  pointFromX: rect left
						  y: rect bottom
						  interpreter: aRMDInterpreter
						  scale: aNumber) corner: (self
							  pointFromX: rect right
							  y: rect top
							  interpreter: aRMDInterpreter
							  scale: aNumber))
				on: aCanvas ].
	0 to: xDivisions do: [ :x |
			aCanvas
				line: x * aNumber @ 0
				to: x * aNumber @ (yDivisions * aNumber)
				width: borderWidth
				color: borderColor ].
	0 to: yDivisions do: [ :y |
			aCanvas
				line: 0 @ (y * aNumber)
				to: xDivisions * aNumber @ (y * aNumber)
				width: borderWidth
				color: borderColor ]
]

{ #category : 'drawing' }
RMDPatchRenderer >> drawPatch: aNumber interpreter: aRMDInterpreter bounds: aRectangle on: aFormCanvas [
	^ self subclassResponsibility
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

{ #category : 'testing' }
RMDPatchRenderer >> isPatchRenderer [
	^ true
]

Class {
	#name : 'RMDAnimatIconRenderer',
	#superclass : 'RMDAnimatRenderer',
	#instVars : [
		'iconName',
		'scale',
		'icon'
	],
	#category : 'ReMobidyc-Visualization',
	#package : 'ReMobidyc-Visualization'
}

{ #category : 'instance creation' }
RMDAnimatIconRenderer class >> on: aString iconName: anotherString [

	<script:
	'(RMDAnimatIconRenderer on: ''Goat'' iconName: ''goat.png'') inspect'>
	^ (self on: aString)
		  iconName: anotherString;
		  yourself
]

{ #category : 'instance creation' }
RMDAnimatIconRenderer class >> on: aString iconName: anotherString scale: aNumber [

	<script:
	'(RMDAnimatIconRenderer on: ''Goat'' iconName: ''goat.png'') inspect'>
	^ (self on: aString)
		  iconName: anotherString;
		  scale: aNumber;
		  yourself
]

{ #category : 'comparing' }
RMDAnimatIconRenderer >> = anObject [

	^ super = anObject and: [ iconName = anObject iconName ]
]

{ #category : 'defaults' }
RMDAnimatIconRenderer >> defaultScale [
	^ 1.0
]

{ #category : 'comparing' }
RMDAnimatIconRenderer >> hash [

	^ super hash bitXor: iconName hash
]

{ #category : 'accessing' }
RMDAnimatIconRenderer >> iconName [

	^ iconName
]

{ #category : 'accessing' }
RMDAnimatIconRenderer >> iconName: aString [

	iconName := aString
]

{ #category : 'enumerating' }
RMDAnimatIconRenderer >> iconNamesDo: aBlock [

	iconName ifNotNil: [ aBlock value: iconName ]
]

{ #category : 'initialization' }
RMDAnimatIconRenderer >> initialize [ 
	super initialize.
	scale := self defaultScale
]

{ #category : 'initialization' }
RMDAnimatIconRenderer >> initializeWith: aRMDInterpreter [

	super initializeWith: aRMDInterpreter.
	icon := (aRMDInterpreter simulationModel iconAt: iconName ifAbsent: [ ^ self ]) magnifyBy: scale
]

{ #category : 'accessing' }
RMDAnimatIconRenderer >> name [

	^ 'icon renderer'
]

{ #category : 'printing' }
RMDAnimatIconRenderer >> printOn: aStream [

	aStream
		nextPutAll: animat;
		nextPutAll: ' -> "';
		nextPutAll: (iconName asString copyReplaceAll: '"' with: '\" ');
		nextPutAll: '" '.
	scale printOn: aStream.
	aStream nextPutAll: 'x icon.'.
	aStream cr
]

{ #category : 'drawing' }
RMDAnimatIconRenderer >> renderAt: aPoint on: aRMDVisualizer [

	aRMDVisualizer drawImage: icon at: aPoint
]

{ #category : 'accessing' }
RMDAnimatIconRenderer >> scale [
	^ scale
]

{ #category : 'accessing' }
RMDAnimatIconRenderer >> scale: aNumber [
	scale := aNumber asFloat
]

Class {
	#name : 'RMDAnimatShapeRenderer',
	#superclass : 'RMDAnimatRenderer',
	#instVars : [
		'shapeSize'
	],
	#category : 'ReMobidyc-Visualization',
	#package : 'ReMobidyc-Visualization'
}

{ #category : 'testing' }
RMDAnimatShapeRenderer class >> isAbstract [

	^ self == RMDAnimatShapeRenderer
]

{ #category : 'instance creation' }
RMDAnimatShapeRenderer class >> on: aString shapeSize: anInteger color: aColor [

	^ (self on: aString)
		  shapeSize: anInteger;
		  color: aColor;
		  yourself
]

{ #category : 'comparing' }
RMDAnimatShapeRenderer >> = anObject [

	^ super = anObject and: [ shapeSize = anObject shapeSize ]
]

{ #category : 'defaults' }
RMDAnimatShapeRenderer >> defaultShapeSize [

	^ 3
]

{ #category : 'comparing' }
RMDAnimatShapeRenderer >> hash [

	^ super hash bitXor: shapeSize hash
]

{ #category : 'initialization' }
RMDAnimatShapeRenderer >> initialize [

	super initialize.
	shapeSize := self defaultShapeSize
]

{ #category : 'accessing' }
RMDAnimatShapeRenderer >> shapeSize [

	^ shapeSize
]

{ #category : 'accessing' }
RMDAnimatShapeRenderer >> shapeSize: anInteger [

	shapeSize := anInteger asInteger
]

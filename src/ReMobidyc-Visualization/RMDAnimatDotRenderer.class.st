Class {
	#name : 'RMDAnimatDotRenderer',
	#superclass : 'RMDAnimatShapeRenderer',
	#category : 'ReMobidyc-Visualization',
	#package : 'ReMobidyc-Visualization'
}

{ #category : 'drawing' }
RMDAnimatDotRenderer >> drawIndividual: anInteger with: aRMDInterpreter at: aPoint on: aCanvas [

	aCanvas
		fillOval: (Rectangle center: aPoint extent: self shapeSize asPoint)
		color: self color
]

{ #category : 'accessing' }
RMDAnimatDotRenderer >> name [
	^ 'dot renderer'
]

{ #category : 'printing' }
RMDAnimatDotRenderer >> printOn: aStream [

	aStream
		nextPutAll: animat;
		nextPutAll: ' -> '.
	shapeSize printOn: aStream.
	aStream nextPutAll: ' pixels '.
	self printColorOn: aStream.
	aStream nextPutAll: ' dot.'.
	aStream cr
]

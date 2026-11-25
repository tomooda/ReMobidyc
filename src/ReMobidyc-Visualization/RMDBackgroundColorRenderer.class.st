Class {
	#name : 'RMDBackgroundColorRenderer',
	#superclass : 'RMDBackgroundRenderer',
	#category : 'ReMobidyc-Visualization',
	#package : 'ReMobidyc-Visualization'
}

{ #category : 'instance creation' }
RMDBackgroundColorRenderer class >> black [
	^ self color: Color black
]

{ #category : 'instance creation' }
RMDBackgroundColorRenderer class >> blue [
	^ self color: Color blue
]

{ #category : 'instance creation' }
RMDBackgroundColorRenderer class >> color: aColor [
	^ self new
		color: aColor;
		yourself
]

{ #category : 'instance creation' }
RMDBackgroundColorRenderer class >> red [
	^ self color: Color red
]

{ #category : 'instance creation' }
RMDBackgroundColorRenderer class >> white [
	^ self color: Color white
]

{ #category : 'testing' }
RMDBackgroundColorRenderer >> isWorldRenderer [
	^ true
]

{ #category : 'accessing' }
RMDBackgroundColorRenderer >> name [
	^ 'background color'
]

{ #category : 'printing' }
RMDBackgroundColorRenderer >> printOn: aStream [

	aStream nextPutAll: 'World -> '.
	self printColorOn: aStream.
	aStream
		nextPut: $.;
		cr
]

{ #category : 'drawing' }
RMDBackgroundColorRenderer >> renderOn: aRMDVisualizer [

	aRMDVisualizer drawRectangle: (Rectangle origin: 0.0 @ 0.0 corner: aRMDVisualizer worldExtent) color: self color
]

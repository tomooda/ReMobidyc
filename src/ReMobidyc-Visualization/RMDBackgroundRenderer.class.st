Class {
	#name : 'RMDBackgroundRenderer',
	#superclass : 'RMDRenderer',
	#category : 'ReMobidyc-Visualization',
	#package : 'ReMobidyc-Visualization'
}

{ #category : 'testing' }
RMDBackgroundRenderer class >> isAbstract [

	^ self == RMDBackgroundRenderer
]

{ #category : 'defaults' }
RMDBackgroundRenderer >> defaultColor [
	^ Color black
]

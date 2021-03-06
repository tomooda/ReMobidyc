Class {
	#name : #RMDRepository,
	#superclass : #Object,
	#category : #'ReMobidyc-Repository'
}

{ #category : #accessing }
RMDRepository >> actionIdentifiers [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDRepository >> actionNamed: aString ifAbsent: errorBlock [
	^ self subclassResponsibility 
]

{ #category : #accessing }
RMDRepository >> actionNames [
	^ self subclassResponsibility
]

{ #category : #testing }
RMDRepository >> includesActionIdentifier: aRMDActionIdentifierNode [
	^ self actionIdentifiers includes: aRMDActionIdentifierNode
]

{ #category : #accessing }
RMDRepository >> repositoryName [
	^ self subclassResponsibility
]

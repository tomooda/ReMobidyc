Class {
	#name : 'RMDLessThanNode',
	#superclass : 'RMDBinaryRelationNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDLessThanNode >> isLessThanNode [
	^ true
]

{ #category : 'accessing' }
RMDLessThanNode >> operator [
	^ ' < '
]

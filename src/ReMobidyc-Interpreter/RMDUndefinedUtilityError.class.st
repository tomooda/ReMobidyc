Class {
	#name : 'RMDUndefinedUtilityError',
	#superclass : 'RMDUnresolvedReferenceError',
	#category : 'ReMobidyc-Interpreter-Exceptions',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Exceptions'
}

{ #category : 'private' }
RMDUndefinedUtilityError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Undefined utility: '.
		  node printOn: stream.
		  stream nextPutAll: '.' ]
]

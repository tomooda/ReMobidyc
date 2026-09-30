Extension { #name : 'RMDDirectionOfGradientDirectiveNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDDirectionOfGradientDirectiveNode >> evalIn: aRMDInterpreter [

	| attribute here west east south north vector |
	patchAttributeVariable isPlaceholderNode ifTrue: [ ^ RMDUnresolvedPlaceholderError signal: patchAttributeVariable ].
	attribute := patchAttributeVariable identifier.
	here := aRMDInterpreter heres: attribute.
	east := aRMDInterpreter easts: attribute ifAbsent: [ here ].
	west := aRMDInterpreter wests: attribute ifAbsent: [ here ].
	south := aRMDInterpreter souths: attribute ifAbsent: [ here ].
	north := aRMDInterpreter norths: attribute ifAbsent: [ here ].
	vector := east - west @ (north - south).
	(east <= here and: [ west <= here and: [ south <= here and: [ north <= here ] ] ]) ifTrue: [
		^ aRMDInterpreter random * 2.0 * Float pi ].
	^ vector theta ifNanOrInfinite: [ RMDNotComputableError signal: self ]
]

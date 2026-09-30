Extension { #name : 'RMDDirectionOfMaximumInFourNeighborsDirectiveNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDDirectionOfMaximumInFourNeighborsDirectiveNode >> evalIn: aRMDInterpreter [

	| attribute best direction value |
	patchAttributeVariable isPlaceholderNode ifTrue: [ ^ RMDUnresolvedPlaceholderError signal: patchAttributeVariable ].
	attribute := patchAttributeVariable identifier.
	best := aRMDInterpreter heres: attribute.
	direction := nil.
	best < (value := aRMDInterpreter easts: attribute ifAbsent: [ best ]) ifTrue: [
			best := value.
			direction := 0.0 ].
	best < (value := aRMDInterpreter wests: attribute ifAbsent: [ best ]) ifTrue: [
			best := value.
			direction := Float pi ].
	best < (value := aRMDInterpreter souths: attribute ifAbsent: [ best ]) ifTrue: [
			best := value.
			direction := Float pi * 1.5 ].
	best < (aRMDInterpreter norths: attribute ifAbsent: [ best ]) ifTrue: [ direction := Float pi * 0.5 ].
	^ direction ifNil: [ aRMDInterpreter random * 2.0 * Float pi ]
]

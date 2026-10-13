Class {
	#name : 'RMDMorphicMenuButtonAdapter',
	#superclass : 'SpMorphicMenuButtonAdapter',
	#category : 'ReMobidyc-Spec2-Widgets',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Widgets'
}

{ #category : 'widget API' }
RMDMorphicMenuButtonAdapter >> action [

	self presenter menu ifNotNil: [ :aValuable |
			aValuable value ifNotNil: [ :aMenu |
					aMenu owner: self presenter.
					aMenu openWithSpecAtPointer ] ].

	self widget ifNotNil: [ :m | m takeKeyboardFocus ]
]

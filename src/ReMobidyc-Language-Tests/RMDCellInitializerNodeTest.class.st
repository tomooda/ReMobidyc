Class {
	#name : #RMDCellInitializerNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDCellInitializerNodeTest >> testCopyReplace [
	| node replacement |
	node := parser cellInitializer end
		parse:
			'5 x 6 of 10 [m] Cell with
	grass = uniform 1000 [kcal] to 5000 [kcal]'.
	replacement := Dictionary new
		at: 'grass' put: 'sugar';
		at: (parser expression end parse: '1000 [kcal]')
			put: (parser expression end parse: '2000 [kcal]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals:
			(parser cellInitializer end
				parse:
					'5 x 6 of 10 [m] Cell with
	sugar = uniform 2000 [kcal] to 5000 [kcal]')
]

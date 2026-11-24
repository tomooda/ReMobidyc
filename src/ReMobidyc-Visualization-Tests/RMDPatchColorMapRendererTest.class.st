Class {
	#name : 'RMDPatchColorMapRendererTest',
	#superclass : 'RMDRendererTest',
	#category : 'ReMobidyc-Visualization-Tests',
	#package : 'ReMobidyc-Visualization-Tests'
}

{ #category : 'accessing' }
RMDPatchColorMapRendererTest >> renderer [

	^ RMDPatchColorMapRenderer
		  expression: 'here''s val' asRMDExpression
		  color: Color white
		  value: '10' asRMDExpression
		  color: Color gray
		  value: '5' asRMDExpression
		  color: Color black
]

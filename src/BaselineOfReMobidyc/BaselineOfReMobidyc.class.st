Class {
	#name : #BaselineOfReMobidyc,
	#superclass : #BaselineOf,
	#category : 'BaselineOfReMobidyc'
}

{ #category : #baselines }
BaselineOfReMobidyc >> baselineOf: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'P3'
					with: [ spec repository: 'github://svenvc/P3:master/repository' ];
				baseline: 'NeoJSON'
					with: [ spec repository: 'github://svenvc/NeoJSON:master/repository' ];
				baseline: 'ZTimestamp'
					with: [ spec repository: 'github://svenvc/ztimestamp:master/repository' ];
				baseline: 'Glorp'
					with: [ spec repository: 'github://pharo-rdbms/glorp:master/' ].
			spec
				package: 'ReMobidyc-Storage'
					with: [ spec requires: #('P3' 'NeoJSON' 'ZTimestamp' 'Glorp') ];
				package: 'ReMobidyc-Storage-Tests'
					with: [ spec requires: #('ReMobidyc-Storage') ].
			spec
				group: 'default' with: #('core' 'core-tests');
				group: 'core' with: #('ReMobidyc-Storage');
				group: 'core-tests' with: #('ReMobidyc-Storage-Tests') ]
]
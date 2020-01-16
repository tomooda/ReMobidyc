Class {
	#name : #RMDUnit,
	#superclass : #Object,
	#classVars : [
		'KnownUnits'
	],
	#category : #'ReMobidyc-Language-Units'
}

{ #category : #accessing }
RMDUnit class >> at: aString [
	^ KnownUnits at: aString ifAbsent: [ KeyNotFound signal ]
]

{ #category : #accessing }
RMDUnit class >> at: aString ifAbsent: errorBlock [
	^ KnownUnits at: aString ifAbsent: errorBlock
]

{ #category : #accessing }
RMDUnit class >> at: aString ifPresent: aBlock [
	^ KnownUnits at: aString ifPresent: aBlock
]

{ #category : #accessing }
RMDUnit class >> at: aString ifPresent: aBlock ifAbsent: errorBlock [
	^ KnownUnits at: aString ifPresent: aBlock ifAbsent: errorBlock
]

{ #category : #'class initialization' }
RMDUnit class >> initialize [
	<script: 'RMDProportionalUnitSymbol initialize'>
	| register m m2 m3 kg second kelvin joules radian |
	KnownUnits ifNil: [ KnownUnits := Dictionary new ].
	KnownUnits removeAll.
	KnownUnits at: '' put: RMDCompoundUnit noDimension.
	register := [ :unit :variants | 
	KnownUnits at: unit symbol put: unit.
	variants do: [ :symbol | KnownUnits at: symbol asString put: unit ] ].
	"length"
	register value: (m := self newSISymbol: 'm') value: #().
	register
		value: (self newSymbol: 'Mm' scale: 1.0e6 siUnit: m)
		value: #().
	register
		value: (self newSymbol: 'km' scale: 1.0e3 siUnit: m)
		value: #().
	register
		value: (self newSymbol: 'cm' scale: 1.0e-2 siUnit: m)
		value: #().
	register
		value: (self newSymbol: 'mm' scale: 1.0e-3 siUnit: m)
		value: #().
	register
		value: (self newSymbol: 'µm' scale: 1.0e-6 siUnit: m)
		value: #().
	register
		value: (self newSymbol: 'mi' scale: 1609.344 siUnit: m)
		value: #(mile miles).
	register
		value: (self newSymbol: 'yd' scale: 0.9144 siUnit: m)
		value: #(yard yards).
	register
		value: (self newSymbol: 'ft' scale: 0.3048 siUnit: m)
		value: #(feet foot).
	register
		value: (self newSymbol: 'in' scale: 0.0254 siUnit: m)
		value: #(inch inches).
	"mass"
	register value: (kg := self newSISymbol: 'kg') value: #().
	register
		value: (self newSymbol: 't' scale: 1.0e3 siUnit: kg)
		value: #(Mg).
	register
		value: (self newSymbol: 'g' scale: 1.0e-3 siUnit: kg)
		value: #().
	register
		value: (self newSymbol: 'mg' scale: 1.0e-6 siUnit: kg)
		value: #().
	register
		value: (self newSymbol: 'µg' scale: 1.0e-9 siUnit: kg)
		value: #().
	register
		value: (self newSymbol: 'lb' scale: 0.45359237 siUnit: kg)
		value: #().
	register
		value: (self newSymbol: 'oz' scale: 0.028349523125 siUnit: kg)
		value: #().
	register
		value: (self newSymbol: 'gr' scale: 0.00006479891 siUnit: kg)
		value: #().
	"time"
	register
		value: (second := self newSISymbol: 's')
		value: #(sec secs second seconds).
	register
		value: (self newSymbol: 'day' scale: 86400.0 siUnit: second)
		value: #(days).
	register
		value: (self newSymbol: 'h' scale: 3600.0 siUnit: second)
		value: #(hour hours).
	register
		value: (self newSymbol: 'min' scale: 60.0 siUnit: second)
		value: #(mins minute minutes).
	register
		value: (self newSymbol: 'ms' scale: 1.0e-3 siUnit: second)
		value: #(msec milliseconds millisecond).
	register
		value: (self newSymbol: 'µs' scale: 1.0e-6 siUnit: second)
		value: #(µsec microsecond microseconds).
	"temperature"
	register value: (kelvin := self newSISymbol: 'K') value: #(K).
	register
		value:
			(self
				newSymbol: 'C'
				fromSI: [ :t | t - 273.152519 ]
				toSI: [ :t | t + 273.152519 ]
				siUnit: kelvin)
		value: #('°C' '℃').
	register
		value:
			(self
				newSymbol: 'F'
				fromSI: [ :t | t * 1.8 - 459.67 ]
				toSI: [ :t | (t + 459.67) / 1.8 ]
				siUnit: kelvin)
		value: #('°F' '℉').
	"area"
	m2 := m * m.
	register
		value: (self newSymbol: 'ac' scale: 4046.8564224 siUnit: m2)
		value: #().
	register
		value: (self newSymbol: 'a' scale: 100.0 siUnit: m2)
		value: #().
	register
		value: (self newSymbol: 'ha' scale: 1.0e4 siUnit: m2)
		value: #().
	"volume"
	m3 := m2 * m.
	register
		value: (self newSymbol: 'Gl' scale: 1.0e6 siUnit: m3)
		value: #(GL Gℓ).
	register
		value: (self newSymbol: 'Ml' scale: 1.0e3 siUnit: m3)
		value: #(ML Mℓ).
	register
		value: (self newSymbol: 'kl' scale: 1.0 siUnit: m3)
		value: #(kL kℓ '㎘').
	register
		value: (self newSymbol: 'hl' scale: 1.0e-1 siUnit: m3)
		value: #(hL hℓ).
	register
		value: (self newSymbol: 'daL' scale: 1.0e-2 siUnit: m3)
		value: #(dal daℓ).
	register
		value: (self newSymbol: 'l' scale: 1.0e-3 siUnit: m3)
		value: #(L ℓ litre liter).
	register
		value: (self newSymbol: 'dl' scale: 1.0e-6 siUnit: m3)
		value: #(dL dℓ mL mℓ '㎖').
	register
		value: (self newSymbol: 'µl' scale: 1.0e-6 siUnit: m3)
		value: #(µL µℓ).
	"Energy"
	register value: (joules := self newSISymbol: 'J') value: #().
	register
		value: (self newSymbol: 'cal' scale: 4.184 siUnit: joules)
		value: #().
	register
		value: (self newSymbol: 'kcal' scale: 4.184e3 siUnit: joules)
		value: #().
	"angle"
	register value: (radian := self newSISymbol: 'rad') value: #('㎭').
	register
		value: (self newSymbol: 'degree' scale: Float pi / 180.0 siUnit: radian)
		value: #('degrees' '°')
]

{ #category : #constants }
RMDUnit class >> kg [
	^ self at: 'kg'
]

{ #category : #constants }
RMDUnit class >> m [
	^ self at: 'm'
]

{ #category : #'instance creation' }
RMDUnit class >> newSISymbol: aString [
	^ RMDSIUnitSymbol newSISymbol: aString
]

{ #category : #'instance creation' }
RMDUnit class >> newSymbol: aString fromSI: fromNormalUnitBlock toSI: toNormalUnitBlock siUnit: aRMDUnit [
	^ RMDNonProportionalUnitSymbol
		newSymbol: aString
		fromSI: fromNormalUnitBlock
		toSI: toNormalUnitBlock
		siUnit: aRMDUnit
]

{ #category : #'instance creation' }
RMDUnit class >> newSymbol: aString scale: aFloat siUnit: aRMDUnit [
	^ RMDProportionalUnitSymbol
		newSymbol: aString
		scale: aFloat
		siUnit: aRMDUnit
]

{ #category : #constants }
RMDUnit class >> noDimension [
	^ self at: ''
]

{ #category : #constants }
RMDUnit class >> rad [
	^ self at: 'rad'
]

{ #category : #constants }
RMDUnit class >> s [
	^ self at: 's'
]

{ #category : #arithmetics }
RMDUnit >> * aRMDUnit [
	^ self subclassResponsibility
]

{ #category : #arithmetics }
RMDUnit >> ** anInteger [
	^ self subclassResponsibility
]

{ #category : #arithmetics }
RMDUnit >> / aRMDUnit [
	^ self subclassResponsibility
]

{ #category : #'error signalling' }
RMDUnit >> conversionError: aString [
	^ RMDUnitConversionError signal: aString
]

{ #category : #conversions }
RMDUnit >> fromSI: aNumber [
	^ self subclassResponsibility
]

{ #category : #testing }
RMDUnit >> hasDimension [
	^ true
]

{ #category : #testing }
RMDUnit >> isCompound [
	^ self subclassResponsibility
]

{ #category : #testing }
RMDUnit >> isProportional [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDUnit >> siUnit [
	^ self subclassResponsibility
]

{ #category : #enumerating }
RMDUnit >> symbolsAndOrdersDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #conversions }
RMDUnit >> toSI: aNumber [
	^ self subclassResponsibility
]
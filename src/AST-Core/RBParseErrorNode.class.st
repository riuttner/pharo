"
I am a node representing a source code segment that could not be parsed. I am mainly used for source-code coloring where we should parse as far as possible and mark the rest as a failure.

Parsing faulty code without raising a syntax error is done by 
RBParser parseFaultyExpression:
or
RBParser parseFaultyMethod: 

The return value is either valid nodes representing the AST, or nodes representing the valid portion and an RBParseErrorNode for the remaining invalid code.


"
Class {
	#name : 'RBParseErrorNode',
	#superclass : 'ASTValueNode',
	#instVars : [
		'errorMessage',
		'value',
		'start',
		'stop',
		'errorPosition'
	],
	#category : 'AST-Core-Nodes - ErrorNodes',
	#package : 'AST-Core',
	#tag : 'Nodes - ErrorNodes'
}

{ #category : 'comparing' }
RBParseErrorNode >> = anObject [
	self == anObject ifTrue: [^true].
	self class = anObject class ifFalse: [^false].
	^anObject value = value and: [ anObject errorMessage = errorMessage ]
]

{ #category : 'visiting' }
RBParseErrorNode >> acceptVisitor: aProgramNodeVisitor [
	^ aProgramNodeVisitor visitParseErrorNode: self
]

{ #category : 'accessing' }
RBParseErrorNode >> arguments [

	"A parse error node has no arguments"
	^ #()
]

{ #category : 'accessing' }
RBParseErrorNode >> binding: anOCTempVariable [
	"only for compatibility"
]

{ #category : 'accessing' }
RBParseErrorNode >> body: aSequenceNode [
	"I am not a valid MethodNode, but go one with parsing"
]

{ #category : 'accessing' }
RBParseErrorNode >> errorMessage [
	^ errorMessage
]

{ #category : 'accessing' }
RBParseErrorNode >> errorMessage: anObject [
	errorMessage := anObject
]

{ #category : 'accessing' }
RBParseErrorNode >> errorPosition [

	^ errorPosition
]

{ #category : 'accessing' }
RBParseErrorNode >> errorPosition: anObject [

	errorPosition := anObject
]

{ #category : 'testing' }
RBParseErrorNode >> hasTemporaries [

	^ false
]

{ #category : 'comparing' }
RBParseErrorNode >> hash [
	^ (self value hash bitXor: self errorMessage hash)
]

{ #category : 'initialization' }
RBParseErrorNode >> initialize [

	super initialize.
	"Add its own notice"
	self addNotice: (RBSyntaxErrorNotice new)
]

{ #category : 'errors' }
RBParseErrorNode >> isError [
	^true
]

{ #category : 'errors' }
RBParseErrorNode >> isFaulty [
	^true
]

{ #category : 'testing' }
RBParseErrorNode >> isParseError [
	^true
]

{ #category : 'testing' }
RBParseErrorNode >> isUnary [

	^ false
]

{ #category : 'accessing' }
RBParseErrorNode >> name [
	"be polymorphic with variable nodes"

	^ ''
]

{ #category : 'testing' }
RBParseErrorNode >> needsParenthesis [
	^ false
]

{ #category : 'accessing' }
RBParseErrorNode >> selector [
	"A parse error node has an empty selector"
	^ #''
]

{ #category : 'accessing' }
RBParseErrorNode >> selectorParts [

	^ #()
]

{ #category : 'accessing' }
RBParseErrorNode >> source: aString [
	"I am not a valid MethodNode, but go one with parsing"
]

{ #category : 'accessing' }
RBParseErrorNode >> start: aPosition [
	"Beware, start is in fact `startWithoutParentheses` as in ASTValueNode, start includes parentheses"

	start := aPosition
]

{ #category : 'accessing' }
RBParseErrorNode >> startWithoutParentheses [
	^ start
]

{ #category : 'accessing' }
RBParseErrorNode >> stop: aStopPosition [
	"Beware, stop is in fact `stopWithoutParentheses` as in ASTValueNode, stop includes parentheses"

	stop := aStopPosition
]

{ #category : 'accessing' }
RBParseErrorNode >> stopWithoutParentheses [
	^ stop
		ifNil: [start + value size - 1]
		ifNotNil: [ stop ]
]

{ #category : 'accessing' }
RBParseErrorNode >> temporaries [

	^ #()
]

{ #category : 'evaluating' }
RBParseErrorNode >> value [
	^value
]

{ #category : 'accessing' }
RBParseErrorNode >> value: aString [
	value := aString
]

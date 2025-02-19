"
SUnit tests for ASTVariableNode
"
Class {
	#name : 'ASTVariableNodeTest',
	#superclass : 'RBParseTreeTest',
	#category : 'AST-Core-Tests-Nodes',
	#package : 'AST-Core-Tests',
	#tag : 'Nodes'
}

{ #category : 'tests' }
ASTVariableNodeTest >> testIsDefinedByBlock [

	| ast temps args |
	ast := self class compiler parse: 'myMethod: arg
  | test |
  test := 2.
  test.
	[ :test2 | | test3| test2. test3].
  ^test'.
	temps := ast allChildren select: [ :each | each isTempVariable ].
	"test is defined by the method"
	self deny: temps first isDefinedByBlock.
	self deny: temps second isDefinedByBlock.
	self deny: temps third isDefinedByBlock.

	"test3 definition"
	self assert: ast blockNodes first arguments first isDefinedByBlock.
	"test3 definition"
	self assert: temps fourth isDefinedByBlock.
	"test 3 use"
	self assert: temps fifth isDefinedByBlock.
	"and we are out if the block"
	self deny: temps sixth isDefinedByBlock.

	args := ast allChildren select: [ :each | each isArgumentVariable ].
	"method arg"
	self deny: args first isDefinedByBlock.
	self assert: args second isDefinedByBlock.
	"use of test3"
	self assert: args third isDefinedByBlock
]

{ #category : 'tests' }
ASTVariableNodeTest >> testStartForReplacement [

	| source tree dTemporary |
	source := 'foo
	|a b c de d|
	de := 4'.
	tree := self parseMethod: source.
	dTemporary := tree body temporaries last.
	self assert: dTemporary name equals: #d.
	self assert: (source copyFrom: dTemporary start to: dTemporary stop) equals: 'd'.
	self assert: (source copyFrom: dTemporary startForReplacement to: dTemporary stop) equals: ' d'.
	self assert: (dTemporary start - dTemporary startForReplacement) equals: 1
]

{ #category : 'tests' }
ASTVariableNodeTest >> testStartForReplacement02 [

	| source tree dTemporary |
	source := 'foo
	|a b c de

d|
	de := 4'.
	tree := self parseMethod: source.
	dTemporary := tree body temporaries last.
	self assert: dTemporary name equals: #d.
	self assert: (source copyFrom: dTemporary start to: dTemporary stop) equals: 'd'.
	self assert: (source copyFrom: dTemporary startForReplacement to: dTemporary stop) equals: '

d'.
	self assert: (dTemporary start - dTemporary startForReplacement) equals: 2
]

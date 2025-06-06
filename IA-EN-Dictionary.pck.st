'From Cuis7.5 [latest update: #7262] on 6 June 2025 at 12:13:25 pm'!
'Description Enter a word in English or Interlingua and find the corresponding Interlingua or English usage. '!
!provides: 'IA-EN-Dictionary' 1 0!
SystemOrganization addCategory: #'IA-EN-Dictionary'!


!classDefinition: #IEDict category: #'IA-EN-Dictionary'!
Object subclass: #IEDict
	instanceVariableNames: ''
	classVariableNames: 'DictData'
	poolDictionaries: ''
	category: 'IA-EN-Dictionary'!
!classDefinition: 'IEDict class' category: #'IA-EN-Dictionary'!
IEDict class
	instanceVariableNames: ''!


!IEDict commentStamp: '<historical>' prior: 0!
I embody a specialized Dictionary of Interlingua<-->English.

Class intention
	I am not like a regular dictionary because I maintain my definitions 
	in an array of two element arrays #('interlingua definition' 'English definition'). 
	All definitions which contain a search match are returned.

Instance intention
      I am the model of an IEDictWindow
!

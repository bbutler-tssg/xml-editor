xml-editor
==========

XML stylesheet tranformations, to enable repeatable editing of XML files such as Maven 2 `pom.xml` and JPA 2.0 `persistence.xml`

## Introduction

Managing the configuration of a project is prone to error. Often configuration metadata is captured in files that are edited by hand. Care must be taken to ensure that configuration changes are consistent with each other and that the new configuration *state* is valid (in the sense of being self-consistent).

Scripting/automation of configuration changes offers many benefits. When configuration files are simple text files, such as Java properties files, scripted changes can be made using text tools such as sed, awk, perl etc.

However, when configuration files are in a more structured format such as XML or JSON, simple line-oriented text tools are inconvenient. For XML files, XSL was designed to meet the need for (schema-aware) programmatic changes to text files.

This project offers some XSL files to perform common editing tasks on Maven 2 `pom.xml` and JPA 2.0 `persistence.xml` files.

## Scope

For the present, we consider only CRUD operations against Maven pom and JPA persistence xml files.

### Maven

The following *add* (*C*RUD) operations are available

* addDependency
* addPlugin
* addPluginRepository
* addProperty
* addRepository

In addition, the following operations are available to extend and existing pom file to have certain optional elements.

* addChildToBuild
* addChildToProject

The following *update* (CR*U*D) operaqtions are available

* updateElement
* updateProjectDetails
* updateProperty

The following *delete* (CRU*D*) operations are available

* deleteDependency
* deleteElement
* deletePlugin
* deletePluginRepository
* deleteProperty
* deleteRepository

### JPA

The following *add* (*C*RUD) operations are available

* addElement
* addPersistenceUnit
* addProperties
* addProperty

The following *update* (CR*U*D) operaqtions are available

* updateElement
* updateProperty

The following *delete* (CRU*D*) operations are available

* deleteElement
* deletePersistenceUnit
* deleteProperty

## Installation

You need to clone the project to a local directory, say `~/tools/xsl`.

For example, the default download steps (for a Unix-like operating system) would be

	cd ~/tools/xsl
	git clone https://github.com/flatpack/xml-editor.git

It may be convenient to create a variable containing where this project can be found in the local file system, for example

	xslDir=~/tools/xsl/xml-editor

Note that common settings for the transformations can be found in `$xslDir/common/settings.xsl`. You may wish to edit this file, e.g., to switch off indentation, use a different character encoding etc.

## Usage

The following examples use Saxonica's excellent Saxon XSLT processor. However, the transformations all use XSL 1.0 syntax, so other XSLT processors having a command line interface can be used, such as `xsltproc` and `xalan`, with suitable changes to how arguments are specified for the processor in question.

### Maven

Note that the location of the pom.xml to be edited is stored in the `f` variable in the examples below.

\# Update the pom project details so that the `groupId` is *com.my-company*, the `artifactId` is *myproject* and the `version` is *0.1*.

	saxonb-xslt -s:$f -xsl:$xslDir/pom/updateProjectDetails.xsl -o:$f groupId=com.my-company artifactId=myproject version=0.1

\# Add and/or delete the dependency `groupId` = *com.my-company*, `artifactId` = *myOldproject* and `version` = *1.0*

	saxonb-xslt -s:$f -xsl:$xslDir/pom/addDependency.xsl -o:$f groupId=com.my-company artifactId=myOldProject version=1.0
	saxonb-xslt -s:$f -xsl:$xslDir/pom/deleteDependency.xsl -o:$f groupId=com.my-company artifactId=myOldProject version=1.0

\# Add a plugin with extra configuration details for that plugin supplied in a fragment of XML (inserted as is)

	saxonb-xslt -s:$f -xsl:$xslDir/pom/addPlugin.xsl -o:$f groupId=com.my-company artifactId=neededPlugin version=1.0 extraXML=pluginExtra.xml

\# Delete the corresponding plugin

	saxonb-xslt -s:$f -xsl:$xslDir/pom/deletePlugin.xsl -o:$f groupId=com.my-company artifactId=neededPlugin version=1.0

\# Add and delete repositories

	saxonb-xslt -s:$f -xsl:$xslDir/pom/addRepository.xsl -o:$f id=repositoryId url=repositoryUrl name=ARepository
	saxonb-xslt -s:$f -xsl:$xslDir/pom/deleteRepository.xsl -o:$f id=repositoryId url=repositoryUrl name=ARepository

\# Add, update and delete properties

	saxonb-xslt -s:$f -xsl:$xslDir/pom/addProperty.xsl -o:$f propertyName=fruit propertyValue=banana
	saxonb-xslt -s:$f -xsl:$xslDir/pom/updateProperty.xsl -o:$f propertyName=fruit propertyValue=apple
	saxonb-xslt -s:$f -xsl:$xslDir/pom/deleteProperty.xsl -o:$f propertyName=fruit

\# Add, update and delete elements

	saxonb-xslt -s:$f -xsl:$xslDir/pom/deleteElement.xsl -o:$f elementName=fruit
	saxonb-xslt -s:$f -xsl:$xslDir/pom/updateElement.xsl -o:$f elementName=fruit elementValue=apple
	saxonb-xslt -s:$f -xsl:$xslDir/pom/addElement.xsl -o:$f elementName=fruit elementValue=banana

### JPA

\# Add and delete `persistenceUnitName` *eclipselinkDerby*

	saxonb-xslt -s:$f -xsl:$xslDir/persistence/addPersistenceUnit.xsl -o:$f persistenceUnitName=eclipselinkDerby transactionType=RESOURCE_LOCAL
	saxonb-xslt -s:$f -xsl:$xslDir/persistence/deletePersistenceUnit.xsl -o:$f persistenceUnitName=eclipselinkDerby persistenceUnit

\# Add, update and delete the property `javax.persistence.jdbc.user` in persistence unit `eclipselinkDerby`

	saxonb-xslt -s:$f -xsl:$xslDir/persistence/addProperty.xsl -o:$f persistenceUnitName=eclipselinkDerby propertyName=javax.persistence.jdbc.user propertyValue=SomeUser
	saxonb-xslt -s:$f -xsl:$xslDir/persistence/updateProperty.xsl -o:$f persistenceUnitName=eclipselinkDerby propertyName=javax.persistence.jdbc.user propertyValue=NewUser
	saxonb-xslt -s:$f -xsl:$xslDir/persistence/deleteProperty.xsl -o:$f persistenceUnitName=eclipselinkDerby propertyName=javax.persistence.jdbc.user

\# Add, update and delete the element `fruit` in persistence unit `eclipselinkDerby`

	saxonb-xslt -s:$f -xsl:$xslDir/persistence/addElement.xsl -o:$f persistenceUnitName=eclipselinkDerby elementName=fruit elementValue=apple
	saxonb-xslt -s:$f -xsl:$xslDir/persistence/updateElement.xsl -o:$f persistenceUnitName=eclipselinkDerby elementName=fruit elementValue=banana
	saxonb-xslt -s:$f -xsl:$xslDir/persistence/deleteElement.xsl -o:$f persistenceUnitName=eclipselinkDerby elementName=fruit

## Expected results

The Maven and JPA configuration files can be edited in a way that is predictable, e.g., if an attempt is made to *reapply* an operation such as adding a particular element, the configuration is unchanged.

Instance: crmi-package
InstanceOf: OperationDefinition
Title: "CRMI Package Operation"
Usage: #definition
* insert DefinitionMetadata
* name = "CRMIPackage"
* title = "CRMI Package"
* description = """
Packages a specified canonical resource with dependencies.

See [$package and $data-requirements](introduction.html#distribution-fhir-package)
"""
* comment = """
TODO: More documentation about the operation, including inline examples:

```json
{
  "resourceType": "Bundle"
}
```
"""
* kind = #operation
* code = #crmi.package
* resource[+] = #ActivityDefinition
* resource[+] = #CapabilityStatement
* resource[+] = #ChargeItemDefinition
* resource[+] = #CodeSystem
* resource[+] = #CompartmentDefinition
* resource[+] = #ConceptMap
* resource[+] = #EffectEvidenceSynthesis
* resource[+] = #EventDefinition
* resource[+] = #Evidence
* resource[+] = #EvidenceVariable
* resource[+] = #ExampleScenario
* resource[+] = #GraphDefinition
* resource[+] = #ImplementationGuide
* resource[+] = #Library
* resource[+] = #Measure
* resource[+] = #MessageDefinition
* resource[+] = #NamingSystem
* resource[+] = #OperationDefinition
* resource[+] = #PlanDefinition
* resource[+] = #Questionnaire
* resource[+] = #ResearchDefinition
* resource[+] = #ResearchElementDefinition
* resource[+] = #RiskEvidenceSynthesis
* resource[+] = #SearchParameter
* resource[+] = #StructureDefinition
* resource[+] = #StructureMap
* resource[+] = #TerminologyCapabilities
* resource[+] = #TestScript
* resource[+] = #ValueSet
* system = false
* type = true
* instance = true

* parameter[+]
  * name = #id
  * min = 0
  * max = "1"
  * use = #in
  * type = #string
  * documentation = "The logical id of an existing Resource to package on the server."

* parameter[+]
  * name = #url
  * min = 0
  * max = "1"
  * use = #in
  * type = #uri
  * documentation = "A canonical reference to a Resource to package on the server."

* parameter[+]
  * name = #version
  * min = 0
  * max = "1"
  * use = #in
  * type = #string
  * documentation = "The version of the Resource"

* parameter[+]
  * name = #identifier
  * min = 0
  * max = "1"
  * use = #in
  * type = #string
  * searchType = #token 
  * documentation = "A business identifier of the Resource."

* parameter[+]
  * name = #capability
  * min = 0
  * max = "*"
  * use = #in
  * type = #string
  * documentation = """
A desired capability of the resulting package. `computable` to include
computable elements in packaged content; `executable` to include executable
elements in packaged content; `publishable` to include publishable elements in
packaged content.
"""

* parameter[+]
  * name = #canonicalVersion
  * min = 0
  * max = "*"
  * use = #in
  * type = #canonical
  * documentation = """
Specifies a version to use for a canonical resource if the artifact referencing 
the resource does not already specify a version. The format is the same as a canonical URL:
[url]|[version] - e.g. http://loinc.org|2.56 Note that this is a generalization of the `system-version`
parameter to the $expand operation to apply to any canonical resource, including code systems.
"""

* parameter[+]
  * name = #checkCanonicalVersion
  * min = 0
  * max = "*"
  * use = #in
  * type = #canonical
  * documentation = """
Edge Case: Specifies a version to use for a canonical resource. If the artifact referencing 
the resource specifies a different version, an error is returned instead of the package. The
format is the same as a canonical URL: [url]|[version] - e.g. http://loinc.org|2.56 Note that
this is a generalization of the `check-system-version` parameter to the $expand operation to 
apply to any canonical resource, including code systems.
"""

* parameter[+]
  * name = #forceCanonicalVersion
  * min = 0
  * max = "*"
  * use = #in
  * type = #canonical
  * documentation = """
Edge Case: Specifies a version to use for a canonical resource. This parameter overrides any
specified version in the artifact (and any artifacts it depends on). The
format is the same as a canonical URL: [system]|[version] - e.g.
http://loinc.org|2.56. Note that this has obvious safety issues, in that it may
result in a value set expansion giving a different list of codes that is both
wrong and unsafe, and implementers should only use this capability reluctantly.
It primarily exists to deal with situations where specifications have fallen
into decay as time passes. If the version of a canonical is overriden, the version used SHALL
explicitly be represented in the expansion parameters. Note that this is a generalization of the
`force-system-version` parameter to the $expand operation to apply to any canonical resource,
including code systems.
"""

* parameter[+]
  * name = #manifest
  * min = 0
  * max = "1"
  * use = #in
  * type = #canonical
  * documentation = """
Specifies an asset-collection library that defines version bindings for code
systems and other canonical resources referenced by the value set(s) being expanded
and other canonical resources referenced by the artifact. When specified, code
systems and other canonical resources identified as `depends-on` related artifacts 
in the manifest library have the same meaning as specifying that code system or other
canonical version in the `system-version` parameter of an expand or the `canonicalVersion` 
parameter.
"""

* parameter[+]
  * name = #offset
  * min = 0
  * max = "1"
  * use = #in
  * type = #integer
  * documentation = """
Paging support - where to start if a subset is desired (default = 0). Offset is
number of records (not number of pages)
"""

* parameter[+]
  * name = #count
  * min = 0
  * max = "1"
  * use = #in
  * type = #integer
  * documentation = """
Paging support - how many resources should be provided in a partial page view.
If count = 0, the client is asking how large the package is.
"""

* parameter[+]
  * name = #include
  * min = 0
  * max = "*"
  * use = #in
  * type = #string
  * documentation = """
Specifies what contents should be included in the resulting package. The codes indicate which types of resources should be included, but note that
the set of possible resources is determined as all known (i.e. present on the server) dependencies and related artifacts. Possible
values are:
* all (default) - all resource types
* artifact - the specified artifact
* canonical - canonical resources (i.e. resources with a defined url element or that can be canonical resources using the artifact-url extension)
* terminology - terminology resources (i.e. CodeSystem, ValueSet, NamingSystem, ConceptMap)
* conformance - conformance resources (i.e. StructureDefinition, StructureMap, SearchParameter, CompartmentDefinition)
* profiles - profile definitions (i.e. StructureDefinition resources that define profiles)
* extensions - extension definitions (i.e. StructureDefinition resources that define extensions) 
* knowledge - knowledge artifacts (i.e. ActivityDefinition, Library, PlanDefinition, Measure, Questionnaire)
* tests - test cases and data (i.e. test cases as defined by the testing specification in this implementation guide)
* examples - example resources (i.e. resources identified as examples in the implementation guide)
"""

* parameter[+]
  * name = #packageOnly
  * min = 0
  * max = "1"
  * use = #in
  * type = #boolean
  * documentation = """
True to indicate that the resulting package should only include resources that are defined in the implementation guide 
or specification that defines the artifact being packaged. False (default) to indicate that the resulting package should 
include resources regardless of what implementation guide or specification they are defined in.
"""

* parameter[+]
  * name = #contentEndpoint
  * min = 0
  * max = "1"
  * use = #in
  * type = #Endpoint
  * documentation = """
An endpoint to use to access content (i.e. libraries, activities, measures, questionnaires, and plans) referenced by the
artifact. If no content endpoint is supplied the evaluation will attempt to
retrieve content from the server on which the operation is being performed. 
"""

* parameter[+]
  * name = #terminologyEndpoint
  * min = 0
  * max = "1"
  * use = #in
  * type = #Endpoint
  * documentation = """
An endpoint to use to access terminology (i.e. valuesets, codesystems, naming systems, concept maps, and
membership testing) referenced by the Resource. If no terminology endpoint is
supplied, the evaluation will attempt to use the server on which the operation
is being performed as the terminology server.
"""

// Output parameter
* parameter[+]
  * name = #return
  * min = 1 
  * max = "1"
  * use = #out
  * type = #Bundle
  * documentation = """
  The result of the packaging. Servers generating packages SHALL include all the
  dependency resources referenced by the artifact that are known to the server and 
  specified by the include parameters. 
  
  For example, a measure repository SHALL include
  all the required library resources, but would not necessarily have the
  ValueSet resources referenced by the measure.
  """
alias Acl.Accessibility.ByQuery, as: AccessByQuery
alias Acl.GraphSpec.Constraint.Resource, as: ResourceConstraint
alias Acl.GraphSpec, as: GraphSpec
alias Acl.GroupSpec, as: GroupSpec
alias Acl.GroupSpec.GraphCleanup, as: GraphCleanup

defmodule Acl.UserGroups.Config do
  def user_groups do
    # These elements are walked from top to bottom.  Each of them may
    # alter the quads to which the current query applies.  Quads are
    # represented in three sections: current_source_quads,
    # removed_source_quads, new_quads.  The quads may be calculated in
    # many ways.  The useage of a GroupSpec and GraphCleanup are
    # common.
    [
      # // ORGANIZATION HAS POSSIBLY DUPLICATE USER DATA
      %GroupSpec{
        name: "org",
        useage: [:read, :write, :read_for_write],
        access: %AccessByQuery{
          vars: ["session_group"],
          query: "PREFIX ext: <http://mu.semte.ch/vocabularies/ext/>
                  PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
                  SELECT DISTINCT ?session_group WHERE {
                    <SESSION_ID> ext:sessionGroup/mu:uuid ?session_group.
                    }" },
        graphs: [ %GraphSpec{
                    graph: "http://mu.semte.ch/graphs/organizations/",
                    constraint: %ResourceConstraint{
                      resource_types: [
                        "http://xmlns.com/foaf/0.1/Person",
                        "http://xmlns.com/foaf/0.1/OnlineAccount",
                        "http://www.w3.org/ns/adms#Identifier",
                        "http://mu.semte.ch/vocabularies/ext/FormNode",
                        "http://mu.semte.ch/vocabularies/ext/FormInput",
                        "http://mu.semte.ch/vocabularies/ext/InputState",
                        "http://mu.semte.ch/vocabularies/ext/DynamicSubform",
                        "http://mu.semte.ch/vocabularies/ext/supervision/InzendingVoorToezicht",
                        "http://mu.semte.ch/vocabularies/ext/supervision/TaxRate",
                        "http://mu.semte.ch/vocabularies/ext/supervision/SimplifiedTaxRate",
                        "http://mu.semte.ch/vocabularies/ext/FormSolution",
                        "http://mu.semte.ch/vocabularies/ext/DocumentStatus",
                        "http://mu.semte.ch/vocabularies/ext/supervision/InzendingType",
                        "http://mu.semte.ch/vocabularies/ext/supervision/DecisionType",
                        "http://mu.semte.ch/vocabularies/ext/supervision/RegulationType",
                        "http://mu.semte.ch/vocabularies/ext/supervision/TaxType",
                        "http://mu.semte.ch/vocabularies/ext/supervision/Nomenclature",
                        "http://mu.semte.ch/vocabularies/ext/supervision/FiscalPeriod",
                        "http://mu.semte.ch/vocabularies/ext/supervision/DeliveryReportType",
                        "http://mu.semte.ch/vocabularies/ext/supervision/AccountAcceptanceStatus",
                        "http://mu.semte.ch/vocabularies/ext/supervision/DocumentAuthenticityType",
                        "http://mu.semte.ch/vocabularies/ext/FileAddress",
                        "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#FileDataObject",
                        "http://www.w3.org/ns/prov#Location",
                        "http://mu.semte.ch/vocabularies/ext/BestuurseenheidClassificatieCode",
                        "http://data.vlaanderen.be/ns/besluit#Bestuursorgaan",
                        "http://mu.semte.ch/vocabularies/ext/BestuursorgaanClassificatieCode",
                        "http://data.vlaanderen.be/ns/besluit#Bestuurseenheid",
                        "http://mu.semte.ch/vocabularies/ext/supervision/InzendingVoorToezichtMelding",
                        "http://mu.semte.ch/vocabularies/ext/supervision/MeldingStatus"
                      ] } } ] },

      # // CLEANUP
      #
      %GraphCleanup{
        originating_graph: "http://mu.semte.ch/application",
        useage: [:write],
        name: "clean"
      }
    ]
  end
end

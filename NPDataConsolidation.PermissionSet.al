permissionset 50430 "NP DataConsolidation"
{
    Assignable = true;
    Permissions = tabledata "NP Company List Update" = RIMD,
        tabledata "NP Data Management Log" = RIMD,
        tabledata "NP Modular Plus Setup" = RIMD,
        tabledata "NP Modular Plus Vendors" = RIMD,
        table "NP Company List Update" = X,
        table "NP Data Management Log" = X,
        table "NP Modular Plus Setup" = X,
        table "NP Modular Plus Vendors" = X,
        codeunit "NP Data Consolidation" = X,
        codeunit "NP DataConsolidationJobQueue" = X,
        page "NP Company Update List" = X,
        page "NP Modular Plus Setup" = X,
        page "NP Modular Plus Vendors" = X,
        page "NP UpdateDataMaster" = X,
        tabledata "NP Customers" = RIMD,
        table "NP Customers" = X;
}
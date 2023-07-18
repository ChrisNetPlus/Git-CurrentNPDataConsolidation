page 50450 "NP Company Update List"
{
    ApplicationArea = All;
    Caption = 'Company Update List';
    PageType = List;
    SourceTable = "NP Company List Update";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company Name field.';
                }
                field("Update"; Rec.Update)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies which company to update with new / ameded data.';
                }
                field("Master Company"; Rec."Master Company")
                {
                    ApplicationArea = All;
                    ToolTip = 'This determines which company is the master company';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Update Vendors")
            {
                ApplicationArea = All;
                Caption = 'Update Vendors';
                ToolTip = 'Update Vendors in selected companies';
                Image = Insert;

                trigger OnAction()
                var
                    DataConsolidationCU: Codeunit "NP Data Consolidation";
                begin
                    DataConsolidationCU.UpdateVendor();
                end;
            }
            action("Update Customers")
            {
                ApplicationArea = All;
                Caption = 'Update Customers';
                ToolTip = 'Update Customers in selected companies';
                Image = UpdateDescription;

                trigger OnAction()
                var
                    DataConsolidationCU: Codeunit "NP Data Consolidation";
                begin
                    DataConsolidationCU.UpdateCustomer();
                end;
            }
            action("Update GL Codes")
            {
                ApplicationArea = All;
                Caption = 'Update GL Codes';
                ToolTip = 'Update GL Codes in selected companies';
                Image = InsertAccount;

                trigger OnAction()
                var
                    DataConsolidationCU: Codeunit "NP Data Consolidation";
                begin
                    DataConsolidationCU.UpdateGL();
                end;
            }
            action("Update Dimensions")
            {
                ApplicationArea = All;
                Caption = 'Update Dimension Values';
                ToolTip = 'Update Dimension Values in selected companies';
                Image = CopyDimensions;

                trigger OnAction()
                var
                    DataConsolidationCU: Codeunit "NP Data Consolidation";
                begin
                    DataConsolidationCU.UpdateDimensionValue();
                end;
            }
            action("Update Items")
            {
                ApplicationArea = All;
                Caption = 'Update Items';
                ToolTip = 'Update Items in selected companies';
                Image = CopyDimensions;

                trigger OnAction()
                var
                    DataConsolidationCU: Codeunit "NP Data Consolidation";
                begin
                    DataConsolidationCU.UpdateItems();
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        Company: Record Company;
        CompanyList: Record "NP Company List Update";
    begin
        Company.SetFilter(Name, '<>%1', CompanyName);
        if Company.FindSet() then
            repeat
                CompanyList."Company Name" := Company.Name;
                CompanyList.Update := false;
                CompanyList."Master Company" := CheckConsolidationEnabled(Company.Name);
                if not CompanyList.Insert() then
                    CompanyList.Modify();
            until Company.Next() = 0;
        Commit();
    end;

    procedure CheckConsolidationEnabled(var CompanyName: Text): Boolean
    var
        Company: Record Company;
        CompanyInf: Record "Company Information";
        Enabled: Boolean;
    begin
        Clear(CompanyInf);
        CompanyInf.ChangeCompany(CompanyName);
        CompanyInf.Get();
        if CompanyInf."NP Master Data Company" = true then
            Enabled := true;
        exit(Enabled);
    end;
}

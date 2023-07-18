tableextension 50430 "NP Company Information Ext" extends "Company Information"
{
    fields
    {
        field(50430; "NP Master Data Company"; Boolean)
        {
            Caption = 'Defines which company is the Master Data Company';
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                if Rec."NP Master Data Company" = true then
                    CheckMasterCompany();
            end;
        }
        field(50431; "NP Limit Changes to Master Co."; Boolean)
        {
            Caption = 'Limit Changes to Master Company';
            DataClassification = SystemMetadata;
        }
        field(50432; "NP Data Company"; Text[30])
        {
            Caption = 'Default Master Data Company';
            TableRelation = Company;
        }
        field(50433; "NP Enable Manual Data Upload"; Boolean)
        {
            Caption = 'Enable Manual Data Upload';
            DataClassification = SystemMetadata;
        }
    }
    local procedure CheckMasterCompany()
    var
        Company: Record Company;
        CompanyInfo: Record "Company Information";
        ErrorTxt: Label 'The Master Data Company is already defined as %1';
    begin
        if Company.FindSet() then
            repeat
                Clear(CompanyInfo);
                CompanyInfo.ChangeCompany(Company.Name);
                if CompanyInfo.FindFirst() then begin
                    if CompanyInfo."NP Master Data Company" then
                        Error(ErrorTxt, Company.Name);
                end;
            until Company.Next() = 0;
    end;
}

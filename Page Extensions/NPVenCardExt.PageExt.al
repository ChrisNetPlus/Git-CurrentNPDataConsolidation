pageextension 50432 "NP VenCardExt" extends "Vendor Card"
{
    trigger OnModifyRecord(): Boolean
    var
        CompanyInfo: Record "Company Information";
        NPlusSetup: Record "NP Modular Plus Setup";
        DataConsolCU: Codeunit "NP Data Consolidation";
        ErrorTxt: Label 'Changes can only be applied in the Master Data Company - contact your administrator';
    begin
        NPlusSetup.Get();
        if NPlusSetup.Vendors = false then
            exit;
        if DataConsolCU.CheckConsolidationEnabled() = 0 then
            exit;
        CompanyInfo.Get();
        If not CompanyInfo."NP Master Data Company" then begin
            if CompanyInfo."NP Limit Changes to Master Co." then
                Error(ErrorTxt);
        end;
        if Rec."NP Consolidated" = true then begin
            Rec."NP Consolidated" := false;
            Rec.Modify();
        end;
    end;
}

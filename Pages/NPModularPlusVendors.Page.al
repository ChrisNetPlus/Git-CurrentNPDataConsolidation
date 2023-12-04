page 50452 "NP Modular Plus Vendors"
{
    ApplicationArea = All;
    Caption = 'Data Transfer - Vendors';
    PageType = List;
    SourceTable = "NP Modular Plus Vendors";
    UsageCategory = Lists;
    // Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company field.';
                    StyleExpr = StyleExprTxt;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                    StyleExpr = StyleExprTxt;
                }
                field(Deleted; Rec.Deleted)
                {
                    ApplicationArea = All;
                    ToolTip = 'This vendor was deleted in the parent company';
                    StyleExpr = StyleExprTxt;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                    StyleExpr = StyleExprTxt;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                    StyleExpr = StyleExprTxt;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address 2 field.';
                    StyleExpr = StyleExprTxt;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the City field.';
                    StyleExpr = StyleExprTxt;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the County field.';
                    StyleExpr = StyleExprTxt;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Code field.';
                    StyleExpr = StyleExprTxt;
                }
                field("Primary Contact No."; Rec."Primary Contact No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Primary Contact No. field.';
                    StyleExpr = StyleExprTxt;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact field.';
                    StyleExpr = StyleExprTxt;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                    StyleExpr = StyleExprTxt;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mobile Phone No. field.';
                    StyleExpr = StyleExprTxt;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the E-Mail field.';
                    StyleExpr = StyleExprTxt;
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Home Page field.';
                    StyleExpr = StyleExprTxt;
                }
                field("Company Registration No."; Rec."Company Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company Registration No. field.';
                    StyleExpr = StyleExprTxt;
                }
                field("Vendor Type"; Rec."Vendor Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Type field.';
                    StyleExpr = StyleExprTxt;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Update All")
            {
                ApplicationArea = All;
                Caption = 'Update All';
                ToolTip = 'This gets all of the current vendor data ready for transfer to the Data Master';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Vendor: Record Vendor;
                    DataConsolidationCU: Codeunit "NP Data Consolidation";
                    Window: Dialog;
                begin
                    Window.Open('##1####################');
                    if Vendor.FindSet() then
                        repeat
                            Window.Update(1, Vendor."No.");
                            DataConsolidationCU.CopyVendorData(Vendor, CompanyName, false);
                        until Vendor.Next() = 0;
                    Window.Close();
                end;
            }
            action("Send to Data Master")
            {
                ApplicationArea = All;
                Caption = 'Send to Data Master';
                ToolTip = 'This sends all of the current vendor data to the Data Master';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    DataConsolidationCU: Codeunit "NP Data Consolidation";
                    ConfirmMesssage: Label 'Do you wish to send the update to the Data Master Company?';
                begin
                    if Confirm(ConfirmMesssage, false) then
                        DataConsolidationCU.UpdateVendors();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        If Rec.Deleted then
            StyleExprTxt := 'Unfavorable'
        else
            StyleExprTxt := '';
    end;

    var
        StyleExprTxt: Text;
}

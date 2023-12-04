page 50451 "NP Modular Plus Setup"
{
    Caption = 'Data Consolidation Setup';
    PageType = Card;
    SourceTable = "NP Modular Plus Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Webservice)
            {
                field("Modular Plus Webservice URL"; Rec."Modular Plus Webservice URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Modular Plus Webservice URL field.';
                }
                field(Username; Rec.Username)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Username field.';
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Password field.';
                }
            }
            group(Defaults)
            {
                AboutText = 'Record Types to Control';
                AboutTitle = 'Record Types to Control';
                field(Customers; Rec.Customers)
                {
                    ApplicationArea = All;
                    ToolTip = 'Switch on to control records centrally';
                }
                field(Vendors; Rec.Vendors)
                {
                    ApplicationArea = All;
                    ToolTip = 'Switch on to control records centrally';
                }
                field("GL Codes"; Rec."GL Codes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Switch on to control records centrally';
                }
                field(Dimensions; Rec.Dimensions)
                {
                    ApplicationArea = All;
                    ToolTip = 'Switch on to control records centrally';
                }
                field(Items; Rec.Items)
                {
                    ApplicationArea = All;
                    ToolTip = 'Switch on to control records centrally';
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
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
}

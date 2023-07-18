page 50451 "NP Modular Plus Setup"
{
    Caption = 'Modular Plus Setup';
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

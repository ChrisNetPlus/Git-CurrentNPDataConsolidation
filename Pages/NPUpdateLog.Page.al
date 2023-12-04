page 50454 "NP Update Log"
{
    ApplicationArea = All;
    Caption = 'Update Log';
    PageType = List;
    SourceTable = "NP Data Management Log";
    UsageCategory = Administration;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry Type field.';
                }
                field("Change Type"; Rec."Change Type")
                {
                    ToolTip = 'Specifies the value of the Change Type field.';
                }
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Specifies the value of the Company Name field.';
                }
                field("Record"; Rec."Record")
                {
                    ToolTip = 'Specifies the value of the Record field.';
                }
                field("Record Date"; Rec."Record Date")
                {
                    ToolTip = 'Specifies the value of the Record Date field.';
                }
                field("Record Type"; Rec."Record Type")
                {
                    ToolTip = 'Specifies the value of the Record Type field.';
                }
            }
        }
    }
}

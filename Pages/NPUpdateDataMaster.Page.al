page 50453 "NP UpdateDataMaster"
{
    Caption = 'Update Data Master';
    PageType = Card;
    UsageCategory = Tasks;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Selections)
            {
                field(Vendors; Vendors)
                {
                    ApplicationArea = All;
                    Caption = 'Vendors';
                    ToolTip = 'Select to update the Modular Plus Vendor List in the Data Master Company';
                    trigger OnValidate()
                    begin
                        Customers := false;
                        Contracts := false;
                        Workstreams := false;
                    end;
                }
                field(Customers; Customers)
                {
                    ApplicationArea = All;
                    Caption = 'Customers';
                    ToolTip = 'Select to update the Modular Plus Customer List in the Data Master Company';
                    Visible = false;
                    trigger OnValidate()
                    begin
                        Vendors := false;
                        Contracts := false;
                        Workstreams := false;
                    end;
                }
                field(Contracts; Contracts)
                {
                    ApplicationArea = All;
                    Caption = 'Contracts';
                    ToolTip = 'Select to update the Modular Plus Contract List in the Data Master Company';
                    trigger OnValidate()
                    begin
                        Customers := false;
                        Vendors := false;
                        Workstreams := false;
                    end;
                }
                field(Workstreams; Workstreams)
                {
                    ApplicationArea = All;
                    Caption = 'Workstreams';
                    ToolTip = 'Select to update the Modular Plus Workstream List in the Data Master Company';
                    trigger OnValidate()
                    begin
                        Customers := false;
                        Contracts := false;
                        Vendors := false;
                    end;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Run Update")
            {
                ApplicationArea = All;
                Caption = 'Run Update';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = UpdateDescription;
                ToolTip = 'Click this to run the selected update';
                trigger OnAction()
                var
                    Contract: Record "Dimension Value";
                    Workstream: Record "Dimension Value";
                    ContractWorkstream: Record "NP Contract Workstreams";
                    DataConsolidationCU: Codeunit "NP Data Consolidation";
                    ConfirmMesssage: Label 'Do you wish to send the update to the Data Master Company?';
                begin
                    if Confirm(ConfirmMesssage, false) then begin
                        if Vendors then
                            DataConsolidationCU.UpdateVendors();
                        if Contracts then begin
                            Contract.SetRange("Dimension Code", 'CONTRACT');
                            if Contract.FindSet() then
                                repeat
                                    DataConsolidationCU.ChangeDimensionValue(Contract);
                                until Contract.Next() = 0;
                        end;
                        if Workstreams then begin
                            Workstream.SetRange("Dimension Code", 'WORKSTREAM');
                            if Workstream.FindSet() then
                                repeat
                                    DataConsolidationCU.ChangeDimensionValue(Workstream);
                                until Workstream.Next() = 0;
                            if ContractWorkstream.FindSet() then
                                repeat
                                    DataConsolidationCU.ChangeDimensionWorkstreamValue(ContractWorkstream);
                                until ContractWorkstream.Next() = 0;
                        end;
                    end;
                end;
            }
        }
    }
    var
        Vendors: Boolean;
        Customers: Boolean;
        Contracts: Boolean;
        Workstreams: Boolean;
}

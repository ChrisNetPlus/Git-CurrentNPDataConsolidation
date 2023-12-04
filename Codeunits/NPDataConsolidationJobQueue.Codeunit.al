codeunit 50431 "NP DataConsolidationJobQueue"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        DataConsolidationCU: Codeunit "NP Data Consolidation";
    begin
        case Rec."Parameter String" of
            'Customer':
                begin
                    DataConsolidationCU.UpdateCustomer();
                end;
            'Vendor':
                begin
                    DataConsolidationCU.UpdateVendor();
                end;
            'GLAccount':
                begin
                    DataConsolidationCU.UpdateGLCode();
                end;
            'Items':
                begin
                    DataConsolidationCU.UpdateItems();
                end;
            'Dimensions':
                begin
                    DataConsolidationCU.UpdateDimensionValue();
                end;
        end;
    end;

}
